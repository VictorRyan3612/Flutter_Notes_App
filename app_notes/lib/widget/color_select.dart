import 'package:app_notes/config/theme_config.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:flutter/material.dart';


class ColorSelect extends StatelessWidget {
  const ColorSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: Container(
          width: 600,
          height: 600,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                children: varColor.map((itemColor) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      
                      onTap: () {
                        noteDataService.aNoteValueNotifier.value[0].colorNote = itemColor['name'];
                        Navigator.pop(context, noteDataService.aNoteValueNotifier.value[0]);
                      },
                    child:
                      Container(
                        color: itemColor['color'] as Color,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  );
                }).toList()
              ),
            ),
          ),
        ),
      ),
    );
  }
}
