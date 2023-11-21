import 'package:app_notes/widget/list_notes.dart';
import 'package:flutter/material.dart';

import '../widget/load_notes_layout.dart';


class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LoadNotesLayout()
        ),
        Expanded(
          child: Center(
            child: Text("Texto Direito")
            )
          )
      ],
    );
  }
}
