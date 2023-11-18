import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

// States for the loading Users
enum TableStatus{idle,loading,ready,error}

// Class User
class User {
  late String name;
  late String email;
  late String address;
  late String status;
  User(
    {required this.name,
    required this.email,
    required this.address,
    this.status = "v"}
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'status': status
    };
  }

  String toJson() => json.encode(toMap());
}

// User business rules
class UserDataService {
  final ValueNotifier<List<User>> _userListNotifier = ValueNotifier<List<User>>([]);
  ValueNotifier<List<User>> get userListNotifier => _userListNotifier;

  final ValueNotifier<Map<String,dynamic>> usersStateNotifier = 
    ValueNotifier({
      'status':TableStatus.idle,
      'dataObjects':[],
    }
  );

  bool isSorted = false;
  List<User> listaOriginal =[];

  // load users from the file
  Future<List<User>> loadUsers() async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/users.dat');

    if (file.existsSync()) {
      String content = await file.readAsString();
      if (content != '') {
        List<dynamic> jsonList = json.decode(content);
        List<User> userList = jsonList.map((json) => User(
          name: json['name'],
          email: json['email'],
          address: json['address'],
          status: json['status'],
        )).toList();
        return userList;
      }
    }

    return _userListNotifier.value;
  }

  // Load users and set in usersStateNotifier.value
  void carregarUsers() async {
    var json = await loadUsers();
    usersStateNotifier.value = {
      'status':TableStatus.ready,
      'dataObjects': json
    };
    listaOriginal = json;
  }

  // Save Users to the file
  Future<void> saveUsers(List<User> users) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/users.dat');
    String content = json.encode(users.map((user) => user.toMap()).toList());
    await file.writeAsString(content);
  }


  // Crate new user
  void criarUser(User newUser){
    usersStateNotifier.value['dataObjects'] = [...usersStateNotifier.value['dataObjects'], newUser];
    usersStateNotifier.value['dataObjects'] = List<User>.from(usersStateNotifier.value['dataObjects']);

    saveUsers(usersStateNotifier.value['dataObjects']);
    carregarUsers();
  }

  void deleteUser(User user) {
    user.status = 'x';
    saveUsers(usersStateNotifier.value['dataObjects']);
    carregarUsers();
  }

  // Delete user
  void atualizarUser({
    required List<User> listaUsers,
    required int index,
    required User novoUser,
  }) {

    listaUsers[index] = novoUser;

    userDataService.saveUsers(listaUsers);
    carregarUsers();
  }


  // Filer User by seach
  void filtrarEstadoAtual(String filtrar) {
    List<User> objetosOriginais = listaOriginal;
    if (objetosOriginais.isEmpty) return;

    List<User> objetosFiltrados = [];
    if (filtrar != '') {
      for (var objetoInd in objetosOriginais) {
        if (objetoInd.name.toLowerCase().contains(filtrar.toLowerCase())) {
          objetosFiltrados.add(objetoInd);
        }
      }
    } else {
      objetosFiltrados = objetosOriginais;
    }
    

    emitirEstadoFiltrado(objetosFiltrados);
  }


  // Overriding filtered users in usersStateNotifier.value
  void emitirEstadoFiltrado(List<User> objetosFiltrados) {
    var estado = Map<String, dynamic>.from(usersStateNotifier.value);
    estado['dataObjects'] = objetosFiltrados;
    usersStateNotifier.value = estado;
  }


  // sort users, still having problems with sorting and editing
  sort(){
    var estado = Map<String, dynamic>.from(usersStateNotifier.value);

    if (!isSorted){
      estado['dataObjects'].sort((User a, User b) => a.name.compareTo(b.name));
      usersStateNotifier.value = estado;
      isSorted= true;
    } 
    else{
      estado['dataObjects'] = List.from(estado['dataObjects'].reversed);
      usersStateNotifier.value = estado;
    }
  }
  
  

}

final UserDataService userDataService = UserDataService();
