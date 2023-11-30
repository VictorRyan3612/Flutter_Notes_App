import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';
import '../config/settings_data_service.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: settingsService.dropDownValueText,
      builder: (_, value, __) {
        return DropdownButton<String>(
          value: value,
          items: noteDataService.notesFieldsSortables.map((field) {
            return DropdownMenuItem(
              value: field,
              child: Text(field),
            );
          }).toList(),
          onChanged: (newValue) {
            value = newValue!;
            noteDataService.sortByField(value);
            settingsService.dropDownValueText.value = newValue;
          },
        );
      }, 
    );
  }
}
