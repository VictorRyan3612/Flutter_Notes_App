import 'package:app_notes/widget/list_notes.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../config/settings_data_service.dart';


class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    settingsService.loadSettings();
    return ValueListenableBuilder(
      valueListenable: settingsService.isGridView, 
      builder:(_, value,__) {
        if (value == true) {
          return GridView.builder(
            gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: 10, // Defina o número desejado de itens
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color.fromARGB(
                  255,
                  Random().nextInt(255),
                  Random().nextInt(255),
                  Random().nextInt(255),
                ),
              ),
            ),
          );
        } else {
          return ListNotes();
        }
      },
    );
    
  }
}