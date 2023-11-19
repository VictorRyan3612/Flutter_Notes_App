import 'package:flutter/material.dart';
import '../data/var_json.dart' show varColor;


MaterialColor colorStateVar = Colors.blue;


// iconTheme(colorName){
//   var colorColors = searchCodColorByName(colorName);
//   return colorColors;
// }

// Setting light and dark themes
ThemeData setTheme(Brightness colorTema, colorName) {
  var colorColors = searchCodColorByName(colorName);
  colorStateVar = colorColors;

  ThemeData finalTema;
  if (colorTema == Brightness.dark){
    finalTema = ThemeData(
      appBarTheme:  AppBarTheme(
        iconTheme: IconThemeData(color: colorStateVar),
        backgroundColor: const Color.fromARGB(255, 66, 66, 66),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
          )
        ),
      
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.black, 
        contentTextStyle: TextStyle(color: Colors.white)
      ),
      brightness: Brightness.dark,
      primarySwatch: colorColors,
      inputDecorationTheme: const InputDecorationTheme(
        filled:true,
        fillColor: Color.fromARGB(255, 66, 66, 66), 
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)
    );
  }
  else{ // colorTema == Brightness.light
    finalTema = ThemeData(
      appBarTheme:  AppBarTheme(
        iconTheme: IconThemeData(color: colorStateVar),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black
          )
        ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white, 
        contentTextStyle: TextStyle(color: Colors.black)
      ),
      brightness: Brightness.light,
      primarySwatch: colorColors,
      inputDecorationTheme: const InputDecorationTheme(
        filled:true,
        fillColor: Colors.white, 
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175)
    );
  }
  return finalTema;
} 

// Search for varColor['name'] colorresponding to varColor['color'] 
// passed as a parameter of currentColor.value
searchNameByCod(codColor){
  return varColor.firstWhere(
    (item) => item['color'] == codColor,
    orElse: () => varColor[0]
  )['name'];
  
}

// Search for varColor['color'] corresponding to varColor['name'] 
// passed as a parameter of currentColor.value
searchCodColorByName(strColor){
  return varColor.firstWhere(
    (item) => item['name'] == strColor,
    orElse: () => varColor[0]
  )['color'];
}

