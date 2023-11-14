import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:card_settings/card_settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaConfigs extends HookWidget implements PreferredSizeWidget{
  final ValueNotifier<Brightness> currentBrightness;
  final ValueNotifier<Locale> currentLocale;

  const TelaConfigs({required this.currentBrightness, required this.currentLocale, super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    Future<void> saveSettings() async {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool('isDarkMode', currentBrightness.value == Brightness.dark);
      prefs.setString('languageCode', currentLocale.value.languageCode);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.configspagetitle),
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
                        label: AppLocalizations.of(context)!.configsheader,
                      ),
                      children: [
                        CardSettingsSwitch(
                          trueLabel: '', 
                          falseLabel: '',
                          label: AppLocalizations.of(context)!.configsmodetheme,
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
                        CardSettingsListPicker(
                          label: AppLocalizations.of(context)!.configslanguagepick,
                          items: AppLocalizations.supportedLocales,
                          initialItem: currentLocale.value,
                          onChanged: (value1) {
                            currentLocale.value = value1!;
                            saveSettings();
                          }   
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