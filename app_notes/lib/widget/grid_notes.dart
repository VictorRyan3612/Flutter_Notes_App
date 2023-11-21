import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final List<Note> valueNotes;

  const GridNotes({super.key, required this.valueNotes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: valueNotes.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridTile(
            child: Text(valueNotes[index].title),
          )
        );
      },

    );
  }
}