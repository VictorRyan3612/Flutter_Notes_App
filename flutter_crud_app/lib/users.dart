import 'package:flutter/material.dart';
import 'dart:convert';


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

class UserCadastro extends StatefulWidget{
  const UserCadastro({super.key});

  @override
  State<UserCadastro> createState() => _UserCadastroState();
}

class _UserCadastroState extends State<UserCadastro> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Usuario")
      ),
      body: const Padding(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'email',
                ),
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
