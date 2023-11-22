import 'package:flutter/material.dart';
import '../data/note_data_service.dart';


class NoteDetail extends StatelessWidget {
  const NoteDetail({super.key});

  @override
  Widget build(BuildContext context) {
    noteDataService.aNoteValueNotifier.value;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(noteDataService.aNoteValueNotifier.value.title)
      ),
    );
    // return Text(noteDataService.aNoteValueNotifier.value.title);
  }
}
