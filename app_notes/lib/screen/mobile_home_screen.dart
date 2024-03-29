import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/screen/note_detail.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:app_notes/widget/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'package:app_notes/view/load_notes_layout.dart';

import '../data/note_data_service.dart';


class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: MyAppBar(),
      body: LoadNotesLayout(),
      floatingActionButton: settingsService.currentStatusNotes.value == 'x' ? null : FloatingActionButton(
        tooltip: "Criar Nota",
        onPressed: () async {
          noteDataService.defContent(note: Note(title: '', content: ''), index: 0);
          Note? newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetail(),
            ),
          );
          if (newNote != null){
            noteDataService.createNote(
              newNote
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
