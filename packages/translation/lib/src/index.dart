import 'package:ew_translations/translation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class I18n {
  const I18n(this.locale);

  final Locale locale;

  static I18n of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n)!;
  }

  /// this will be used in different places, also supportedLocales.keys
  static final Map<Locale, Translations> supportedLocales = {
    const Locale('en', ''): TranslationsEn(),
    const Locale('de', ''): TranslationsDe(),
    const Locale('fr', ''): TranslationsFr(),
    const Locale('ru', ''): TranslationsRu(),
  };

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  Translations translationsForLocale() {
    final translations = supportedLocales[locale];
    return translations ?? TranslationsEn();
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<I18n> {
  const AppLocalizationsDelegate(this.overriddenLocale);

  final Locale overriddenLocale;

  @override
  bool isSupported(Locale locale) => ['en', 'de', 'fr', 'ru'].contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) {
    return SynchronousFuture<I18n>(I18n(overriddenLocale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => true;
}

extension LocalizationsX on BuildContext {
  // Returns the translations object for the current locale
  Translations get dic => I18n.of(this).translationsForLocale();
}
