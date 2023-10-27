import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

class Usuario {
  final String nome;
  final String email;

  Usuario({required this.nome, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
    };
  }
  String toJson() => json.encode(toMap());
}


class UserCadastro extends StatefulWidget {
  const UserCadastro({super.key});

  @override
  State<UserCadastro> createState() => _UserCadastroState();
}

class _UserCadastroState extends State<UserCadastro> {
    List<Usuario> listaUsuario = [];
  
  @override
  void initState() {
    super.initState();
    carregarUsuarios();
  }

  Future<void> carregarUsuarios() async {
      Directory directory = await getApplicationSupportDirectory();
      File file = File('${directory.path}/users.dat');
      print("""
        diretório=${directory},file=${file}
      """);
      if (file.existsSync()) {

        String content = await file.readAsString();
        print("content =($content)");
        if (content != '') {
          List<dynamic> jsonList = json.decode(content);
        setState(() {
          listaUsuario = jsonList.map((json) => Usuario(nome: json['nome'], email: json['email'])).toList();
        });
        }
        
      }
    }
    
    Future<void> salvarUser() async {
      Directory directory = await getApplicationSupportDirectory();
      File file = File('${directory.path}/users.dat');
      String content = json.encode(listaUsuario.map((usuario) => usuario.toMap()).toList());
      await file.writeAsString(content);
    }


  @override
  Widget build(BuildContext context) {

    TextEditingController nomeController = TextEditingController();
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
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nomeController.text.isNotEmpty && emailController.text.isNotEmpty) {
                    Usuario novoUser = Usuario(nome: nomeController.text, email: emailController.text);
                    listaUsuario.add(novoUser);
                    salvarUser();
                    Navigator.pop(context);
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

class UserLeitura extends StatefulWidget{
  const UserLeitura({super.key});

  @override
  State<UserLeitura> createState() => _UserLeituraState();
}

class _UserLeituraState extends State<UserLeitura> {

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
