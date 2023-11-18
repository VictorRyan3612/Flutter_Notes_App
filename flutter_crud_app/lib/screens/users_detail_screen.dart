import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/user_data_service.dart';



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
    final nameController =
        useTextEditingController(text: userAtual?.name ?? '');
    final emailController =
        useTextEditingController(text: userAtual?.email ?? '');
    final cpfController =
        useTextEditingController(text: userAtual?.cpf ?? '');
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.black), // Cor do texto
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userFieldName,
                filled: true,
                fillColor: Colors.white, // Cor de fundo
              ),
            ),

            const SizedBox(
              width: 10, 
              height: 10
            ),

            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userFieldEmail,
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(
              width: 10, 
              height: 10
            ),

            TextField(
              controller: cpfController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userFieldCpf,
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    cpfController.text.isNotEmpty) {
                  User newUser = User(
                    name: nameController.text,
                    email: emailController.text,
                    cpf: cpfController.text,
                  );
                  Navigator.pop(context, newUser);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.userAviso)
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
