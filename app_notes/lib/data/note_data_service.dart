import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app_notes/config/theme_config.dart';

enum TableStatus{idle,loading,ready,error}


class Note {
  late String title;
  late String content;
  late String tag;
  late String colorNote;
  late String dateCreate;
  late String dateModified;
  late String status;

  Note(
    {
    required this.title,
    required this.content,
    this.tag = '',
    this.colorNote = 'Red',
    this.dateCreate = '',
    this.dateModified = '',
    this.status = 'v'}
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'tag': tag,
      'colorNote': colorNote,
      'dateCreate': dateCreate,
      'dateModified': dateModified,
      'status': status
    };
  }
  
  String toJson() => json.encode(toMap());
  
  returnValuebyField(Note note, String field){
    return note.toMap()[field];
  }
  static Note fromJson(Map<String, dynamic> json){
    return Note(
      title: json['title'],
      content: json['content'],
      tag: json['tag'],
      colorNote: json['colorNote'],
      dateCreate: json['dateCreate'],
      dateModified: json['dateModified'],
      status: json['status'],
    );
  }
  
  MaterialColor selectColor(){
    var colorFinal = searchCodColorByName(colorNote);
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
        title: '',
        content: ''
      ),
      int // index
    ]
  );

  List<String> notesFieldsSortables = ['title','content', 'tag', 'colorNote', 'dateCreate', 'dateModified'];
  List<Note> originalList = [];
  bool isSorted = false;
  
  Map<String, dynamic> checkFields(Map<String, dynamic> json){
    for (String field in notesFieldsSortables) {
      if (!json.containsKey(field)) {
        json[field] = '';
      }
    }
    return json;
  }
  Future<List<Note>> loadNotesFromFile() async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/notes.dat');

    if (file.existsSync()) {
      String content = await file.readAsString();
      if (content != '') {
        List<dynamic> jsonList = json.decode(content);
        List<Note> notesList = jsonList.map((json) {
          json = checkFields(json);

          return Note.fromJson(json);
        }).toList();

        return notesList;
      }
    }

    return [];
  }


  void loadNotes() async {
    List<Note> listNotesLoaded = await loadNotesFromFile();
    notesValueNotifier.value = {
      'status':TableStatus.ready,
      'dataObjects': listNotesLoaded
    };
    originalList = listNotesLoaded;
    saveNotesFile(listNotesLoaded);
  }


  String defSubtitle(Note note, String separator){
    var listSubString = note.content.split('\n');
    var stringfinal = listSubString.skip(1).join(separator);
    return stringfinal;
  }

  Note firstLineToTitle(Note note){
    note.title = note.content.split('\n')[0];
    return note;
  }
  
  defContent({required Note note, required int index}){
    aNoteValueNotifier.value[0] = note;
    aNoteValueNotifier.value[1] = index;
  }

  Future<void> saveNotesFile(List<Note> notes) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/notes.dat');
    String content = json.encode(notes.map((note) => note.toMap()).toList());
    await file.writeAsString(content);
  }

  Future<void> exportNotestoTxt(List<Note> notes) async {
    Directory directory = await getApplicationSupportDirectory();
    Directory directoryNotesFolder = Directory('${directory.path}\\notes');
    directoryNotesFolder.createSync();
    notes.forEach((note) async {
      File file = File('${directoryNotesFolder.path}\\${note.title}.txt');

      file.createSync();
      await file.writeAsString(note.content);
      await file.setLastAccessed(DateTime.parse(note.dateCreate));
      await file.setLastModified(DateTime.parse(note.dateModified));
    });
  }
  void createNote(Note newNote){
    var dateNow = DateTime.now().toString();
    newNote.dateCreate = dateNow;
    newNote.dateModified = dateNow;

    notesValueNotifier.value['dataObjects'] = [...notesValueNotifier.value['dataObjects'], newNote];
    notesValueNotifier.value['dataObjects'] = List<Note>.from(notesValueNotifier.value['dataObjects']);

    saveNotesFile(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }

  saveEditedNote({required Note editedNote, required int index}){
    var dateNow = DateTime.now().toString();
    editedNote.dateModified = dateNow;
    
    editedNote = firstLineToTitle(editedNote);
    notesValueNotifier.value['dataObjects'][index] = editedNote;
    saveNotesFile(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }

   // Filer Note by seach
  void filterCurrentState(String filtrar) {
    List<Note> objectsOriginals = originalList;
    if (objectsOriginals.isEmpty) return;

    List<Note> objectsFiltered = [];
    if (filtrar != '') {
      for (var objetoInd in objectsOriginals) {
        if (
            objetoInd.title.toLowerCase().contains(filtrar.toLowerCase()) ||
            objetoInd.content.toLowerCase().contains(filtrar.toLowerCase())
          ) {
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
    field ??= 'title';
    

    var state = Map<String, dynamic>.from(notesValueNotifier.value);


    if (field != settingsService.dropDownValueText.value){
      isSorted = false;
    }

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
  void deleteNote(Note note) {
    note.status = 'x';
    saveNotesFile(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }
  void restoreNote(Note note) {
    note.status = 'v';
    saveNotesFile(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }
  void archiveNote(Note note) {
    note.status = 'a';
    saveNotesFile(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }
}

NoteDataService noteDataService = NoteDataService();
