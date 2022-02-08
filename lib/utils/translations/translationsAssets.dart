abstract class TranslationsAssets {
  String get account;
}

class TranslationsEnAssets implements TranslationsAssets {
  get account => 'Assets';
}

class TranslationsDeAssets implements TranslationsAssets {
  String get account => 'Konto';
}

class TranslationsZhAssets implements TranslationsAssets {
  get account => '账户';
}
