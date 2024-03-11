import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/view/load_notes_layout.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:flutter/material.dart';


class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: settingsService.desktopLoadView,
      builder: (_, value, __) {
        if (value){
          return Expanded(
            child: Column(
              children: [
                MyAppBar(),
                
                Expanded(
                  child: LoadNotesLayout()
                ),
              ],
            )
          );
        }
        return Container();
      },
    );
  }
}
