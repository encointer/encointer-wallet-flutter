import 'dart:async';

import 'package:encointer_wallet/utils/i18n/assets.dart';
import 'package:encointer_wallet/utils/i18n/bazaar.dart';
import 'package:encointer_wallet/utils/i18n/encointer.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';

import 'account.dart';
import 'bazaar.dart';
import 'home.dart';
import 'profile.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<I18n> {
  const AppLocalizationsDelegate(this.overriddenLocale);

  final Locale overriddenLocale;

  @override
  bool isSupported(Locale locale) => ['en', 'de', 'zh'].contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) {
    return SynchronousFuture<I18n>(I18n(overriddenLocale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}

class I18n {
  I18n(this.locale);

  final Locale locale;

  static I18n of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  /// this will be used in different places, also supportedLocales.keys
  static final Map<Locale, Translations> supportedLocales = {
    Locale('en', ''): TranslationsEn(),
    Locale('de', ''): TranslationsDe(),
    Locale('zh', ''): TranslationsZh(),
  };

  Translations translationsForLocale() {
    var translations = supportedLocales[locale];
    return translations != null ? translations : TranslationsEn();
  }

  static Map<String, Map<String, Map<String, String>>> _localizedValues = {
    'en': {
      'home': enHome,
      'account': enAccount,
      'assets': enAssets,
      'profile': enProfile,
      'encointer': enNctr,
      'bazaar': enBazaar,
    },
    'de': {
      'home': deHome,
      'account': deAccount,
      'assets': deAssets,
      'profile': deProfile,
      'encointer': deNctr,
      'bazaar': deBazaar,
    }
  };

  Map<String, String> get home {
    return _localizedValues[locale.languageCode]['home'];
  }

  Map<String, String> get account {
    return _localizedValues[locale.languageCode]['account'];
  }

  Map<String, String> get assets {
    return _localizedValues[locale.languageCode]['assets'];
  }

  Map<String, String> get profile {
    return _localizedValues[locale.languageCode]['profile'];
  }

  Map<String, String> get encointer {
    return _localizedValues[locale.languageCode]['encointer'];
  }

  Map<String, String> get bazaar {
    return _localizedValues[locale.languageCode]['bazaar'];
  }
}
