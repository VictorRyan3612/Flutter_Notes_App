import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/view/desktop_left_side.dart';
import 'package:app_notes/view/desktop_right_side.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import 'package:app_notes/widget/drawer_menu.dart';



class DesktopHomeScreen extends HookWidget {
  final Note? note;
  const DesktopHomeScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {  
    
    return Scaffold(
      drawer: DrawerMenu(),
      body: Row(
        children: [

          LeftSide(),
          
          // Right Side
          RightSide()
        ]
      ),
    );
  }
}
