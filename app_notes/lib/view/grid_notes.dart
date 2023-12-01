import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/screen/note_detail.dart';
import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final Note note;
  final int index;

  const GridNotes({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async{
          if(settingsService.isMobile.value){
            Note? noteEdited = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetail(
                  currentNote: note,
                ),
              ),
            );

            if (noteEdited != null){
              noteDataService.saveEditedNote(
                editedNote: noteEdited,
                index: index
              );
            }
          }
          else{
            settingsService.desktopLateralView.value = true;
            noteDataService.defContent(
              note: note,
              index: index
            );
          }
        },
        child: Center(
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
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 10),
                      title: Text(
                        note.title,
                        style: TextStyle(fontSize: 20)
                      ),
                      subtitle: Text(note.content),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}