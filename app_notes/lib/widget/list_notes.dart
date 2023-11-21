import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget {

  const ListNotes({super.key});


  @override
  Widget build(BuildContext context) {
    noteDataService.loadNotes();
    
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
          return ListView.builder(
            itemCount: value['dataObjects'].length,
            itemBuilder:(_,index) {
              switch (value['status']) {
                case TableStatus.loading:
                  return CircularProgressIndicator();
                  
                case TableStatus.ready:
                  return ListTile(
                    title: Text(value['dataObjects'][index].title),
                  );
              } return null;
            }
          );
        }
      },
    );
  }
}