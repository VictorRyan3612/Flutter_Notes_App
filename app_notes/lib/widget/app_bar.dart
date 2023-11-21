import 'package:app_notes/config/settings_data_service.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool isMobile;

  MyAppBar({super.key, required this.isMobile});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    String titleFinal;
    if (isMobile){
      titleFinal = "Mobile Layout";
    } else{
      titleFinal = "Desktop layout";
    }
    return AppBar(
      title: Text(titleFinal),

      actions: [
        if(isMobile)
          PopupMenuButton(
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

      ],
    );
  }

}
