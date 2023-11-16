import 'package:flutter/material.dart';

ThemeData setTheme(Brightness corTema, corName) {
  var corColors = searchCodCorByName(corName);
  ThemeData finalTema;
  if (corTema == Brightness.dark){
    finalTema = ThemeData(
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.black, 
        contentTextStyle: TextStyle(color: Colors.white)
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)
    );
  }
  else{ // corTema == Brightness.light
    finalTema = ThemeData(
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white, 
        contentTextStyle: TextStyle(color: Colors.black)
      ),
      brightness: Brightness.light,
      primarySwatch: corColors,
      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175)
    );
  }
  return finalTema;
} 


searchNomeByCod(codCor){
  return varColor.firstWhere(
    (item) => item['color'] == codCor,
    orElse: () => varColor[0]
  )['nome'];
  
}
searchCodCorByName(str){
  return varColor.firstWhere(
    (item) => item['nome'] == str,
    orElse: () => varColor[0]
  )['color'];
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