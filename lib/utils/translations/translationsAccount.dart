/// contains translations for Account
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsAccount {
  String get advanced;
  String get backupError;
  String get create;
  String get createDefault;
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
  get advanced => 'Advanced Options';
  get backupError =>
      'This device does not support key type sr25519, you can select [Advanced Options -> Encrypt Type -> ed25519] to continue.';
  get create => 'Create Account';
  get createDefault => 'My Account';
  get createError => 'There was an error creating your account';
  get createHint => '(Example: Alice)';
  get createPassword => 'PIN';
  get createPassword2 => 'Confirm PIN';
  get createPassword2Error => 'Inconsistent PINs';
  get createPasswordError => 'PIN must contain at least 4 digits and no other signs';
  get importDuplicate => 'Account exists, do you want to override the existing account?';
  get importEncrypt => 'Encrypt Type';
  get importInvalid => 'Invalid';
  get importInvalidRawSeed => 'Invalid raw seed supplied';
  get importInvalidMnemonic => 'Invalid mnemonic supplied';
  get importMustNotBeEmpty => 'Input must not be empty';
  get importPrivateKeyUnsupported => 'Private key account import is not yet supported.';
  get keystore => 'Keystore (json)';
  get list => 'Account Select';
  get mnemonic => 'Mnemonic';
  get next => 'Next';
  get observe => 'Observation';
  get observeBrief =>
      'Mark this address as observation, then you can select this address in account select page, to watch it\'s assets and actions';
  get observeProxyInvalid => 'Invalid proxy account';
  get path => 'Secret derivation path';
  get qrScan => 'Scan QR code';
  get rawSeed => 'Raw Seed';
  get uosCanceled => 'Transaction canceled';
  get uosPush => 'Scan to publish';
  get uosScan => 'Scan signed and send';
  get uosSigner => 'Signer';
  get uosTitle => 'Offline Signature';
}

class TranslationsDeAccount implements TranslationsAccount {
  get advanced => 'Erweiterte Optionen';
  get backupError =>
      'Dieses Gerät unterstützt den key Typ sr25519 nicht, wähle [Erweiterte Optionen -> Verschlüsselungstyp -> ed225519] für den nächsten Schritt.';
  get create => 'Konto registrieren';
  get createDefault => 'Mein Konto';
  get createError => 'Beim Erstellen deines Kontos ist ein Fehler aufgetreten';
  get createHint => '(Beispiel: Alice)';
  get createPassword => 'PIN';
  get createPassword2 => 'PIN Bestätigen';
  get createPassword2Error => 'Die PINs stimmen nicht überein';
  get createPasswordError => 'Der PIN muss aus mindestens 4 Ziffern bestehen und keinen anderen Zeichen';
  get importDuplicate => 'Dieses Konto existiert bereits, möchtest du es überschreiben?';
  get importEncrypt => 'Verschlüsselungstyp';
  get importInvalid => 'Ungültig';
  get importInvalidRawSeed => 'Ungültigen raw seed eingegeben.';
  get importInvalidMnemonic => 'Ungültige Mnemonik eingegeben.';
  get importMustNotBeEmpty => 'Eingabe darf nicht leer sein.';
  get importPrivateKeyUnsupported => 'Konto importieren mit privatem Schlüssel wird noch nicht unterstützt.';
  get keystore => 'Keystore (json)';
  get list => 'Kontoauswahl';
  get mnemonic => 'Mnemonik';
  get next => 'Nächster Schritt';
  get observe => 'Überwachen';
  get observeBrief =>
      'Markiere diese Adresse als zu überwachen, dann kann diese Adresse in der Kontoauswahlseite ausgewählt werden, um dessen Vermögen und Aktionen zu überwachen.';
  get observeProxyInvalid => 'Ungültiges Proxy-Konto';
  get path => 'Geheimer Derivationspfad';
  get qrScan => 'Scanne QR Code';
  get rawSeed => 'Raw Seed';
  get uosCanceled => 'Transaktion abgebrochen';
  get uosPush => 'Scannen um zu veröffentlichen';
  get uosScan => 'Signierte Transaktion scannen und senden';
  get uosSigner => 'Signierer';
  get uosTitle => 'Offline Signatur';
}

class TranslationsZhAccount implements TranslationsAccount {
  get advanced => '高级选项';
  get backupError => '此设备不支持密钥类型 sr25519，您可以选择 [高级选项 -> 加密类型 -> ed25519] 继续。';
  get create => '创建帐户';
  get createDefault => '我的帐户';
  get createError => '创建帐户时出错';
  get createHint => '（默认值：我的帐户）';
  get createPassword => 'PIN';
  get createPassword2 => '确认 PIN';
  get createPassword2Error => 'PIN 不一致';
  get createPasswordError => 'PIN 必须包含至少 4 位数字且不得包含其他符号';
  get importDuplicate => '账户存在，是否覆盖现有账户？';
  get importEncrypt => '加密类型';
  get importInvalid => '无效';
  get importInvalidRawSeed => throw UnimplementedError();
  get importInvalidMnemonic => throw UnimplementedError();
  get importMustNotBeEmpty => throw UnimplementedError();
  get importPrivateKeyUnsupported => throw UnimplementedError();
  get keystore => '密钥库 (json)';
  get list => '账户选择';
  get mnemonic => '助记符';
  get next => '韦特';
  get observe => '观察';
  get observeBrief => throw UnimplementedError();
  get observeProxyInvalid => '无效的代理帐户';
  get path => '秘密推导路径';
  get qrScan => '扫描二维码';
  get rawSeed => '原始种子';
  get uosCanceled => 'Transaction 取消';
  get uosPush => '扫描发布';
  get uosScan => '扫描签名并发送';
  get uosSigner => '签名者';
  get uosTitle => '离线签名';
}
