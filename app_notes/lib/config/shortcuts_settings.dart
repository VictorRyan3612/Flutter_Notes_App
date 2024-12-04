import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:app_notes/config/focus_settings.dart';

class ShortcutsSettings {
  static Map<ShortcutActivator, VoidCallback> getGlobalShortcuts() {
    return {
      const SingleActivator(LogicalKeyboardKey.keyF, control: true): () => focusSettings.focusSeachTextField(),
    };
  }
}
