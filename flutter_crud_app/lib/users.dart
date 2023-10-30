import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/user_card.dart';

class Usuario {
  late String nome;
  late String email;
  late String cpf;
  late String status;
  Usuario({required this.nome, required this.email, required this.cpf, this.status = "v"});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'cpf': cpf,
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
              cpf: json['cpf'],
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

  void atualizarUsuario(int index, Usuario novoUsuario) {
    setState(() {
      listaUsuario[index] = novoUsuario;
      salvarUser();
    });
  }

  Future<void> edicaocallback(int index) async {
    Usuario? novaUsuario = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsuarioCadastro(
          titulo: "Editar Usuario",
          nomeExistente: listaUsuario[index].nome,
          emailExistente: listaUsuario[index].email,
          cpfExistense: listaUsuario[index].cpf,
        ),
      ),
    );
    if (novaUsuario != null) {
      atualizarUsuario(index, novaUsuario);
    }
  }
  void deleteCallback(index){
    setState(() {
      listaUsuario[index].status = 'x';
      salvarUser();
    });
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
            return UsuarioCard(
              cardTitle: listaUsuario[index].nome,
              cardSubtitle: listaUsuario[index].email,
              onEditPressed: () async{
                edicaocallback(index);
              },
              onDeletePressed: () {
                deleteCallback(index);
              },
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
              builder: (context) => const UsuarioCadastro(titulo: "Adicionar Usuario",)
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
  final String titulo;
  final String? nomeExistente;
  final String? emailExistente;
  final String? cpfExistense;
  const UsuarioCadastro({
    Key? key, 
    this.titulo = 'Adicionar Usuario',
    this.nomeExistente,
    this.emailExistente,
    this.cpfExistense,
  }) : super(key: key);
  @override
  State<UsuarioCadastro> createState() => _UsuarioCadastroState();
}

class _UsuarioCadastroState extends State<UsuarioCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.nomeExistente ?? '';
    _emailController.text = widget.emailExistente ?? '';
    _cpfController.text = widget.cpfExistense ?? '';
  }
  @override
  Widget build(BuildContext context) {
    String titulo = widget.titulo;
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
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'email',
              ),
            ),
            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(
                labelText: 'CPF',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_nomeController.text.isNotEmpty && _emailController.text.isNotEmpty && _cpfController.text.isNotEmpty) {
                  Usuario novoUsuario = Usuario(
                    nome: _nomeController.text,
                    email: _emailController.text, 
                    cpf: _cpfController.text,
                  );
                  Navigator.pop(context, novoUsuario);
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
            
          ],
        ),
      ),
    );
  }
}
