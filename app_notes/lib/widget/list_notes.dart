import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget{
  final List<Note> valueNotes;

  const ListNotes({super.key, required this.valueNotes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: valueNotes.length,
      itemBuilder:(_,index) {
        return ListTile(
          title: Text(valueNotes[index].title),
        );
      }
    );
  }
}
