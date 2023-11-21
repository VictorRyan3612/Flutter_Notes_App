import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final String title;

  const GridNotes({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridTile(
        child: Text(title),
      )
    );
  }
}