import 'package:app_notes/widget/app_bar_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/data/note_data_service.dart';


class NoteDetail extends HookWidget {

  const NoteDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final contentController= useTextEditingController(text: noteDataService.aNoteValueNotifier.value[0]?.content ?? '');

    return Scaffold(
      appBar: AppBarRight(),

      body: ValueListenableBuilder(
        valueListenable: noteDataService.aNoteValueNotifier,
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              controller: contentController,
              autofocus: true,
              style: TextStyle(fontSize: 20),
              expands: true,
              maxLines: null,
              minLines: null,
              
              decoration: InputDecoration(
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                border: InputBorder.none,
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor, // Cor de fundo desejada
              ),
              onChanged: (value2) {
                value[0].content = value2;
                noteDataService.saveEditedNote(
                  editedNote: value[0], 
                  index: value[1] 
                );
              },
            ),
          );
        },
      ),
    );
  }
}
