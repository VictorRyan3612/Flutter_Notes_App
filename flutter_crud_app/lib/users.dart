import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';


class Usuario {
  final String nome;
  final String email;

  Usuario({required this.nome, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'title': nome,
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());
}


class UserCadastro extends HookWidget {
  const UserCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Usuario")
      ),
      body:  Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'email',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty && emailController.text.isNotEmpty) {
                    Usuario novaNota = Usuario(nome: titleController.text, email: emailController.text);
                    Navigator.pop(context, novaNota);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Por favor, preencha todos os campos.")
                        
                      )
                    );
                  }
                },
                child: const Text('Salvar Usuario'),
              ),
            ]
          ),
        )
      )
    );
  }
}

class UserLeitura extends StatelessWidget{
  const UserLeitura({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem")
      ),
      body: const Center(
        child: Text("Listar")
      ),
    );
  }
}
