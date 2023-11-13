import 'package:flutter/material.dart';
import 'package:flutter_crud_app/screens/dashboard_menu.dart';
import 'package:flutter_crud_app/screens/tela_configs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'users.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentBrightness = useState(Brightness.dark);
    
    final darkTheme = ThemeData(
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.black, 
        contentTextStyle: TextStyle(color: Colors.white)
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 27, 27, 27)
    );
    final lightTheme = ThemeData(
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white, 
        contentTextStyle: TextStyle(color: Colors.black)
      ),
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175)
    );
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('pt')
        ],
      locale: const Locale('en'),
      
      debugShowCheckedModeBanner:false,

      
      theme: currentBrightness.value == Brightness.dark ? darkTheme : lightTheme,

      
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardMenu(
          cards: [
            {
              "title": AppLocalizations.of(context)!.usercardtitle,
              "rota": '/users'
            },
            {
              "title": AppLocalizations.of(context)!.configcardtitle,
              "rota": '/configs'
            }
            
          ],
          titulo: AppLocalizations.of(context)!.mainapptitle
        ),
        '/users': (context) => const UserScreen(),
        '/configs': (context) => TelaConfigs(currentBrightness: currentBrightness)
      }
    );
      
  }
}

