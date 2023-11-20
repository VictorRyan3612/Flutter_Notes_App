import 'package:flutter/material.dart';


class ConfigScreen extends StatelessWidget {
  final ValueNotifier<Brightness> currentBrightness;
  final ValueNotifier<String> currentColor;

  const ConfigScreen({super.key, required this.currentBrightness, required this.currentColor});


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
              value: true, 
              onChanged: (bool value) {
                
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