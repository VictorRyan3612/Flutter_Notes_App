import 'package:app_notes/screen/note_detail.dart';
import 'package:flutter/material.dart';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/view/grid_notes.dart';
import 'package:app_notes/view/list_notes.dart';
import 'package:app_notes/widget/search_section.dart';



class LoadNotesLayout extends StatelessWidget {
  const LoadNotesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    settingsService.loadSettings();

    clickFunction (Note note, int index) async{
      settingsService.hasALoadedNote.value = false;
          settingsService.hasALoadedNote.value = true;
          noteDataService.defContent(
            note: note,
            index: index
          );
          if(settingsService.isMobile.value){
            Note? noteEdited = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetail(),
              ),
            );
            if (settingsService.currentStatusNotes.value != 'x'){
              if (noteEdited != null){
                noteDataService.saveEditedNote(
                  editedNote: noteEdited,
                  index: index
                );
              }
              
            }
            
          }
    }
    return Column(
      children: [
        SearchSection(
          callbackSort: noteDataService.sortByField,
          callbackFilter: noteDataService.filterCurrentState
        ),
        Expanded(
          child: ValueListenableBuilder(
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
                          .where((dataObject) => dataObject.status == settingsService.currentStatusNotes.value)
                          .toList();
                        return GridView.builder(
                          itemCount: validDataObjects.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onLongPress: () {
                                print('Long-pressed on item at index $index');
                              },
                              child: GridNotes(
                                callbackClickFunction: clickFunction,
                                index: index,
                                note: value['dataObjects'][index],
                              )
                            );
                          },
                        );
                      }
                      else{
                        return ListView.builder(
                          itemCount: value['dataObjects'].length,
                          itemBuilder: (_, index) {
                            if (value['dataObjects'][index].status == settingsService.currentStatusNotes.value){
                              return Column(
                                children: [
                                  Divider(),
                                  GestureDetector(
                                    onLongPress: () {
                                      print('Long-pressed on item at index $index');
                                    },
                                    child: ListNotes(
                                      callbackClickFunction: clickFunction,
                                      note: value['dataObjects'][index],
                                      index: index,
                                    ),
                                  ),
                                ],
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
          ),
        ),
      ],
    );
  }
}
