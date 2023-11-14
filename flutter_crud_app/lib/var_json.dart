import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardsMenu {
  static List<Map<String, String>> getCards(context) {
    return [
      {
        "title": AppLocalizations.of(context)!.userCardTitle,
        "rota": '/users',
      },
      {
        "title": AppLocalizations.of(context)!.configsCardTitle,
        "rota": '/configs',
      },
    ];
  }
}
