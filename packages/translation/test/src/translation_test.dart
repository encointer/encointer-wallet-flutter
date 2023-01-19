import 'package:ew_translations/translation.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('AppLocalizationsDelegate should support en, de, fr, and ru', () {
    const delegate = AppLocalizationsDelegate(Locale('en'));

    expect(delegate.isSupported(const Locale('en', '')), isTrue);
    expect(delegate.isSupported(const Locale('de', '')), isTrue);
    expect(delegate.isSupported(const Locale('fr', '')), isTrue);
    expect(delegate.isSupported(const Locale('ru', '')), isTrue);
    expect(delegate.isSupported(const Locale('es', '')), isFalse);
  });

  test('I18n should return correct translations for different locales', () {
    const i18nEn = I18n(Locale('en', ''));
    expect(i18nEn.translationsForLocale(), isA<TranslationsEn>());

    const i18nDe = I18n(Locale('de', ''));
    expect(i18nDe.translationsForLocale(), isA<TranslationsDe>());

    const i18nFr = I18n(Locale('fr', ''));
    expect(i18nFr.translationsForLocale(), isA<TranslationsFr>());

    const i18nRu = I18n(Locale('ru', ''));
    expect(i18nRu.translationsForLocale(), isA<TranslationsRu>());
  });

  test('I18n should return English translations for unsupported locales', () {
    const i18n = I18n(Locale('invalid', ''));
    expect(i18n.translationsForLocale(), isA<TranslationsEn>());
  });
}
