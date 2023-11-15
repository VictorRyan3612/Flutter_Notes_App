import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/user_card.dart';
import 'widgets/my_app_bar.dart';
import 'data/user_data_service.dart';


class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    userDataService.carregarUsuarios();
    return Scaffold(
      appBar: MyAppBar(callback: userDataService.filtrarEstadoAtual),
        
      body: ValueListenableBuilder(
        valueListenable: userDataService.usersStateNotifier, 

        builder: (_, value, __){
          if ((value['dataObjects'].length == 0) && (value['status'] == TableStatus.ready)){
            return const Center(
              child: Text(
                "Não tem nenhum Usuario",
                style: TextStyle(fontSize: 30)
              )
            );
          }

          else{
            return ListView.builder(
              itemCount: value['dataObjects'].length,
              itemBuilder: (context, index) {             
                switch (value['status']) {
                  case TableStatus.idle:
                    const Text("Em estado de espera");

                  case TableStatus.ready :
                  if (value['dataObjects'].isNotEmpty){
                    return UsuarioCard(
                      cardTitle: value['dataObjects'][index].nome,
                      cardSubtitle: value['dataObjects'][index].email,

                      onEditPressed: () async {
                        Usuario? newUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UsuarioCadastro(
                              titulo: AppLocalizations.of(context)!.userTitleEdit,
                              usuarioAtual: value['dataObjects'][index]
                            ),
                          ),
                        );
                        if (newUser != null) {
                          userDataService.atualizarUsuario(
                            listaUsers: value['dataObjects'],
                            novoUsuario: newUser,
                            index: index,
                          );
                        }
                      },
                      
                      onDeletePressed: () {
                        // userDataService.deleteUser(value['dataObjects'][index], userDataService.carregarUsuarios);
                        
                      },
                    );
                  
                  } else{
                    return const Center(
                      child: Text(
                        "Não tem nenhum Usuario",
                        style: TextStyle(fontSize: 30)
                      )
                    );
                  }
                }
              
              }
            );
          
        }
          }

      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Usuario? newUser = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                UsuarioCadastro(titulo: AppLocalizations.of(context)!.userTitleCreate),
            ),
          );
          if (newUser != null) {
            // listaUsuario.value = [...listaUsuario.value, newUser];
            // userDataService.saveUsers(listaUsuario.value);
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
                  Usuario newUser = Usuario(
                    nome: nomeController.text,
                    email: emailController.text,
                    cpf: cpfController.text,
                  );
                  Navigator.pop(context, newUser);
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
