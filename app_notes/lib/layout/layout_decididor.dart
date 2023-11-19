import 'package:app_notes/screen/desktop_home_screen.dart';
import 'package:flutter/material.dart';

import '../screen/mobile_home_screen.dart';
import '../widget/drawer_menu.dart';


class LayoutDecider extends StatelessWidget {
  const LayoutDecider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        bool isMobile = constraints.maxWidth < 600;
        return Scaffold(
          drawer: DrawerMenu(),
          appBar: isMobile ? AppBar(title: Text("Mobile Layout")) : AppBar(title: Text("Desktop Layout")),
          body: isMobile 
          ? MobileHomeScreen()
          : DesktopHomeScreen()
        );
      },
    );
  }
}
