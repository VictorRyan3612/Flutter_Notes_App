import 'package:app_notes/widget/app_bar.dart';
import 'package:app_notes/widget/drawer_menu.dart';
import 'package:flutter/material.dart';

import 'package:app_notes/widget/load_notes_layout.dart';

import '../data/note_data_service.dart';


class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      appBar: MyAppBar(isMobile: true),
      body: LoadNotesLayout(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Criar Nota",
        onPressed: (){noteDataService.createNote(
            Note(title: 'Teste', content: 'content')
          );},
        child: Icon(Icons.add),
      ),
    );
  }
}
