// flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'layout/layout_decididor.dart';
import 'config/theme_config.dart';
import 'screen/config_screen.dart';


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

    final finalTheme = setTheme(currentIsDarkMode.value, currentColor.value);


    return MaterialApp(
      theme: finalTheme,
      debugShowCheckedModeBanner: false,


      initialRoute: '/',
      routes: {
        '/': (context) => LayoutDecider(),

        '/configs': (context) => ConfigScreen(
          currentIsDarkMode: currentIsDarkMode,
          currentColor: currentColor,
          )
      },
    );
  }
}


