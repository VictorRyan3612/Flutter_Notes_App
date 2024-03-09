import 'package:app_notes/config/settings_data_service.dart';
import 'package:flutter/material.dart';

import '../data/note_data_service.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{


  MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    String titleFinal;
    if (settingsService.currentStatusNotes.value == 'x'){
      titleFinal = "Notas Excluídas";
    } 
    else if (settingsService.currentStatusNotes.value == 'a'){
      titleFinal = "Notas Arquivadas";
    }
    else{
      titleFinal = "Notas";
    }
    
    return AppBar(
      title: Center(
        child: Text(titleFinal)
      ),

      actions: [
        PopupMenuButton(
          tooltip: "Mudar Vizualização",
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context){
            return const[
              PopupMenuItem<int>(
                value: 0,
                child: Text("Lista"),
              ),

              PopupMenuItem<int>(
                value: 1,
                child: Text("Grade"),
              ),
            ];
          },
          
          onSelected:(value){
            if(value == 0){
              settingsService.isGridView.value = false;
              settingsService.saveSettings();
            }else if(value == 1){
              settingsService.isGridView.value = true;
              settingsService.saveSettings();
            }
          }
        ),
        if(!settingsService.isMobile.value && settingsService.currentStatusNotes.value != 'x')
        IconButton(
          tooltip: "Criar Nota",
          onPressed: () async{
            Note newNote = Note(content: '', title: '');
            var indexLastNote = noteDataService.notesValueNotifier.value['dataObjects'].length;

            settingsService.desktopLateralView.value = false;
            settingsService.desktopLateralView.value = true;
            noteDataService.defContent(
              note: newNote, index: indexLastNote
            );
            
            noteDataService.createNote(
              newNote
            );
            
          },
            
          icon: Icon(Icons.add),
        ), 
      ],
    );
  }
}
