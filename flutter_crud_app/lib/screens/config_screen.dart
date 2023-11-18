import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/var_json.dart' show varColor, starScreenList, searchNameByRoute, searchRouteByName;


// Config Screen
class ConfigScreen extends HookWidget{
  final ValueNotifier<Brightness> currentBrightness;
  final ValueNotifier<Locale> currentLocale;
  final ValueNotifier<String> currentColor;
  final ValueNotifier<String> currentStartScreen;

  const ConfigScreen({super.key, 
    required this.currentBrightness, 
    required this.currentLocale, 
    required this.currentColor, 
    required this.currentStartScreen
    });


  @override
  Widget build(BuildContext context) {

    // Save settings to file
    Future<void> saveSettings() async {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('isDarkMode', currentBrightness.value == Brightness.dark);
      prefs.setString('languageCode', currentLocale.value.languageCode);
      prefs.setString('colorTheme', currentColor.value);
      prefs.setString('startScreen', currentStartScreen.value);
    }

    var routeNameInitialItem = searchNameByRoute(currentStartScreen.value);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.configsPageTitle),
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child:CardSettings.sectioned(
                  children: [

                    CardSettingsSection(
                      header: CardSettingsHeader(
                        label: AppLocalizations.of(context)!.configsHeader,
                      ),
                      children: [

                        // Config Theme
                        CardSettingsSwitch(
                          trueLabel: '', 
                          falseLabel: '',
                          label: AppLocalizations.of(context)!.configsModeTheme,
                          initialValue:  currentBrightness.value == Brightness.dark,
                          onChanged: (value) {
                            if (currentBrightness.value == Brightness.dark) {
                              currentBrightness.value = Brightness.light;
                            } 
                            else {
                              currentBrightness.value = Brightness.dark;
                              
                            }
                            saveSettings();
                          },
                        ),

                        // Config Locale
                        CardSettingsListPicker(
                          label: AppLocalizations.of(context)!.configsLanguagePick,
                          items: AppLocalizations.supportedLocales,
                          initialItem: currentLocale.value,
                          onChanged: (value1) {
                            currentLocale.value = value1!;
                            saveSettings();
                          }
                        ),

                        // Config Color
                        CardSettingsListPicker(
                          label: "Colors",
                          items: varColor.map((item) => item['name']).toList(),
                          
                          initialItem: currentColor.value,

                          onChanged: (value2) {
                            currentColor.value = value2.toString();
                            saveSettings();
                          },
                        ),
                        CardSettingsListPicker(
                          label: "Tela inicial",
                          items: starScreenList.map((item) => item['name']).toList(),
                          initialItem:  routeNameInitialItem,
                          onChanged: (value3) {
                            var routeFinal = searchRouteByName(value3.toString());
                            currentStartScreen.value = routeFinal;

                            saveSettings();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
}