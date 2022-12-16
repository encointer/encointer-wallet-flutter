/// contains translations for Account
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsAccount {
  String get advanced;
  String get backupError;
  String get create;
  String get createError;
  String get createHint;
  String get createPassword;
  String get createPassword2;
  String get createPassword2Error;
  String get createPasswordError;
  String get importDuplicate;
  String get importEncrypt;
  String get importInvalid;
  String get importInvalidRawSeed;
  String get importInvalidMnemonic;
  String get importMustNotBeEmpty;
  String get importPrivateKeyUnsupported;
  String get keystore;
  String get list;
  String get mnemonic;
  String get next;
  String get observe;
  String get observeBrief;
  String get observeProxyInvalid;
  String get path;
  String get qrScan;
  String get rawSeed;
  String get uosCanceled;
  String get uosPush;
  String get uosScan;
  String get uosSigner;
  String get uosTitle;
}

class TranslationsEnAccount implements TranslationsAccount {
  @override
  String get advanced => 'Advanced Options';
  @override
  String get backupError =>
      'This device does not support key type sr25519, you can select [Advanced Options -> Encrypt Type -> ed25519] to continue.';
  @override
  String get create => 'Create Account';
  @override
  String get createError => 'There was an error creating your account';
  @override
  String get createHint => '(Example: Alice)';
  @override
  String get createPassword => 'PIN';
  @override
  String get createPassword2 => 'Confirm PIN';
  @override
  String get createPassword2Error => 'Inconsistent PINs';
  @override
  String get createPasswordError => 'PIN must contain at least 4 digits and no other signs';
  @override
  String get importDuplicate => 'Account exists, do you want to override the existing account?';
  @override
  String get importEncrypt => 'Encrypt Type';
  @override
  String get importInvalid => 'Invalid';
  @override
  String get importInvalidRawSeed => 'Invalid raw seed supplied';
  @override
  String get importInvalidMnemonic => 'Invalid mnemonic supplied';
  @override
  String get importMustNotBeEmpty => 'Input must not be empty';
  @override
  String get importPrivateKeyUnsupported => 'Private key account import is not yet supported.';
  @override
  String get keystore => 'Keystore (json)';
  @override
  String get list => 'Account Select';
  @override
  String get mnemonic => 'Mnemonic';
  @override
  String get next => 'Next';
  @override
  String get observe => 'Observation';
  @override
  String get observeBrief =>
      "Mark this address as observation, then you can select this address in account select page, to watch it's assets and actions";
  @override
  String get observeProxyInvalid => 'Invalid proxy account';
  @override
  String get path => 'Secret derivation path';
  @override
  String get qrScan => 'Scan QR code';
  @override
  String get rawSeed => 'Raw Seed';
  @override
  String get uosCanceled => 'Transaction canceled';
  @override
  String get uosPush => 'Scan to publish';
  @override
  String get uosScan => 'Scan signed and send';
  @override
  String get uosSigner => 'Signer';
  @override
  String get uosTitle => 'Offline Signature';
}

class TranslationsDeAccount implements TranslationsAccount {
  @override
  String get advanced => 'Erweiterte Optionen';
  @override
  String get backupError =>
      'Dieses Gerät unterstützt den key Typ sr25519 nicht, wähle [Erweiterte Optionen -> Verschlüsselungstyp -> ed225519] für den nächsten Schritt.';
  @override
  String get create => 'Konto registrieren';
  @override
  String get createError => 'Beim Erstellen deines Kontos ist ein Fehler aufgetreten';
  @override
  String get createHint => '(Beispiel: Alice)';
  @override
  String get createPassword => 'PIN';
  @override
  String get createPassword2 => 'PIN Bestätigen';
  @override
  String get createPassword2Error => 'Die PINs stimmen nicht überein';
  @override
  String get createPasswordError => 'Der PIN muss aus mindestens 4 Ziffern bestehen und keinen anderen Zeichen';
  @override
  String get importDuplicate => 'Dieses Konto existiert bereits, möchtest du es überschreiben?';
  @override
  String get importEncrypt => 'Verschlüsselungstyp';
  @override
  String get importInvalid => 'Ungültig';
  @override
  String get importInvalidRawSeed => 'Ungültigen raw seed eingegeben.';
  @override
  String get importInvalidMnemonic => 'Ungültige Mnemonik eingegeben.';
  @override
  String get importMustNotBeEmpty => 'Eingabe darf nicht leer sein.';
  @override
  String get importPrivateKeyUnsupported => 'Konto importieren mit privatem Schlüssel wird noch nicht unterstützt.';
  @override
  String get keystore => 'Keystore (json)';
  @override
  String get list => 'Kontoauswahl';
  @override
  String get mnemonic => 'Mnemonik';
  @override
  String get next => 'Nächster Schritt';
  @override
  String get observe => 'Überwachen';
  @override
  String get observeBrief =>
      'Markiere diese Adresse als zu überwachen, dann kann diese Adresse in der Kontoauswahlseite ausgewählt werden, um dessen Vermögen und Aktionen zu überwachen.';
  @override
  String get observeProxyInvalid => 'Ungültiges Proxy-Konto';
  @override
  String get path => 'Geheimer Derivationspfad';
  @override
  String get qrScan => 'Scanne QR Code';
  @override
  String get rawSeed => 'Raw Seed';
  @override
  String get uosCanceled => 'Transaktion abgebrochen';
  @override
  String get uosPush => 'Scannen um zu veröffentlichen';
  @override
  String get uosScan => 'Signierte Transaktion scannen und senden';
  @override
  String get uosSigner => 'Signierer';
  @override
  String get uosTitle => 'Offline Signatur';
}

class TranslationsFrAccount implements TranslationsAccount {
  @override
  String get advanced => throw UnimplementedError();
  @override
  String get backupError => throw UnimplementedError();
  @override
  String get create => throw UnimplementedError();
  @override
  String get createError => throw UnimplementedError();
  @override
  String get createHint => throw UnimplementedError();
  @override
  String get createPassword => throw UnimplementedError();
  @override
  String get createPassword2 => throw UnimplementedError();
  @override
  String get createPassword2Error => throw UnimplementedError();
  @override
  String get createPasswordError => throw UnimplementedError();
  @override
  String get importDuplicate => throw UnimplementedError();
  @override
  String get importEncrypt => throw UnimplementedError();
  @override
  String get importInvalid => throw UnimplementedError();
  @override
  String get importInvalidRawSeed => throw UnimplementedError();
  @override
  String get importInvalidMnemonic => throw UnimplementedError();
  @override
  String get importMustNotBeEmpty => throw UnimplementedError();
  @override
  String get importPrivateKeyUnsupported => throw UnimplementedError();
  @override
  String get keystore => throw UnimplementedError();
  @override
  String get list => throw UnimplementedError();
  @override
  String get mnemonic => throw UnimplementedError();
  @override
  String get next => throw UnimplementedError();
  @override
  String get observe => throw UnimplementedError();
  @override
  String get observeBrief => throw UnimplementedError();
  @override
  String get observeProxyInvalid => throw UnimplementedError();
  @override
  String get path => throw UnimplementedError();
  @override
  String get qrScan => throw UnimplementedError();
  @override
  String get rawSeed => throw UnimplementedError();
  @override
  String get uosCanceled => throw UnimplementedError();
  @override
  String get uosPush => throw UnimplementedError();
  @override
  String get uosScan => throw UnimplementedError();
  @override
  String get uosSigner => throw UnimplementedError();
  @override
  String get uosTitle => throw UnimplementedError();
}

class TranslationsRuAccount implements TranslationsAccount {
  @override
  String get advanced => 'Дополнительные параметры';
  @override
  String get backupError =>
      'Это устройство не поддерживает тип ключа sr25519. Чтобы продолжить, выберите [Дополнительные параметры -> Тип шифрования -> ed25519].';
  @override
  String get create => 'Создать аккаунт';
  @override
  String get createError => 'При создании аккаунта произошла ошибка';
  @override
  String get createHint => '(Пример: Алиса)';
  @override
  String get createPassword => 'PIN-код';
  @override
  String get createPassword2 => 'Подтвердите PIN-код';
  @override
  String get createPassword2Error => 'PIN-коды не совпадают';
  @override
  String get createPasswordError => 'PIN должен содержать не менее 4 цифр и никаких других знаков';
  @override
  String get importDuplicate => 'Учетная запись существует, вы хотите аннулировать существующий аккаунт?';
  @override
  String get importEncrypt => 'Тип шифрования';
  @override
  String get importInvalid => 'Недопустимый';
  @override
  String get importInvalidRawSeed => 'Предоставлен недопустимый raw seed';
  @override
  String get importInvalidMnemonic => 'Предоставлена недопустимая мнемоника';
  @override
  String get importMustNotBeEmpty => 'Входные данные не должны быть пустыми';
  @override
  String get importPrivateKeyUnsupported => 'Импорт аккаунта с помощью секретного ключа пока не поддерживается.';
  @override
  String get keystore => 'Хранилище ключей (json)';
  @override
  String get list => 'Выбрать аккаунт';
  @override
  String get mnemonic => 'Мнемоническая фраза';
  @override
  String get next => 'Следующий';
  @override
  String get observe => 'Мониторинг';
  @override
  String get observeBrief =>
      'Отметьте это адрес как подлежащий мониторингу, позже вы сможете выбрать этот адрес на странице выбора аккаунта, для просмотра его активов и действий';
  @override
  String get observeProxyInvalid => 'Неверный прокси-аккаунт';
  @override
  String get path => 'Секретный путь вывода';
  @override
  String get qrScan => 'Сканируйте QR-код';
  @override
  String get rawSeed => 'Raw Seed';
  @override
  String get uosCanceled => 'Транзакция отменена';
  @override
  String get uosPush => 'Сканировать для публикации';
  @override
  String get uosScan => 'Сканируйте подписанное и отправьте';
  @override
  String get uosSigner => 'Подписавший';
  @override
  String get uosTitle => 'Оффлайн подпись';
}
