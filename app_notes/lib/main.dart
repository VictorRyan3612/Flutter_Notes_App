// flutter packages
import 'package:app_notes/config/shortcuts_settings.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/screen/note_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:app_notes/layout/layout_decider.dart';
import 'package:app_notes/config/theme_config.dart';
import 'package:app_notes/screen/config_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    // base states 
    final currentIsDarkMode = useState(true); //Theme
    final currentColor = useState('Blue'); // Accent color

    Future<void> loadSettings() async {
      final prefs = await SharedPreferences.getInstance();
      
      final isDarkMode = prefs.getBool('isDarkMode') ?? true;
      currentIsDarkMode.value = isDarkMode;

      final colorTheme = prefs.getString('colorTheme') ?? 'Blue';
      currentColor.value = colorTheme;

    }

    loadSettings();
    noteDataService.loadNotes();
    
    final finalTheme = setTheme(currentIsDarkMode.value, currentColor.value);


    return CallbackShortcuts(
      bindings: ShortcutsSettings.getGlobalShortcuts(),
      child: MaterialApp(
        theme: finalTheme,
        debugShowCheckedModeBanner: false,
      
      
        initialRoute: '/',
        routes: {
          '/': (context) => LayoutDecider(),
          '/noteDetail': (context) => NoteDetail(),
          '/configs': (context) => ConfigScreen(
            currentIsDarkMode: currentIsDarkMode,
            currentColor: currentColor,
            )
        },
      ),
    );
  }
}


