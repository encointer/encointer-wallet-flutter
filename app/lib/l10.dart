import 'package:encointer_wallet/gen/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

export 'package:encointer_wallet/gen/l10n/app_localizations.dart';

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
