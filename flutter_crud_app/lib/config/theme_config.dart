import 'package:flutter/material.dart';
import '../data/var_json.dart' show varColor;

// Setting light and dark themes
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

// Search for varColor['name'] corresponding to varColor['color'] 
// passed as a parameter of currentColor.value
searchNameByCod(codCor){
  return varColor.firstWhere(
    (item) => item['color'] == codCor,
    orElse: () => varColor[0]
  )['name'];
  
}

// Search for varColor['color'] corresponding to varColor['name'] 
// passed as a parameter of currentColor.value
searchCodCorByName(strColor){
  return varColor.firstWhere(
    (item) => item['name'] == strColor,
    orElse: () => varColor[0]
  )['color'];
}

