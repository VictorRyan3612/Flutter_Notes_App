import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/data/note_data_service.dart';


class NoteDetail extends HookWidget {
  
  const NoteDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var noteActual = noteDataService.aNoteValueNotifier.value[0];
    final titleController= useTextEditingController(text: noteActual?.title ?? '');
    final contentController= useTextEditingController(text: noteActual?.content ?? '');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: noteActual.selectColor(noteActual),
        
        title: TextField(
          controller: titleController,
          style: TextStyle(fontSize: 20),
          onChanged: (value) {
            noteActual.title = value;
            noteDataService.aNoteValueNotifier.value[0].title = noteActual.title;
            
          },
        ),

        leading: IconButton(
          onPressed: () {
            noteDataService.saveEditedNote(
              editedNote: noteDataService.aNoteValueNotifier.value[0], 
              index: noteDataService.aNoteValueNotifier.value[1]);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.black
            ),
        ),
      ),

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
            noteActual.content = value;
            noteDataService.aNoteValueNotifier.value[0].content = noteActual.content;
            
          },
        ),
      ),
    );
  }
}
