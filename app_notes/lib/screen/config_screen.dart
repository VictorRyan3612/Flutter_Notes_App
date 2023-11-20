import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfigScreen extends StatelessWidget {
  final ValueNotifier<bool> currentIsDarkMode;
  final ValueNotifier<String> currentColor;

  const ConfigScreen({super.key, required this.currentIsDarkMode, required this.currentColor});

// Save settings to file
    Future<void> saveSettings() async {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('isDarkMode', currentIsDarkMode.value);
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
              value: currentIsDarkMode.value, 
              onChanged: (value) {
                currentIsDarkMode.value = value;
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