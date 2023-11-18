import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String cardTitle;
  final String cardSubtitle;
  final Function() onEditPressed;
  final Function() onDeletePressed;

  const UserCard({super.key, 
    required this.cardTitle,
    required this.cardSubtitle,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(cardTitle),
        subtitle: Text(cardSubtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditPressed,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDeletePressed,
            ),
          ],
        ),
      ),
    );
  }
}
