import 'package:flutter/material.dart';

import 'package:app_notes/data/note_data_service.dart';


class GridNotes extends StatelessWidget {
  final Note note;
  final int index;
  final Function callbackClickFunction;

  const GridNotes({super.key, required this.note, required this.index, required this.callbackClickFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () async {
          callbackClickFunction(note, index);
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 80, // Limita a altura máxima
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 0),
            leading: Container(
              color: note.selectColor(),
              height: double.infinity,
              width: 5,
            ),
            minLeadingWidth: 10,
            title: Text(
              note.title,
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1, // Limita o número de linhas do título
              overflow: TextOverflow.ellipsis, // Adiciona "..." no final se ultrapassar
            ),
            subtitle: Text(
              noteDataService.defSubtitle(note, '   '),
              maxLines: 2, // Limita o número de linhas do subtítulo
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
