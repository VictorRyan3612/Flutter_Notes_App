import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final String title;
  final String subtitle;
  final MaterialColor colorNote;

  const GridNotes({super.key, required this.title, required this.subtitle, required this.colorNote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [  
            Container(
              height: 5.0,
              color: colorNote,
              // margin: EdgeInsets.only(bottom: 5),
              width: double.infinity, 
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 10),
              title: Text(
                title,
                style: TextStyle(fontSize: 20)
              ),
              subtitle: Text(subtitle),
            ),
          ]
        ),
      ),
    );
  }
}