import 'package:flutter/material.dart';

import 'package:app_notes/screen/desktop_home_screen.dart';
import 'package:app_notes/screen/mobile_home_screen.dart';



class LayoutDecider extends StatelessWidget {
  const LayoutDecider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        bool isMobile = constraints.maxWidth < 600;
        
        return isMobile ? MobileHomeScreen() : DesktopHomeScreen();        
      },
    );
  }
}
