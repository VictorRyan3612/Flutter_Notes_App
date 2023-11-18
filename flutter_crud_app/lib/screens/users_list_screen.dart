import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// My packages
import '../widgets/user_card.dart';
import '../config/theme_config.dart' show corStateVar;
import '../widgets/search_section.dart';
import '../data/user_data_service.dart';
import 'users_detail_screen.dart';



// User list screen
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    userDataService.carregarUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.userPageTitle)
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
                        return UserCard(
                          cardTitle: value['dataObjects'][index].name,
                          cardSubtitle: value['dataObjects'][index].email,
                          
                          // Edit user
                          onEditPressed: () async {
                            User? newUser = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetail(
                                  titulo: AppLocalizations.of(context)!.userTitleEdit,
                                  userAtual: value['dataObjects'][index]
                                ),
                              ),
                            );
                            if (newUser != null) {
                              userDataService.atualizarUser(
                                listaUsers: value['dataObjects'],
                                novoUser: newUser,
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
        backgroundColor: corStateVar,
        onPressed: () async {
          User? newUser = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetail(
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
