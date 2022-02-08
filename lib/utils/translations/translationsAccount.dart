abstract class TranslationsAccount {
  String get account;
}

class TranslationsEnAccount implements TranslationsAccount {
  get account => 'Account';
}

class TranslationsDeAccount implements TranslationsAccount {
  String get account => 'Konto';
}

class TranslationsZhAccount implements TranslationsAccount {
  get account => '账户';
}
