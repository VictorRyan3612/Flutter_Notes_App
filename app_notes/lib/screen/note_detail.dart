import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/data/note_data_service.dart';


class NoteDetail extends HookWidget {
  final Note? currentNote;
  const NoteDetail({super.key, this.currentNote});

  @override
  Widget build(BuildContext context) {
    final titleController= useTextEditingController(text: currentNote?.title ?? '');
    final contentController= useTextEditingController(text: currentNote?.content ?? '');


    return Scaffold(
      appBar: AppBar(),

      body: Padding(
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

          onChanged: (value) {
            currentNote?.content = value;            
          },
        ),
      ),
    );
  }
}
