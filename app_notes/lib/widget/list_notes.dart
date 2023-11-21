import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget {

  const ListNotes({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Note 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Note 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),

        const Divider(),
        ListTile(
          title: const Text('Note 3'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    );
  }
}