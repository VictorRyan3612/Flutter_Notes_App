import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:app_notes/widget/app_bar_right.dart';
import 'package:flutter/material.dart';


class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AppBarRight(),

          ValueListenableBuilder(
            valueListenable: settingsService.desktopLateralView,
            builder: (_, value, __) {
              if(!value){
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sticky_note_2, 
                        size: 70,
                      ),
                      Text(
                        "Nenhuma Nota",
                        style: TextStyle(fontSize: 30),
                      )
                    ]
                  )
                );
              }
              else {
                return ValueListenableBuilder(
                  valueListenable: noteDataService.aNoteValueNotifier,
                  builder: (_, value, __) {
                    TextEditingController controller = TextEditingController(text: value[0].content);
                    
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: TextField(
                          controller: controller,
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
                    
                          onChanged: (value2) {
                            value[0].content = value2;
                            
                            noteDataService.saveEditedNote(
                              editedNote: value[0], 
                              index: value[1]
                            );
                            
                          },
                        ),
                      ),
                    );
                  },
                  
                );
              }
            },
          )
        ],
      ),
    );
  }
}