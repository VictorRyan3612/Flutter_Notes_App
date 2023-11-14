import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/user_card.dart';

class Usuario {
  late String nome;
  late String email;
  late String cpf;
  late String status;
  Usuario(
    {required this.nome,
    required this.email,
    required this.cpf,
    this.status = "v"}
  );

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

class UserScreen extends HookWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listaUsuario = useState<List<Usuario>>([]);

    Future<void> carregarUsuarios() async {
      Directory directory = await getApplicationSupportDirectory();
      File file = File('${directory.path}/users.dat');

      if (file.existsSync()) {
        String content = await file.readAsString();
        if (content != '') {
          List<dynamic> jsonList = json.decode(content);
          listaUsuario.value = jsonList.map((json) => Usuario(
            nome: json['nome'],
            email: json['email'],
            cpf: json['cpf'],
            status: json['status'],
          ))
          .toList();
        }
      }
    }

    useEffect(() {
      carregarUsuarios();
      return null;
    }, const []);

    Future<void> salvarUser() async {
      Directory directory = await getApplicationSupportDirectory();
      File file = File('${directory.path}/users.dat');
      String content = json.encode(
          listaUsuario.value.map((usuario) => usuario.toMap()).toList());
      await file.writeAsString(content);
    }

    void atualizarUsuario(int index, Usuario novoUsuario) {
      listaUsuario.value[index] = novoUsuario;
      salvarUser();
      carregarUsuarios();
    }

    Future<void> edicaocallback(int index) async {
      Usuario? novaUsuario = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UsuarioCadastro(
            titulo: AppLocalizations.of(context)!.userTitleEdit,
            usuarioAtual: listaUsuario.value[index]
          ),
        ),
      );
      if (novaUsuario != null) {
        atualizarUsuario(index, novaUsuario);
      }
    }

    void deleteCallback(index) {
      listaUsuario.value[index].status = 'x';
      salvarUser();
      carregarUsuarios();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.userPageTitle),
      ),
      body: ListView.builder(
        itemCount: listaUsuario.value.length,
        itemBuilder: (context, index) {
          if (listaUsuario.value[index].status == "v") {
            return UsuarioCard(
              cardTitle: listaUsuario.value[index].nome,
              cardSubtitle: listaUsuario.value[index].email,
              onEditPressed: () async {
                edicaocallback(index);
              },
              onDeletePressed: () {
                deleteCallback(index);
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Usuario? novaUsuario = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                UsuarioCadastro(titulo: AppLocalizations.of(context)!.userTitleCreate),
            ),
          );
          if (novaUsuario != null) {
            listaUsuario.value = [...listaUsuario.value, novaUsuario];
            salvarUser();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UsuarioCadastro extends HookWidget {
  final String titulo;
  final Usuario? usuarioAtual;

  const UsuarioCadastro({
    Key? key,
    required this.titulo,
    this.usuarioAtual
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nomeController = useTextEditingController(text: usuarioAtual?.nome ?? '');
    final emailController = useTextEditingController(text: usuarioAtual?.email ?? '');
    final cpfController = useTextEditingController(text: usuarioAtual?.cpf ?? '');
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
              controller: nomeController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userFieldName,
              ),
            ),
            TextField(
              controller: emailController,
              decoration:  InputDecoration(
                labelText: AppLocalizations.of(context)!.userFieldEmail,
              ),
            ),
            TextField(
              controller: cpfController,
              decoration:  InputDecoration(
                labelText: AppLocalizations.of(context)!.userFieldCpf,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (nomeController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    cpfController.text.isNotEmpty) {
                  Usuario novoUsuario = Usuario(
                    nome: nomeController.text,
                    email: emailController.text,
                    cpf: cpfController.text,
                  );
                  Navigator.pop(context, novoUsuario);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.userAviso)),
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
