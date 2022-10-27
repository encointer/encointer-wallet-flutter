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
  get advanced => 'Advanced Options';
  @override
  get backupError =>
      'This device does not support key type sr25519, you can select [Advanced Options -> Encrypt Type -> ed25519] to continue.';
  @override
  get create => 'Create Account';
  @override
  get createError => 'There was an error creating your account';
  @override
  get createHint => '(Example: Alice)';
  @override
  get createPassword => 'PIN';
  @override
  get createPassword2 => 'Confirm PIN';
  @override
  get createPassword2Error => 'Inconsistent PINs';
  @override
  get createPasswordError => 'PIN must contain at least 4 digits and no other signs';
  @override
  get importDuplicate => 'Account exists, do you want to override the existing account?';
  @override
  get importEncrypt => 'Encrypt Type';
  @override
  get importInvalid => 'Invalid';
  @override
  get importInvalidRawSeed => 'Invalid raw seed supplied';
  @override
  get importInvalidMnemonic => 'Invalid mnemonic supplied';
  @override
  get importMustNotBeEmpty => 'Input must not be empty';
  @override
  get importPrivateKeyUnsupported => 'Private key account import is not yet supported.';
  @override
  get keystore => 'Keystore (json)';
  @override
  get list => 'Account Select';
  @override
  get mnemonic => 'Mnemonic';
  @override
  get next => 'Next';
  @override
  get observe => 'Observation';
  @override
  get observeBrief =>
      'Mark this address as observation, then you can select this address in account select page, to watch it\'s assets and actions';
  @override
  get observeProxyInvalid => 'Invalid proxy account';
  @override
  get path => 'Secret derivation path';
  @override
  get qrScan => 'Scan QR code';
  @override
  get rawSeed => 'Raw Seed';
  @override
  get uosCanceled => 'Transaction canceled';
  @override
  get uosPush => 'Scan to publish';
  @override
  get uosScan => 'Scan signed and send';
  @override
  get uosSigner => 'Signer';
  @override
  get uosTitle => 'Offline Signature';
}

class TranslationsDeAccount implements TranslationsAccount {
  @override
  get advanced => 'Erweiterte Optionen';
  @override
  get backupError =>
      'Dieses Gerät unterstützt den key Typ sr25519 nicht, wähle [Erweiterte Optionen -> Verschlüsselungstyp -> ed225519] für den nächsten Schritt.';
  @override
  get create => 'Konto registrieren';
  @override
  get createError => 'Beim Erstellen deines Kontos ist ein Fehler aufgetreten';
  @override
  get createHint => '(Beispiel: Alice)';
  @override
  get createPassword => 'PIN';
  @override
  get createPassword2 => 'PIN Bestätigen';
  @override
  get createPassword2Error => 'Die PINs stimmen nicht überein';
  @override
  get createPasswordError => 'Der PIN muss aus mindestens 4 Ziffern bestehen und keinen anderen Zeichen';
  @override
  get importDuplicate => 'Dieses Konto existiert bereits, möchtest du es überschreiben?';
  @override
  get importEncrypt => 'Verschlüsselungstyp';
  @override
  get importInvalid => 'Ungültig';
  @override
  get importInvalidRawSeed => 'Ungültigen raw seed eingegeben.';
  @override
  get importInvalidMnemonic => 'Ungültige Mnemonik eingegeben.';
  @override
  get importMustNotBeEmpty => 'Eingabe darf nicht leer sein.';
  @override
  get importPrivateKeyUnsupported => 'Konto importieren mit privatem Schlüssel wird noch nicht unterstützt.';
  @override
  get keystore => 'Keystore (json)';
  @override
  get list => 'Kontoauswahl';
  @override
  get mnemonic => 'Mnemonik';
  @override
  get next => 'Nächster Schritt';
  @override
  get observe => 'Überwachen';
  @override
  get observeBrief =>
      'Markiere diese Adresse als zu überwachen, dann kann diese Adresse in der Kontoauswahlseite ausgewählt werden, um dessen Vermögen und Aktionen zu überwachen.';
  @override
  get observeProxyInvalid => 'Ungültiges Proxy-Konto';
  @override
  get path => 'Geheimer Derivationspfad';
  @override
  get qrScan => 'Scanne QR Code';
  @override
  get rawSeed => 'Raw Seed';
  @override
  get uosCanceled => 'Transaktion abgebrochen';
  @override
  get uosPush => 'Scannen um zu veröffentlichen';
  @override
  get uosScan => 'Signierte Transaktion scannen und senden';
  @override
  get uosSigner => 'Signierer';
  @override
  get uosTitle => 'Offline Signatur';
}

class TranslationsFrAccount implements TranslationsAccount {
  @override
  get advanced => throw UnimplementedError();
  @override
  get backupError => throw UnimplementedError();
  @override
  get create => throw UnimplementedError();
  @override
  get createError => throw UnimplementedError();
  @override
  get createHint => throw UnimplementedError();
  @override
  get createPassword => throw UnimplementedError();
  @override
  get createPassword2 => throw UnimplementedError();
  @override
  get createPassword2Error => throw UnimplementedError();
  @override
  get createPasswordError => throw UnimplementedError();
  @override
  get importDuplicate => throw UnimplementedError();
  @override
  get importEncrypt => throw UnimplementedError();
  @override
  get importInvalid => throw UnimplementedError();
  @override
  get importInvalidRawSeed => throw UnimplementedError();
  @override
  get importInvalidMnemonic => throw UnimplementedError();
  @override
  get importMustNotBeEmpty => throw UnimplementedError();
  @override
  get importPrivateKeyUnsupported => throw UnimplementedError();
  @override
  get keystore => throw UnimplementedError();
  @override
  get list => throw UnimplementedError();
  @override
  get mnemonic => throw UnimplementedError();
  @override
  get next => throw UnimplementedError();
  @override
  get observe => throw UnimplementedError();
  @override
  get observeBrief => throw UnimplementedError();
  @override
  get observeProxyInvalid => throw UnimplementedError();
  @override
  get path => throw UnimplementedError();
  @override
  get qrScan => throw UnimplementedError();
  @override
  get rawSeed => throw UnimplementedError();
  @override
  get uosCanceled => throw UnimplementedError();
  @override
  get uosPush => throw UnimplementedError();
  @override
  get uosScan => throw UnimplementedError();
  @override
  get uosSigner => throw UnimplementedError();
  @override
  get uosTitle => throw UnimplementedError();
}
