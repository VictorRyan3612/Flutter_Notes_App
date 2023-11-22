import 'package:flutter/material.dart';
import '../data/note_data_service.dart';


class NoteDetail extends StatelessWidget {
  const NoteDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var noteActual = noteDataService.aNoteValueNotifier.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: noteActual.selectColor(noteActual),
        title: Text(noteActual.title),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back, 
            color: Colors.black
            ),
        ),
      ),

      body: Center(
        child: Text(noteActual.content)
      ),
    );
    // return Text(noteDataService.aNoteValueNotifier.value.title);
  }
}
