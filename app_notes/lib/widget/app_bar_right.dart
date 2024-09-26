import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/config/theme_config.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vicr_widgets/flutter_vicr_widgets.dart';


class AppBarRight extends StatelessWidget implements PreferredSizeWidget {
  final Function? mobileBackButtonCallbackFunction; 
  
  AppBarRight({super.key, this.mobileBackButtonCallbackFunction});


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: settingsService.isMobile.value ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back, 
        )
      )

      : IconButton(
        tooltip: "Ativar/Desativar Lista de Notas",
        onPressed: (){
          settingsService.desktopLoadView.value = !settingsService.desktopLoadView.value;
        },
        icon: Icon(Icons.view_column_outlined)
      ),

      actions: [
        if(settingsService.currentStatusNotes.value == 'x')
        IconButton(
          tooltip: "Restaurar",
          onPressed: (){
            noteDataService.restoreNote(noteDataService.aNoteValueNotifier.value[0]);
            settingsService.hasALoadedNote.value = false;
            if(settingsService.isMobile.value){
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.recycling)
        ),

        if(settingsService.currentStatusNotes.value == 'v')
        ValueListenableBuilder(
          valueListenable: settingsService.hasALoadedNote,
          builder: (_, value, __) {
            if (value){
              return IconButton(
                tooltip: "Mudar cor",
                onPressed: () async {

                  Color? colorEdited = await showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      content: VicrColorSelector(colors: List<MaterialColor>.from(varColor.map((colorElement) => colorElement['color']).toList())),
                    );
                  }); 

                  if (colorEdited != null){
                    Map<String,dynamic> jsonColor = varColor.firstWhere((element) {
                      return element['color'] == colorEdited;
                    });
                    noteDataService.aNoteValueNotifier.value[0].colorNote = jsonColor['name'];
                    noteDataService.saveEditedNote(
                      editedNote: noteDataService.aNoteValueNotifier.value[0],
                      index: noteDataService.aNoteValueNotifier.value[1]
                    );
                  }
                },
                
                icon: Icon(
                  Icons.square,
                  color: noteDataService.aNoteValueNotifier.value[0].selectColor() as Color
                )
              );
            }
            else{
              return Container();
            }
          }
          
        ),

        PopupMenuButton(
          tooltip: "Opções",
          icon: const Icon(
            Icons.more_vert, 
            ),
          itemBuilder: (context){
            return const[
              PopupMenuItem<int>(
                value: 0,
                child: Text("Arquivar")
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Excluir"),
              ),
            ];
          },
        
          onSelected:(value){
            if(value == 0){
              noteDataService.archiveNote(noteDataService.aNoteValueNotifier.value[0]);
              
              settingsService.hasALoadedNote.value = false;
              if(settingsService.isMobile.value){
                Navigator.pop(context);
              }
            }
            if(value == 1){
              noteDataService.deleteNote(noteDataService.aNoteValueNotifier.value[0]);
              
              settingsService.hasALoadedNote.value = false;
              if(settingsService.isMobile.value){
                Navigator.pop(context);
              }
            }
          }
        ),
      ],
    );
  }
}
