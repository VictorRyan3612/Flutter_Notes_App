import 'package:flutter/material.dart';

class PrototipalDrawerMenu extends StatelessWidget {
  const PrototipalDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = true;
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
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
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(), 
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      "Olá Diego",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
              ],
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: ( ) { } ,
                ),
                
                const Divider(),
                ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('perfil'),
                    onTap: ( ) { } ,
                  ),
                  
                const Divider(),
                ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: ( ) { } ,
                  ),
                  // ListTile
                const Divider(),
              ],
            ),
          )
        ]
      )
    );
  }
}
