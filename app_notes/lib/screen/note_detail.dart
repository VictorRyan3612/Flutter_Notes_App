import 'package:app_notes/widget/app_bar_right.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app_notes/data/note_data_service.dart';


class NoteDetail extends HookWidget {

  const NoteDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final contentController= useTextEditingController(text: noteDataService.aNoteValueNotifier.value[0]?.content ?? '');

    void mobileButtonOnPressedFunction(){
      if (contentController.text != '' ){
        Note newNote =  Note(title: contentController.text.split('\n')[0], content: contentController.text);

        Navigator.pop(context, newNote);
      }
      else{
        Navigator.pop(context);
      }
    }


    return Scaffold(
      appBar: AppBarRight(mobileBackButtonCallbackFunction: mobileButtonOnPressedFunction),

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
            noteDataService.aNoteValueNotifier.value[0].content = value;            
          },
        ),
      ),
    );
  }
}
