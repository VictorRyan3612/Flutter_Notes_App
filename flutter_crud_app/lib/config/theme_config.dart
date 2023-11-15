import 'package:flutter/material.dart';

ThemeData setTheme(Brightness corTema, MaterialColor corDestaque) {
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
      primarySwatch: corDestaque,
      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175)
    );
  }
  return finalTema;
} 




var varColor = [
  {
    'nome': 'Black',
    'color': Colors.black
  },
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
    'nome': 'White',
    'color': Colors.white
  },
  {
    'nome': 'Yellow',
    'color': Colors.yellow
  },
];
