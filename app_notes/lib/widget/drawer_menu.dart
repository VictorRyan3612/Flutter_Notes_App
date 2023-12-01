import 'package:app_notes/view/load_notes_layout.dart';
import 'package:app_notes/widget/app_bar.dart';
import 'package:flutter/material.dart';


class DrawerMenu extends StatelessWidget {

  const DrawerMenu({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      width: 300,
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 80, 212, 252),
                  Color.fromARGB(255, 124, 3, 222)
                ]
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: "Voltar",
                  icon: Icon(Icons.menu, 
                    size: 30
                  ),
                  onPressed: () => Navigator.of(context).pop(), 
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(fontSize: 25)
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            autofocus: true,
            leading: Icon(Icons.notes),
            title: const Text('All Notes'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: const Text('Trash'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: MyAppBar(isMobile: false, statusNotes: 'x'),
                      body: LoadNotesLayout(statusNotes: 'x'),
                    );
                  }
                )
              );
              // Navigator.pushNamed(context, '/configs');
              // Update the state of the app.
              // ...
            },
          ),

          const Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/configs');
            },
          ),
        ],
      )
    );
  }
}
