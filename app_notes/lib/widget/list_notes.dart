import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget{
  final String title;
  final String subtitle;
  final MaterialColor colorNote;


  const ListNotes({super.key, required this.title, required this.subtitle, required this.colorNote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 0),
          leading: Container(
            color: colorNote,
            height: double.infinity,
            width: 5,
          ),
          minLeadingWidth: 10,
          
          title: Text(
            title,
            style: TextStyle(fontSize: 20)
          ),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
