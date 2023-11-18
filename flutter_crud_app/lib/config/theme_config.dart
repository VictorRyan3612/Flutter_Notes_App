import 'package:flutter/material.dart';
import '../data/var_json.dart' show varColor;


MaterialColor corStateVar = Colors.blue;


// iconTheme(corName){
//   var corColors = searchCodCorByName(corName);
//   return corColors;
// }

// Setting light and dark themes
ThemeData setTheme(Brightness corTema, corName) {
  var corColors = searchCodCorByName(corName);
  corStateVar = corColors;

  ThemeData finalTema;
  if (corTema == Brightness.dark){
    finalTema = ThemeData(
      appBarTheme:  AppBarTheme(
        iconTheme: IconThemeData(color: corStateVar),
        backgroundColor: Color.fromARGB(255, 66, 66, 66),
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
      primarySwatch: corColors,
      inputDecorationTheme: const InputDecorationTheme(
        filled:true,
        fillColor: Color.fromARGB(255, 66, 66, 66), 
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)
    );
  }
  else{ // corTema == Brightness.light
    finalTema = ThemeData(
      appBarTheme:  AppBarTheme(
        iconTheme: IconThemeData(color: corStateVar),
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
      primarySwatch: corColors,
      inputDecorationTheme: const InputDecorationTheme(
        filled:true,
        fillColor: Colors.white, 
      ),
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

