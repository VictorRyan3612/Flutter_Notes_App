import 'package:flutter/material.dart';

import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/screen/desktop_home_screen.dart';
import 'package:app_notes/screen/mobile_home_screen.dart';



class LayoutDecider extends StatelessWidget {
  const LayoutDecider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        settingsService.isMobile.value = constraints.maxWidth < 600;
        return settingsService.isMobile.value ? MobileHomeScreen() : DesktopHomeScreen();        
      },
    );
  }
}
