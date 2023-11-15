import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final _callback;

  MyAppBar({super.key, callback}):
    _callback = callback ?? (int){}

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Expanded(
            child: Text("Título"),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                onChanged: (value) => _callback(value),
                decoration: const InputDecoration(
                  hintText: 'Filtrar',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
