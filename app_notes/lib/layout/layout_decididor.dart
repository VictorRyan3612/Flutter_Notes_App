import 'package:flutter/material.dart';

import '../data/note_data_service.dart';
import '../screen/desktop_home_screen.dart';
import '../screen/mobile_home_screen.dart';
import '../widget/app_bar.dart';
import '../widget/drawer_menu.dart';


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
