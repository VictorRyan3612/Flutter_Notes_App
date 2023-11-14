import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../users.dart';

class UserDataService {
  Future<List<Usuario>> loadUsers() async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/users.dat');

    if (file.existsSync()) {
      String content = await file.readAsString();
      if (content != '') {
        List<dynamic> jsonList = json.decode(content);
        return jsonList.map((json) => Usuario(
          nome: json['nome'],
          email: json['email'],
          cpf: json['cpf'],
          status: json['status'],
        )).toList();
      }
    }

    return [];
  }

  Future<void> saveUsers(List<Usuario> users) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/users.dat');
    String content = json.encode(users.map((user) => user.toMap()).toList());
    await file.writeAsString(content);
  }

  void deleteUser(List<Usuario> users, int index) {
    users[index].status = 'x';
  }
}

final UserDataService userDataService = UserDataService();
