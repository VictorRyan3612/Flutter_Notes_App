import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';


class AppBarRight extends StatelessWidget implements PreferredSizeWidget {
  const AppBarRight({super.key});


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: settingsService.isMobile.value ? IconButton(
          onPressed: () {
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
        PopupMenuButton(
          tooltip: "Opções",
          icon: const Icon(
            Icons.more_vert, 
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
    );
  }
}
