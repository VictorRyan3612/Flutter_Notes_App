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
      builder: (_, isGridViewValue, __) {
        return ValueListenableBuilder(
          valueListenable: noteDataService.notesValueNotifier,
          builder: (_, value, __) {
            switch (value['status']) {
              case TableStatus.loading:
                return CircularProgressIndicator();
              case TableStatus.error:
                return Text("Erro");

              case TableStatus.ready:
                

                if (isGridViewValue) {
                  List<Note> validDataObjects = value['dataObjects']
                    .where((dataObject) => dataObject.status == 'v')
                    .toList();
                  return GridView.builder(
                    itemCount: validDataObjects.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (_, index) {
                      return GridNotes(
                        title: validDataObjects[index].title,
                      );
                    },
                  );
                }
                else{
                  return ListView.builder(
                    itemCount: value['dataObjects'].length,
                    itemBuilder: (_, index) {
                      if (value['dataObjects'][index].status == 'v'){
                        return ListNotes(
                          title: value['dataObjects'][index].title
                        );
                      }
                      else {
                        return Container();
                      }
                    },
                  );
                }
            } return Container();
          } 
        );
      },
    );
  }
}
