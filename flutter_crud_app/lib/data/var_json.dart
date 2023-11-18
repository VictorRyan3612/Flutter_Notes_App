import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_hooks/flutter_hooks.dart' show useTextEditingController;
import 'user_data_service.dart' show User;


// Card Creation
class CardsMenu {
  static List<Map<String, String>> getCards(context) {
    return [
      {
        "title": AppLocalizations.of(context)!.userCardTitle,
        "rota": '/users',
      },
      {
        "title": AppLocalizations.of(context)!.configsCardTitle,
        "rota": '/configs',
      },
    ];
  }
}

class UserDetailVar {
  final User? userAtual;
  UserDetailVar({required this.userAtual});

  List<Map<String, dynamic>> getCards(context) {
    final nameController =
        useTextEditingController(text: userAtual?.name ?? '');
    final emailController =
        useTextEditingController(text: userAtual?.email ?? '');
    final addressController =
        useTextEditingController(text: userAtual?.address ?? '');

    return [
      {
        "controller": nameController,
        "labelText": AppLocalizations.of(context)!.userFieldName,
      },
      {
        "controller": emailController,
        "labelText": AppLocalizations.of(context)!.userFieldEmail,
      },
      {
        "controller": addressController,
        "labelText": AppLocalizations.of(context)!.userFieldAddress,
      },
    ];
  }
}

var userDetail = [
  {
    'controller': 'nameController',
    'textname': 'AppLocalizations.of(context)!.userFieldName'
  }
];

var starScreenList =[
  {
    'name': 'Tela inicial',
    'route': '/'
  },
  {
    'name': 'Usuarios',
    'route': '/users'
  },
];

searchRouteByName(nameRoute){
  return starScreenList.firstWhere(
    (item) => item['name'] == nameRoute,
    orElse: () => starScreenList[0]
  )['route'];
}

searchNameByRoute(codRoute){
  return starScreenList.firstWhere(
    (item) => item['route'] == codRoute,
    orElse: () => starScreenList[0]
  )['name'];
}


var varColor = [
  {
    'name': 'Blue',
    'color': Colors.blue
  },
  {
    'name': 'Brown',
    'color': Colors.brown
  },
  {
    'name': 'Green',
    'color': Colors.green
  },
  {
    'name': 'Gray',
    'color': Colors.grey
  },
  {
    'name': 'Orange',
    'color': Colors.orange
  },
  {
    'name': 'Pink',
    'color': Colors.pink
  },
  {
    'name': 'Purple',
    'color': Colors.purple
  },
  {
    'name': 'Red',
    'color': Colors.red
  },
  {
    'name': 'Yellow',
    'color': Colors.yellow
  },
];

// var listaLanguagens = [
//   {
//     "key": "pt",
//     "name": "English",
//   },
//   {
//     "key": "pt",
//     "name": "Portuguese",
//   }
// ];
