import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';



class GridNotes extends StatelessWidget {

  const GridNotes({super.key});


  @override
  Widget build(BuildContext context) {

    
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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: value['dataObjects'].length,
            itemBuilder: (_,index) {
              switch (value['status']) {
                case TableStatus.loading:
                  return CircularProgressIndicator();
                  
                case TableStatus.ready:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridTile(
                      child: Text(value['dataObjects'][index].title),
                    )
                  );
              } return null;
            }
          );
          
        }
      },
    );
  }
}