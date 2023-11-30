import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:app_notes/widget/drawer_menu.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/widget/load_notes_layout.dart';


class DesktopHomeScreen extends HookWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var noteActual = noteDataService.aNoteValueNotifier.value[0];
    final titleController= useTextEditingController(text: noteActual?.title ?? '');
    final contentController= useTextEditingController(text: noteActual?.content ?? '');
  
    
    return Scaffold(
      drawer: DrawerMenu(),
      body: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: settingsService.desktopLoadView,
            builder: (_, value, __) {
              if (value){
                return Expanded(
                  child: Column(
                    children: [
                      MyAppBar(isMobile: false),
                      
                      Expanded(
                        child: LoadNotesLayout()
                      ),
                    ],
                  )
                );
              }
              return Container();
            },),
            
          Expanded(
            child: Column(
              children: [
                AppBar(
                  leading: IconButton(
                    tooltip: "Ativar/Desativar Lista de Notas",
                    onPressed: (){
                      settingsService.desktopLoadView.value = !settingsService.desktopLoadView.value;
                    },
                  icon: Icon(Icons.view_column_outlined)
                    ), 
                ),
    
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sticky_note_2, 
                        size: 70,
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
