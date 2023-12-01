import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:app_notes/widget/drawer_menu.dart';
import 'package:app_notes/view/load_notes_layout.dart';


class DesktopHomeScreen extends HookWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print({"dektop note ",noteDataService.aNoteValueNotifier.value[0]});
    print({"dektop note content",noteDataService.aNoteValueNotifier.value[0].content});

    var noteActual = noteDataService.aNoteValueNotifier.value[0];
    // final titleController= useTextEditingController(text: noteActual?.title ?? '');
    print({"dektop",noteActual.content});
    final contentController= useTextEditingController(text: noteActual?.content ?? '');
    print(contentController.text);
  
    
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
            },
          ),
            
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
    
                ValueListenableBuilder(
                  valueListenable: settingsService.desktopLateralView,
                  builder: (_, value, __) {
                    if(!value){
                      return Expanded(
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
                      );
                    }
                    else {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: TextField(
                            controller: contentController,
                            autofocus: true,
                            style: TextStyle(fontSize: 20),
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            
                            decoration: InputDecoration(
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Theme.of(context).scaffoldBackgroundColor, // Cor de fundo desejada
                            ),
                      
                            onChanged: (value) {
                              noteActual?.content = value;
                              
                            },
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}
