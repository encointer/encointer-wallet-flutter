import 'package:encointer_wallet/extras/utils/translations/translations.dart';
import 'package:flutter/material.dart';

class I18n {
  I18n(this.locale);

  final Locale locale;

  static I18n? of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  /// this will be used in different places, also supportedLocales.keys
  static final Map<Locale, Translations> supportedLocales = {
    const Locale('en', ''): TranslationsEn(),
    const Locale('de', ''): TranslationsDe(),
    const Locale('fr', ''): TranslationsFr(),
    const Locale('ru', ''): TranslationsRu(),
  };

  Translations translationsForLocale() {
    final translations = supportedLocales[locale];
    return translations ?? TranslationsEn();
  }
}
