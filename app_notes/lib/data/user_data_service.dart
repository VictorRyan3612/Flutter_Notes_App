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
  List<User> originalList =[];

  // load users from the file
  Future<List<User>> loadUsersFromFile() async {
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
  void loadUsers() async {
    var json = await loadUsersFromFile();
    usersStateNotifier.value = {
      'status':TableStatus.ready,
      'dataObjects': json
    };
    originalList = json;
  }

  // Save Users to the file
  Future<void> saveUsers(List<User> users) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/users.dat');
    String content = json.encode(users.map((user) => user.toMap()).toList());
    await file.writeAsString(content);
  }


  // Crate new user
  void createUser(User newUser){
    usersStateNotifier.value['dataObjects'] = [...usersStateNotifier.value['dataObjects'], newUser];
    usersStateNotifier.value['dataObjects'] = List<User>.from(usersStateNotifier.value['dataObjects']);

    saveUsers(usersStateNotifier.value['dataObjects']);
    loadUsers();
  }

  void deleteUser(User user) {
    user.status = 'x';
    saveUsers(usersStateNotifier.value['dataObjects']);
    loadUsers();
  }

  // Delete user
  void updateUser({
    required List<User> listUsers,
    required int index,
    required User novoUser,
  }) {

    listUsers[index] = novoUser;

    userDataService.saveUsers(listUsers);
    loadUsers();
  }


  // Filer User by seach
  void filterCurrentState(String filtrar) {
    List<User> objectsOriginals = originalList;
    if (objectsOriginals.isEmpty) return;

    List<User> objectsFiltered = [];
    if (filtrar != '') {
      for (var objetoInd in objectsOriginals) {
        if (objetoInd.name.toLowerCase().contains(filtrar.toLowerCase())) {
          objectsFiltered.add(objetoInd);
        }
      }
    } else {
      objectsFiltered = objectsOriginals;
    }
    

    issueFilteredState(objectsFiltered);
  }


  // Overriding filtered users in usersStateNotifier.value
  void issueFilteredState(List<User> objectsFiltered) {
    var state = Map<String, dynamic>.from(usersStateNotifier.value);
    state['dataObjects'] = objectsFiltered;
    usersStateNotifier.value = state;
  }


  // sort users, still having problems with sorting and editing
  sort(){
    var state = Map<String, dynamic>.from(usersStateNotifier.value);

    if (!isSorted){
      state['dataObjects'].sort((User a, User b) => a.name.compareTo(b.name));
      usersStateNotifier.value = state;
      isSorted= true;
    } 
    else{
      state['dataObjects'] = List.from(state['dataObjects'].reversed);
      usersStateNotifier.value = state;
    }
  }
  
  

}

final UserDataService userDataService = UserDataService();
