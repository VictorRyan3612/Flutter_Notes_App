import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// My packages
import '../widgets/user_card.dart';
import '../widgets/my_app_bar.dart';
import '../data/user_data_service.dart';
import 'users_detail_screen.dart';


// User list screen
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    userDataService.carregarUsuarios();
    return Scaffold(
      appBar: MyAppBar(
        callbackFilter: userDataService.filtrarEstadoAtual,
        callbackSort: userDataService.sort,
        ),
      body: ValueListenableBuilder(
        valueListenable: userDataService.usersStateNotifier,

        builder: (_, value, __) {
          // Message if there are no users
          if ((value['dataObjects'].length == 0) && (value['status'] == TableStatus.ready)) {
            return Center(
              child: Text(AppLocalizations.of(context)!.userNoUser,
                style: const TextStyle(fontSize: 30)
              )
            );
          } 

          else {
            return ListView.builder(
              itemCount: value['dataObjects'].length,
              itemBuilder: (context, index) {
                switch (value['status']) {
                  case TableStatus.idle:
                    Text(AppLocalizations.of(context)!.userWait);

                  case TableStatus.ready:
                    // if (value['dataObjects'].isNotEmpty) {
                      if (value['dataObjects'][index].status == 'v') {
                        // Create Cads for each user
                        return UsuarioCard(
                          cardTitle: value['dataObjects'][index].nome,
                          cardSubtitle: value['dataObjects'][index].email,
                          
                          // Edit user
                          onEditPressed: () async {
                            Usuario? newUser = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsuarioDetail(
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
                          // Delete user
                          onDeletePressed: () {
                            userDataService.deleteUser(value['dataObjects'][index]);
                          },
                        );
                      }else{
                        return Container();
                      }
                    // }        
                    // else {
                    //   return Center(
                    //     child: Text(
                    //       AppLocalizations.of(context)!.userEmpty,
                    //       style: const TextStyle(fontSize: 30)
                    //     )
                    //   );
                    // }
                }
                return null;
              }
            );
          }
        }
          
      ),
      // Button to crate a user
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Usuario? newUser = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UsuarioDetail(
                titulo: AppLocalizations.of(context)!.userTitleCreate),
            ),
          );
          if (newUser != null) {
            userDataService.criarUser(newUser);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
