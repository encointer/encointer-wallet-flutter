abstract class TranslationsBazaar {
  String get account;
}

class TranslationsEnBazaar implements TranslationsBazaar {
  get account => 'Bazaar';
}

class TranslationsDeBazaar implements TranslationsBazaar {
  String get account => 'Konto';
}

class TranslationsZhBazaar implements TranslationsBazaar {
  get account => '账户';
}
