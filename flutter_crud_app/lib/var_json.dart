import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardsMenu {
  static List<Map<String, String>> getCards(context) {
    return [
      {
        "title": AppLocalizations.of(context)!.usercardtitle,
        "rota": '/users',
      },
      {
        "title": AppLocalizations.of(context)!.configscardtitle,
        "rota": '/configs',
      },
    ];
  }
}
