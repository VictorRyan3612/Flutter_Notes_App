import 'package:flutter/material.dart';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/widget/grid_notes.dart';
import 'package:app_notes/widget/list_notes.dart';



class LoadNotesLayout extends StatelessWidget {

  const LoadNotesLayout({super.key});


  @override
  Widget build(BuildContext context) {
    settingsService.loadSettings();
    
    return ValueListenableBuilder(
      valueListenable: settingsService.isGridView,
      builder: (_, isGridViewValue,__) {
        return ValueListenableBuilder(
          valueListenable: noteDataService.notesValueNotifier,
          builder: (_, value,__) {
            if((value['dataObjects'].length == 0) &&
                (value['status'] == TableStatus.ready)){
              return Center(
                child: Text("Não tem Notas")
              ); 
      
            }
            else{
              switch (value['status']) {
                case TableStatus.loading:
                  return CircularProgressIndicator();
                  
                case TableStatus.ready:
                  if(isGridViewValue){
                    return GridNotes(valueNotes: value['dataObjects']);
                  }
                  else{
                    return ListNotes(valueNotes: value['dataObjects'],);
                  }
                  
                } return Container();
              } 
            } 
          );
        },
      );
    }
}
  

  