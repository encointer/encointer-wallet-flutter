import 'package:ew_l10n/l10n.dart';
import 'package:flutter/widgets.dart';

export 'package:ew_l10n/src/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String localeName(String languageCode) => switch (languageCode) {
        'en' => 'English',
        'de' => 'Deutsch',
        'fr' => 'Français',
        'ru' => 'Русский',
        'sw' => 'Swahili',
        _ => '',
      };
}
