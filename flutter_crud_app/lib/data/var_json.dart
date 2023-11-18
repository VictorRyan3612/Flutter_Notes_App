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
