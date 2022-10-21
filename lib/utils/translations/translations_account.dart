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
      'This device does not support key type sr25519, you can select [Advanced Options -> Encrypt Type -> ed25519] to continue. ';
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

class TranslationsZhAccount implements TranslationsAccount {
  @override
  get advanced => '高级选项';
  @override
  get backupError => '此设备不支持密钥类型 sr25519，您可以选择 [高级选项 -> 加密类型 -> ed25519] 继续。';
  @override
  get create => '创建帐户';
  @override
  get createError => '创建帐户时出错';
  @override
  get createHint => '（默认值：我的帐户）';
  @override
  get createPassword => 'PIN';
  @override
  get createPassword2 => '确认 PIN';
  @override
  get createPassword2Error => 'PIN 不一致';
  @override
  get createPasswordError => 'PIN 必须包含至少 4 位数字且不得包含其他符号';
  @override
  get importDuplicate => '账户存在，是否覆盖现有账户？';
  @override
  get importEncrypt => '加密类型';
  @override
  get importInvalid => '无效';
  @override
  get importInvalidRawSeed => throw UnimplementedError();
  @override
  get importInvalidMnemonic => throw UnimplementedError();
  @override
  get importMustNotBeEmpty => throw UnimplementedError();
  @override
  get importPrivateKeyUnsupported => throw UnimplementedError();
  @override
  get keystore => '密钥库 (json)';
  @override
  get list => '账户选择';
  @override
  get mnemonic => '助记符';
  @override
  get next => '韦特';
  @override
  get observe => '观察';
  @override
  get observeBrief => throw UnimplementedError();
  @override
  get observeProxyInvalid => '无效的代理帐户';
  @override
  get path => '秘密推导路径';
  @override
  get qrScan => '扫描二维码';
  @override
  get rawSeed => '原始种子';
  @override
  get uosCanceled => 'Transaction 取消';
  @override
  get uosPush => '扫描发布';
  @override
  get uosScan => '扫描签名并发送';
  @override
  get uosSigner => '签名者';
  @override
  get uosTitle => '离线签名';
}
