import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfigScreen extends StatelessWidget {
  final ValueNotifier<Brightness> currentBrightness;
  final ValueNotifier<String> currentColor;

  const ConfigScreen({super.key, required this.currentBrightness, required this.currentColor});

// Save settings to file
    Future<void> saveSettings() async {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('isDarkMode', currentBrightness.value == Brightness.dark);
      prefs.setString('colorTheme', currentColor.value);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações"),),
      body: ListView(
        children: [
          ListTile(
            title: Text("Opção 1"),
            subtitle: Text("Subtitulo 1"),
            trailing: Switch(
              value: currentBrightness.value == Brightness.dark, 
              onChanged: (bool value) {
                if (currentBrightness.value == Brightness.dark) {
                  currentBrightness.value = Brightness.light;
                } 
                else {
                  currentBrightness.value = Brightness.dark;
                  
                }
                saveSettings();
              },
            ),

          ),
          Divider(),
          ListTile(
            title: Text("Opção 2"),
            subtitle: Text("Subtitulo 2"),
          ),
          Divider(),
          ListTile(
            title: Text("Opção 3"),
            subtitle: Text("Subtitulo 3"),
          ),
          Divider(),
        ],
      ),
    );
  }
}