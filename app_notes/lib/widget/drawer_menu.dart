import 'package:app_notes/config/settings_data_service.dart';
import 'package:app_notes/data/note_data_service.dart';
import 'package:file_picker/file_picker.dart';
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
              settingsService.currentStatusNotes.value = 'v';
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.archive_rounded),
            title: const Text('Archived'),
            onTap: () {
              settingsService.currentStatusNotes.value = 'a';
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.delete_outline),
            title: const Text('Trash'),
            onTap: () {
              settingsService.currentStatusNotes.value = 'x';
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
              
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
          Divider(),
          
          ListTile(
            leading: Icon(Icons.upload_file_outlined),
            title: const Text('Export'),
            onTap: () async{
              String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

              if (selectedDirectory != null) {
                print('Pasta selecionada: $selectedDirectory');
                noteDataService.exportNotestoTxt(
                  noteDataService.notesValueNotifier.value['dataObjects'],
                  folder: selectedDirectory
                );

              } else {
                print('Nenhuma pasta foi selecionada.');
              }
            }
          ),

          ListTile(
            leading: Icon(Icons.download),
            title: const Text('Import'),
            onTap: () async{
              String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

              if (selectedDirectory != null) {
                print('Pasta selecionada: $selectedDirectory');
                noteDataService.importNotesFromTxt(selectedDirectory);

              } else {
                print('Nenhuma pasta foi selecionada.');
              }
            }
          )
        ],
      )
    );
  }
}
