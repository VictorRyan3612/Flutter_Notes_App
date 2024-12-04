// flutter packages
import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/config/shortcuts_settings.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/screen/desktop_home_screen.dart';
import 'package:app_notes/screen/mobile_home_screen.dart';
import 'package:app_notes/screen/note_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vicr_widgets/flutter_vicr_widgets.dart';



void main() {
  VicrMaterialApp().loadSettings();
  noteDataService.loadNotes();
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: ShortcutsSettings.getGlobalShortcuts(),
      child: VicrMaterialApp(
        routes: {
          '/': (context) => VicrLayoutDecider(
          isMobile: settingsService.isMobile,
          optionMobile: MobileHomeScreen(),
          optionDesktop: DesktopHomeScreen(),
        ),
          '/noteDetail': (context) => NoteDetail(), 
        },
      ),
    );
  }
}
