import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

class Usuario {
  final String nome;
  final String email;
  late String status;
  Usuario({required this.nome, required this.email, this.status = "v"});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'status': status
    };
  }
  String toJson() => json.encode(toMap());
}


class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<Usuario> listaUsuario = [];
  
  @override
  void initState() {
    super.initState();
    carregarUsuarios();
  }

  Future<void> carregarUsuarios() async {
      Directory directory = await getApplicationSupportDirectory();
      File file = File('${directory.path}/users.dat');

      if (file.existsSync()) {

        String content = await file.readAsString();
        print("content =($content)");
        if (content != '') {
          List<dynamic> jsonList = json.decode(content);
          setState(() {
            listaUsuario = jsonList.map((json) => Usuario(
              nome: json['nome'], 
              email: json['email'], 
              status: json['status'])
            ).toList();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloco de Notas'),
      ),
      body: ListView.builder(
        itemCount: listaUsuario.length,
        itemBuilder: (context, index) {
          // final usuario = listaUsuario[index];
          if (listaUsuario[index].status == "v") {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(listaUsuario[index].nome),
                subtitle: Text(listaUsuario[index].email),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Algoritmo de exclusão lógica
                    setState(() {
                      listaUsuario[index].status = 'x';
                      salvarUser();
                    });
                  },
                ),
              ),
            );
          }
          else{
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Usuario? novaUsuario = await Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => const UsuarioCadastro()
            )
          );
          if (novaUsuario != null) {
            setState(() {
              listaUsuario.add(novaUsuario);
              salvarUser();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


class UsuarioCadastro extends StatefulWidget {
  const UsuarioCadastro({super.key});
  @override
  State<UsuarioCadastro> createState() => _UsuarioCadastroState();
}

class _UsuarioCadastroState extends State<UsuarioCadastro> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'email',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_nomeController.text.isNotEmpty && _emailController.text.isNotEmpty) {
                  Usuario novoUsuario = Usuario(nome: _nomeController.text, email: _emailController.text);
                  Navigator.pop(context, novoUsuario);
                }
              },
              child: const Text('Salvar Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
