abstract class TranslationsProfile {
  String get account;
}

class TranslationsEnProfile implements TranslationsProfile {
  get account => 'Profile';
}

class TranslationsDeProfile implements TranslationsProfile {
  String get account => 'Konto';
}

class TranslationsZhProfile implements TranslationsProfile {
  get account => '账户';
}
