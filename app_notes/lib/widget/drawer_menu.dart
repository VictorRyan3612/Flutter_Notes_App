import 'package:flutter/material.dart';


class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});
  @override
  Widget build(BuildContext context) {
    bool isMobile = true;
    return Container(
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
                if (isMobile)
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
            title: const Text('All Notes'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),

          ListTile(
            title: const Text('Trash'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          
          const Divider(),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      )
    );
  }
}
