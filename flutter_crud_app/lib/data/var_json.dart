import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart' show Colors;


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
    'nome': 'Blue',
    'color': Colors.blue
  },
  {
    'nome': 'Brown',
    'color': Colors.brown
  },
  {
    'nome': 'Green',
    'color': Colors.green
  },
  {
    'nome': 'Gray',
    'color': Colors.grey
  },
  {
    'nome': 'Orange',
    'color': Colors.orange
  },
  {
    'nome': 'Pink',
    'color': Colors.pink
  },
  {
    'nome': 'Purple',
    'color': Colors.purple
  },
  {
    'nome': 'Red',
    'color': Colors.red
  },
  {
    'nome': 'Yellow',
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
