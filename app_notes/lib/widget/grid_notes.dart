import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final Note note;

  const GridNotes({super.key, required this.note});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          noteDataService.defContent(note);
          Navigator.pushNamed(context, '/noteDetail');
        },
        child: Card(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [  
              Container(
                height: 5.0,
                color: note.selectColor(note),
                // margin: EdgeInsets.only(bottom: 5),
                width: double.infinity, 
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 10),
                title: Text(
                  note.title,
                  style: TextStyle(fontSize: 20)
                ),
                subtitle: Text(note.content),
              ),
            ]
          ),
        ),
      ),
    );
  }
}