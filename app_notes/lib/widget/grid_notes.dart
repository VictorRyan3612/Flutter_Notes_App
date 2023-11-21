import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final String title;

  const GridNotes({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 5.0,
              color: Colors.red,
              margin: EdgeInsets.only(bottom: 5), // Margem ao redor da linha (opcional)
              width: double.infinity, // Preencher o máximo possível
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ]
        ),
      ),
    );
  }
}