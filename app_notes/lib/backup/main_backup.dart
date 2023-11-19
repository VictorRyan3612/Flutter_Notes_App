// flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// my packages
import 'screens/config_screen.dart';
import '/screens/dashboard_menu.dart';
import 'screens/users_list_screen.dart';
import 'data/var_json.dart' show CardsMenu;
import 'config/theme_config.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    // base states 
    final currentBrightness = useState(Brightness.dark); //Theme
    final currentLocale = useState(const Locale("en")); // Locale
    final currentColor = useState('Blue'); // Accent color

    // Start with DashboardMenu, change it to initialRoute: '/users' 
    // if you want to start within CRUD, if you do this, go back to access settings
    final currentStartScreen = useState('/');


    // Load settings from file, replacing the initial state
    Future<void> loadSettings() async {
      final prefs = await SharedPreferences.getInstance();
      
      final isDarkMode = prefs.getBool('isDarkMode') ?? false;
      currentBrightness.value = isDarkMode ? Brightness.dark : Brightness.light;

      final languageCode = prefs.getString('languageCode') ?? 'en';
      currentLocale.value = Locale(languageCode);

      final colorTheme = prefs.getString('colorTheme') ?? 'Blue';
      currentColor.value = colorTheme;

      final startScreen = prefs.getString('startScreen') ?? '/';
      currentStartScreen.value = startScreen; 

    }

    loadSettings();

    // /config/theme_config.dart
    final finalTheme = setTheme(currentBrightness.value, currentColor.value);


    return MaterialApp(
      debugShowCheckedModeBanner:false,


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


      locale: currentLocale.value,

      
      // color: currentColor.value,
      theme: finalTheme,
      

      initialRoute: currentStartScreen.value,

      routes: {
        '/': (context) => DashboardMenu(
          cards: CardsMenu.getCards(context),
          title: AppLocalizations.of(context)!.mainapptitle,
        ),
        '/users': (context) => const UserScreen(),
        '/configs': (context) => ConfigScreen(
          currentBrightness: currentBrightness,
          currentLocale: currentLocale,
          currentColor: currentColor,
          currentStartScreen: currentStartScreen ,
          )
      }
    );
      
  }
}