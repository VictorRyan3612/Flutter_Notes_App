import 'package:app_notes/widget/list_left.dart';
import 'package:flutter/material.dart';


class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListLeft()
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