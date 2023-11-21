import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget{
  final String title;

  const ListNotes({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
      );
      
  }
}
