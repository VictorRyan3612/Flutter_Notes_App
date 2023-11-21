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
                  child: Text("Tema Branco"),
                ),

                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Tema Preto"),
                ),
              ];
            },
            
            onSelected:(value){
              if(value == 0){
                print("Valor 0 selecionado.");
              }else if(value == 1){
                print("Valor 1 selecionado.");
              }
            }
          ),

      ],
    );
  }

}
