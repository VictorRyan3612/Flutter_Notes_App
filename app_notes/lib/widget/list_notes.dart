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
            child: Text("Não tem Notas")); 

        }
        else if (value['status'] == TableStatus.loading) {
          return CircularProgressIndicator();
        }
        else{
          return ListView(
            children: [
              ListTile(
                title: const Text('Note 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Note 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
        
              const Divider(),
              ListTile(
                title: const Text('Note 3'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ]
          );
        }
      },
    );
  }
}