import 'package:app_notes/screen/note_detail.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:app_notes/widget/drawer_menu.dart';
import 'package:app_notes/widget/list_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/note_data_service.dart';
import '../widget/load_notes_layout.dart';


class DesktopHomeScreen extends HookWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var noteActual = noteDataService.aNoteValueNotifier.value[0];
    final titleController= useTextEditingController(text: noteActual?.title ?? '');
    final contentController= useTextEditingController(text: noteActual?.content ?? '');
    var drawerOpen = false;

    
    return Scaffold(
      drawer: DrawerMenu(),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                MyAppBar(isMobile: false),
                
                Expanded(child: LoadNotesLayout()),
              ],
            )
          ),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    onPressed: (){},
                  icon: Icon(Icons.abc)
                    ), 
                ),
    
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sticky_note_2, 
                        size: 70
                      ),
                      Text(
                        "Nenhuma Nota",
                        style: TextStyle(fontSize: 30),
                      )
                    ]
                  )
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}
