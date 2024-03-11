import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService{
  ValueNotifier<bool> hasALoadedNote = ValueNotifier(false);
  ValueNotifier<bool> isMobile = ValueNotifier(false);
  ValueNotifier<bool> isGridView = ValueNotifier(false);
  ValueNotifier<bool> desktopLoadView = ValueNotifier(true);
  ValueNotifier<String> dropDownValueText = ValueNotifier('title');
  ValueNotifier<String> currentStatusNotes = ValueNotifier('v');
  
  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('isGridView', isGridView.value);
  }


  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final isGridViewPref = prefs.getBool('isGridView') ?? false;
    isGridView.value = isGridViewPref;
  }
}

SettingsService settingsService = SettingsService();
