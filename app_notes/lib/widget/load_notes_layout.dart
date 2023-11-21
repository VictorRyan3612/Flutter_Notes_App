import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/widget/grid_notes.dart';
import 'package:flutter/material.dart';



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
                    return GridNotes2(valueNotes: value['dataObjects']);
                  }
                  else{
                    return ListNotes2();
                  }
                  
                } return Container();
              } 
            } 
          );
        },
      );
    }
}
  

  
  
class GridNotes2 extends StatelessWidget {
  final List<Note> valueNotes;

  const GridNotes2({super.key, required this.valueNotes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: valueNotes.length,
      itemBuilder: (_, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTile(
              child: Text(valueNotes[index].title),
            )
          );
      },

      );
  }
}
class ListNotes2  extends StatelessWidget{
  const ListNotes2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Teste List")
    );
  }
}
