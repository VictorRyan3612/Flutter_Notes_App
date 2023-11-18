import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/user_data_service.dart';
import '../data/var_json.dart' show UserDetailVar;


// User Detail screen
class UserDetail extends HookWidget {
  final String titulo;
  final User? userAtual;

  const UserDetail({
    Key? key, 
    required this.titulo,
    this.userAtual}
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDetailVar = UserDetailVar(userAtual: userAtual);
    final cardData = userDetailVar.getCards(context);


    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Create TextField with map from cardData
            ...cardData.map((card) {
              return Column(
                children: [
                  TextField(
                    controller: card['controller'],
                    decoration: InputDecoration(
                      labelText: card['labelText'],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                ],
              );
            }).toList(),

            const SizedBox(
              width: 20,
              height: 20,
            ),

            // Save button
            ElevatedButton(
              onPressed: () {
                bool anyFieldEmpty = cardData.any((card) =>
                  (card['controller'] as TextEditingController).text.isEmpty);

                if (!anyFieldEmpty) {
                  User newUser = User(
                    name: cardData[0]['controller'].text,
                    email: cardData[1]['controller'].text,
                    cpf: cardData[2]['controller'].text,
                  );
                  Navigator.pop(context, newUser);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.userAviso),
                    ),
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.userSave),
            ),
          ],
        ),
      ),
    );
  }
}
