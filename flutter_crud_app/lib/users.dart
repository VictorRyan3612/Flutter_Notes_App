import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'widgets/user_card.dart';
import 'widgets/my_app_bar.dart';
import 'data/user_data_service.dart';


class UserScreen extends HookWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final userListNotifier = userDataService.userListNotifier; 
    final listaUsuario = useState<List<Usuario>>([]);
    
    Future<void> carregarUsuarios() async {
      listaUsuario.value = await userDataService.loadUsers();
    }


    useEffect(() {
      carregarUsuarios();

      return null;
    }, const []);



    return Scaffold(
      appBar: MyAppBar(callback: userDataService.filtrarEstadoAtual),
        
      // body: ListView.builder(
      //   itemCount: listaUsuario.value.length,
      //   itemBuilder: (context, index) {
      body: ValueListenableBuilder(
        valueListenable: userDataService.usersStateNotifier, 
        builder: (_, value, __){
          print("${value}");
          ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              if (value[index].status == "v") {
                return UsuarioCard(
                  cardTitle: listaUsuario.value[index].nome,
                  cardSubtitle: listaUsuario.value[index].email,

                  onEditPressed: () async {
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
                      userDataService.atualizarUsuario(
                        listaUsers: listaUsuario.value,
                        novoUsuario: novaUsuario,
                        index: index,
                        funcaoCarregar: carregarUsuarios

                      );
                    }
                  },
                  
                  onDeletePressed: () {
                    userDataService.deleteUser(listaUsuario.value[index], carregarUsuarios);
                    
                  },
                );
              }
              else {
                return Container();
              }
              
            
            }
          );
          return const Center(
            child: Text("Erro desconhecido")
          );
        }
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
            userDataService.saveUsers(listaUsuario.value);
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
