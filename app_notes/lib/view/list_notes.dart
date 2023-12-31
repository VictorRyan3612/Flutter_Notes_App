import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/screen/note_detail.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget{
  final Note note;
  final int index;

  const ListNotes({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    String firstLine = note.content.split('\n').first;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () async {
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
            settingsService.desktopLateralView.value = false;
            settingsService.desktopLateralView.value = true;
            noteDataService.defContent(
              note: note,
              index: index
            );
          }
        },
        child: Card(
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 0),
            leading: Container(
              color: note.selectColor(note),
              height: double.infinity,
              width: 5,
            ),
            minLeadingWidth: 10,
            
            title: Text(
              note.title,
              style: TextStyle(fontSize: 20)
            ),
            subtitle: Text(firstLine),
          ),
        ),
      ),
    );
  }
}
