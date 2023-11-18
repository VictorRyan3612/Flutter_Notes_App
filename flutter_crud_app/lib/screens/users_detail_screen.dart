import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/user_data_service.dart';
import '../data/var_json.dart' show UserDetailVar;


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
            for (var card in cardData)
              Column(
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
              ),

            // const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     if (nameController.text.isNotEmpty &&
            //         emailController.text.isNotEmpty &&
            //         cpfController.text.isNotEmpty) {
            //       User newUser = User(
            //         name: nameController.text,
            //         email: emailController.text,
            //         cpf: cpfController.text,
            //       );
            //       Navigator.pop(context, newUser);
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(AppLocalizations.of(context)!.userAviso)
            //         ),
            //       );
            //     }
            //   },
            //   child: Text(AppLocalizations.of(context)!.userSave),
            // ),
          ],
        ),
      ),
    );
  }
}
