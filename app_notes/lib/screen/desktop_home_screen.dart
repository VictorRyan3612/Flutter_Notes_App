import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:app_notes/widget/drawer_menu.dart';
import 'package:app_notes/view/load_notes_layout.dart';


class DesktopHomeScreen extends HookWidget {
  final Note? note;
  const DesktopHomeScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {  
    
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
                  actions: [
                    PopupMenuButton(
                      tooltip: "Opções",
                      icon: const Icon(
                        Icons.more_vert, 
                        color: Colors.black
                        ),
                      itemBuilder: (context){
                        return const[
                          PopupMenuItem<int>(
                            value: 0,
                            child: Text("Excluir"),
                          ),
                        ];
                      },
                    
                      onSelected:(value){
                        if(value == 0){
                          noteDataService.deleteNote(noteDataService.aNoteValueNotifier.value[0]);
                          
                          settingsService.desktopLateralView.value = false;
                        }
                      }
                    ),
                  ],
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
                      return ValueListenableBuilder(
                        valueListenable: noteDataService.aNoteValueNotifier,
                        builder: (_, value, __) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: TextField(
                                controller: TextEditingController(text: value[0].content),
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
                          
                                onChanged: (value2) {
                                  value[0].content = value2;
                                  
                                  noteDataService.saveEditedNote(
                                    editedNote: value[0], 
                                    index: value[1]
                                  );
                                  
                                },
                              ),
                            ),
                          );
                        },
                        
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
