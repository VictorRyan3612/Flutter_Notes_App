// flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// my packages
import 'package:flutter_crud_app/screens/tela_configs.dart';
import 'package:flutter_crud_app/screens/dashboard_menu.dart';
import 'var_json.dart';
import 'screens/users_list_screen.dart';
import 'config/theme_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends HookWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentBrightness = useState(Brightness.dark);
    final currentLocale = useState(const Locale("en"));
    final currentColor = useState('Blue');

    Future<void> loadSettings() async {
      final prefs = await SharedPreferences.getInstance();
      
      final isDarkMode = prefs.getBool('isDarkMode') ?? false;
      currentBrightness.value = isDarkMode ? Brightness.dark : Brightness.light;

      final languageCode = prefs.getString('languageCode') ?? 'en';
      currentLocale.value = Locale(languageCode);
      final corTheme = prefs.getString('colorTheme') ?? 'Blue';
      currentColor.value = corTheme;
    }

    // /config/theme_config.dart
    final finalTheme = setTheme(currentBrightness.value, currentColor.value);

    loadSettings();

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
      locale: currentLocale.value,
      debugShowCheckedModeBanner:false,

      
      // color: currentColor.value,
      theme: finalTheme,
      
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardMenu(
          cards: CardsMenu.getCards(context),
          titulo: AppLocalizations.of(context)!.mainapptitle,
        ),        
        '/users': (context) => const UserScreen(),
        '/configs': (context) => TelaConfigs(
          currentBrightness: currentBrightness,
          currentLocale: currentLocale,
          currentColor: currentColor
          )
      }
    );
      
  }
}
