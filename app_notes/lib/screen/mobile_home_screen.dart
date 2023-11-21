import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/widget/grid_notes.dart';
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
          return GridNotes();
        } else {
          return ListNotes();
        }
      },
    );
    
  }
}
