import 'package:app_notes/widget/list_notes.dart';
import 'package:flutter/material.dart';


class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListNotes()
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
