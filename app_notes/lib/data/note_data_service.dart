import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import "package:flutter/foundation.dart";

enum TableStatus{idle,loading,ready,error}


class Note {
  late String title;
  late String content;
  late String tag;
  late String status;

  Note(
    {required this.title,
    required this.content,
    this.tag = '',
    this.status = "v"}
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'tag': tag,
      'status': status
    };
  }

  String toJson() => json.encode(toMap());
}

class NoteDataService {

  final ValueNotifier<Map<String,dynamic>> notesValueNotifier = 
    ValueNotifier({
      'status':TableStatus.idle,
      'dataObjects':[],
    });


  List<Note> originalList = [];


  Future<List<Note>> loadNotesFromFile() async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/notes.dat');

    if (file.existsSync()) {
      String content = await file.readAsString();
      if (content != '') {
        List<dynamic> jsonList = json.decode(content);
        List<Note> notesList = jsonList.map((json) => Note(
          title: json['title'],
          content: json['content'],
          tag: json['tag'],
          status: json['status'],
        )).toList();
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


  Future<void> saveNotes(List<Note> notes) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/notes.dat');
    String content = json.encode(notes.map((user) => user.toMap()).toList());
    await file.writeAsString(content);
  }


  void createNote(Note newNote){
    notesValueNotifier.value['dataObjects'] = [...notesValueNotifier.value['dataObjects'], newNote];
    notesValueNotifier.value['dataObjects'] = List<Note>.from(notesValueNotifier.value['dataObjects']);

    saveNotes(notesValueNotifier.value['dataObjects']);
    loadNotes();
  }
}

NoteDataService noteDataService = NoteDataService();
