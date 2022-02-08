abstract class TranslationsEncointer {
  String get account;
}

class TranslationsEnEncointer implements TranslationsEncointer {
  get account => 'Encointer';
}

class TranslationsDeEncointer implements TranslationsEncointer {
  String get account => 'Konto';
}

class TranslationsZhEncointer implements TranslationsEncointer {
  get account => '账户';
}
