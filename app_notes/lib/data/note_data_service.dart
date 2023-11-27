import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../config/theme_config.dart';

enum TableStatus{idle,loading,ready,error}


class Note {
  late String title;
  late String content;
  late String colorNote;
  late String tag;
  late String status;

  Note(
    {required this.title,
    required this.content,
    this.colorNote = 'Red',
    this.tag = '',
    this.status = "v"}
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'colorNote': colorNote,
      'tag': tag,
      'status': status
    };
  }
  String toJson() => json.encode(toMap());
  
  returnValuebyField(Note note, String field){
    return note.toMap()[field];
  }
  
  
  MaterialColor selectColor(Note note){
    var colorFinal = searchCodColorByName(note.colorNote);
    return colorFinal;
  }

}

class NoteDataService {

  final ValueNotifier<Map<String,dynamic>> notesValueNotifier = 
    ValueNotifier({
      'status':TableStatus.idle,
      'dataObjects':[],
    });

  final ValueNotifier<List> aNoteValueNotifier = ValueNotifier(
    [
      Note(
        title: '', content: ''
      ),
      int
    ]
  );

  List<String> notesFieldsSortables = ['title', 'content', 'tag', 'colorNote'];
  List<Note> originalList = [];
  bool isSorted = false;
  
  Future<List<Note>> loadNotesFromFile() async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/notes.dat');

    if (file.existsSync()) {
      String content = await file.readAsString();
      if (content != '') {
        List<dynamic> jsonList = json.decode(content);
        List<Note> notesList = jsonList.map((json) {
          return Note(
          title: json['title'],
          content: json['content'],
          colorNote: json['colorNote'],
          tag: json['tag'],
          status: json['status'],
        );
        }).toList();
        return notesList;
      }
    }

    return [];
  }


  void loadNotes() async {
    var json = await loadNotesFromFile();
    notesValueNotifier.value = {
      'status':TableStatus.ready,
      'dataObjects': json
    };
    originalList = json;
  }

  defContent(Note note, index){
    aNoteValueNotifier.value[0] = note;
    aNoteValueNotifier.value[1] = index;
  }

  Future<void> saveNotes(List<Note> notes) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/notes.dat');
    String content = json.encode(notes.map((note) => note.toMap()).toList());
    await file.writeAsString(content);
  }


  void createNote(Note newNote){
    notesValueNotifier.value['dataObjects'] = [...notesValueNotifier.value['dataObjects'], newNote];
    notesValueNotifier.value['dataObjects'] = List<Note>.from(notesValueNotifier.value['dataObjects']);

    saveNotes(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }

  saveEditedNote({required Note editedNote, required int index}){
    notesValueNotifier.value['dataObjects'][index] = editedNote;
    saveNotes(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }

   // Filer Note by seach
  void filterCurrentState(String filtrar) {
    List<Note> objectsOriginals = originalList;
    if (objectsOriginals.isEmpty) return;

    List<Note> objectsFiltered = [];
    if (filtrar != '') {
      for (var objetoInd in objectsOriginals) {
        if (objetoInd.title.toLowerCase().contains(filtrar.toLowerCase())) {
          objectsFiltered.add(objetoInd);
        }
      }
    } else {
      objectsFiltered = objectsOriginals;
    }
    

    issueFilteredState(objectsFiltered);
  }


  // Overriding filtered notes in notesStateNotifier.value
  void issueFilteredState(List<Note> objectsFiltered) {
    var state = Map<String, dynamic>.from(notesValueNotifier.value);
    state['dataObjects'] = objectsFiltered;
    notesValueNotifier.value = state;
  }



  // sort notes, still having problems with sorting and editing
  // If a parameter is passed, it will be used as a metric for the ordering, 
  // if a parameter is not passed, the title pattern will be used

  sortByField(String? field) {
    if (field == null){
      field = 'title';
    }
    

    var state = Map<String, dynamic>.from(notesValueNotifier.value);

    if (!isSorted) {

      state['dataObjects'] = List<Note>.from(state['dataObjects']);
      state['dataObjects'].sort((Note a, Note b) {
        String valueA = a.returnValuebyField(a, field!);
        String valueB = b.returnValuebyField(b, field);
        return valueA.compareTo(valueB);
        // return a.returnValuebyField(a, field!).compareTo(b.returnValuebyField(b, field));
      });
      
      notesValueNotifier.value = state;
      isSorted = true;
    } else {
      state['dataObjects'] = List<Note>.from(state['dataObjects'].reversed);
      notesValueNotifier.value = state;
    }
  }
}

NoteDataService noteDataService = NoteDataService();
