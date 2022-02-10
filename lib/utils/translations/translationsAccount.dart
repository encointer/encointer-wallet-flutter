/// contains translations for Account
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsAccount {
  String get advanced;
  String get backup;
  String get backupConfirm;
  String get backupError;
  String get backupReset;
  String get create;
  String get createDefault;
  String get createError;
  String get createHint;
  String get createName;
  String get createNameError;
  String get createPassword;
  String get createPassword2;
  String get createPassword2Error;
  String get createPasswordError;
  String get createWarn1;
  String get createWarn10;
  String get createWarn2;
  String get createWarn3;
  String get createWarn4;
  String get createWarn5;
  String get createWarn6;
  String get createWarn7;
  String get createWarn8;
  String get createWarn9;
  String get importDuplicate;
  String get importEncrypt;
  String get importInvalid;
  String get importType;
  String get keystore;
  String get list;
  String get mnemonic;
  String get next;
  String get observe;
  String get observeBrief;
  String get observeInvalid;
  String get observeProxy;
  String get observeProxyBrief;
  String get observeProxyInvalid;
  String get observeTx;
  String get path;
  String get qrScan;
  String get rawSeed;
  String get uosAccInvalid;
  String get uosAccMismatch;
  String get uosCanceled;
  String get uosPush;
  String get uosQrInvalid;
  String get uosScan;
  String get uosSigner;
  String get uosTitle;
}

class TranslationsEnAccount implements TranslationsAccount {
  get advanced => 'Advanced Options';
  get backup => 'Confirm the mnemonic';
  get backupConfirm => 'Please click on the mnemonic in the correct order to confirm that the backup is correct';
  get backupError => 'This device does not support key type sr25519, you can select [Advanced Options -> Encrypt Type -> ed25519] to continue.';
  get backupReset => 'Reset';
  get create => 'Create Account';
  get createDefault => 'My Account';
  get createError => 'There was an error creating your account';
  get createHint => '(Default: My Account)';
  get createName => 'Name';
  get createNameError => 'Name can not be empty';
  get createPassword => 'PIN';
  get createPassword2 => 'Confirm PIN';
  get createPassword2Error => 'Inconsistent PINs';
  get createPasswordError => 'PIN must contain at least 4 digits and no other signs';
  get createWarn1 => 'Backup prom';
  get createWarn10 => 'Do not take screenshots, which may be collected by third-party malware, resulting in asset loss';
  get createWarn2 => 'Getting a mnemonic equals ownership of a wallet asset';
  get createWarn3 => 'Backup mnemonic';
  get createWarn4 => 'Use paper and pen to correctly copy mnemonics';
  get createWarn5 => 'If your phone is lost, stolen or damaged, the mnemonic will restore your assets';
  get createWarn6 => 'Offline storage';
  get createWarn7 => 'Keep it safe to a safe place on the isolated network';
  get createWarn8 => 'Do not share and store mnemonics in a networked environment, such as emails, photo albums, social applications';
  get createWarn9 => 'Do not take screenshots';
  get importDuplicate => 'Account exists, do you want to override the existing account?';
  get importEncrypt => 'Encrypt Type';
  get importInvalid => 'Invalid';
  get importType => 'Source Type';
  get keystore => 'Keystore (json)';
  get list => 'Account Select';
  get mnemonic => 'Mnemonic';
  get next => 'Weiter';
  get observe => 'Observation';
  get observeBrief => '\nMark this address as observation,\nthen you can select this address\nin account select page, to watch\nit\'s assets and actions\n';
  get observeInvalid => 'Invalid';
  get observeProxy => 'sign with proxy account';
  get observeProxyBrief => '\nA recoverable account can\nsend Tx through a proxy account\n';
  get observeProxyInvalid => 'Invalid proxy account';
  get observeTx => 'For observing only';
  get path => 'Secret derivation path';
  get qrScan => 'Scan QR code';
  get rawSeed => 'Raw Seed';
  get uosAccInvalid => 'Account invalid';
  get uosAccMismatch => 'Account mismatch';
  get uosCanceled => 'Tx canceled';
  get uosPush => 'Scan to publish';
  get uosQrInvalid => 'Invalid QR code';
  get uosScan => 'Scan signed and send';
  get uosSigner => 'Signer';
  get uosTitle => 'Offline Signature';
}

class TranslationsDeAccount implements TranslationsAccount {
  get advanced => 'Erweiterte Optionen';
  get backup => 'Bestätige die Mnemonic';
  get backupConfirm => 'Bitte klicke auf die Mnemonic in der korrekten Reihenfolge um den Backup zu bestätigen';
  get backupError =>      'Dieses Gerät unterstützt den key Typ sr25519 nicht, wähle [Erweiterte Optionen -> Verschlüsselungstyp -> ed225519] für den nächsten Schritt.';
  get backupReset => 'Wiederherstellen';
  get create => 'Konto registrieren';
  get createDefault => 'Mein Konto';
  get createError => 'Es trat ein Fehler auf beim Erstellen deines Kontos';
  get createHint => '(Standard: Mein Konto)';
  get createName => 'Name';
  get createNameError => 'Name muss ausgefüllt werden';
  get createPassword => 'PIN';
  get createPassword2 => 'PIN Bestätigen';
  get createPassword2Error => 'Inkonsistente PINs';
  get createPasswordError => 'PIN muss aus mindestens 4 Ziffern bestehen und keinen anderen Zeichen';
  get createWarn1 => 'Backup prom';
  get createWarn10 =>      'Mach keine Screenshots, welche von einer Drittpartei gesammelt werden können. Dies kann zum Verlust deines Vermögens führen';
  get createWarn2 => 'Der Besitz der Mnemonic ermöglicht den Zugriff auf das Vermögen des Wallets';
  get createWarn3 => 'Backup Mnemonic';
  get createWarn4 => 'Benutze Stift und Papier um die Mnemonics korrekt zu kopieren';
  get createWarn5 =>      'Bei Verlust, Diebstahl oder Beschädigung deines Mobilgerätes wird die Mnemonic benötigt um dein Vermögen wiederherzustellen';
  get createWarn6 => 'Offline Speicher';
  get createWarn7 => 'Behalte es sicher im isolierten Netzwerk';
  get createWarn8 => 'Speichere deine Mnemonics nicht in einer Netzwerkumgebung wie Email, Photo Album etc.';
  get createWarn9 => 'Mach keine Screenshots';
  get importDuplicate => 'Konto existiert bereits, möchtest du es überschreiben?';
  get importEncrypt => 'Verschlüsselungstyp';
  get importInvalid => 'Ungültig';
  get importType => 'Ursprungstyp';
  get keystore => 'Keystore (json)';
  get list => 'Kontoauswahl';
  get mnemonic => 'Mnemonic';
  get next => 'Next';
  get observe => 'Observation';
  get observeBrief =>      '\nMarkiere diese Adresse als Observation,\ndann kann diese Adresse in der Kontoauswahlseite ausgewählt werden,\n um dessen Vermögen und Aktionen zu beobachten.\n';
  get observeInvalid => 'Ungültig';
  get observeProxy => 'Melde dich mit einem Proxy-Konto an';
  get observeProxyBrief => '\nEin wiederherstellbares Konto kann\nTransaktionen durch einen Proxy-Konto senden\n';
  get observeProxyInvalid => 'Ungültiges Proxy-Konto';
  get observeTx => 'Nur für Observation';
  get path => 'Geheimer Derivationspfad';
  get qrScan => 'Scanne QR Code';
  get rawSeed => 'Raw Seed';
  get uosAccInvalid => 'Ungütliges Konto';
  get uosAccMismatch => 'Konto stimmt nicht überein';
  get uosCanceled => 'Tx abgebrochen';
  get uosPush => 'Scanne um zu veröffentlichen';
  get uosQrInvalid => 'Ungültiger QR Code';
  get uosScan => 'Signierte Tx scannen und senden';
  get uosSigner => 'Signierer';
  get uosTitle => 'Offline Signatur';
}

class TranslationsZhAccount implements TranslationsAccount {
  get advanced =>'高级选项';
  get backup =>  '确认助记符';
  get backupConfirm =>  '请按正确顺序点击助记词确认备份无误';
  get backupError =>  '此设备不支持密钥类型 sr25519，您可以选择 [高级选项 -> 加密类型 -> ed25519] 继续。';
  get backupReset =>  '重置';
  get create =>  '创建帐户';
  get createDefault =>  '我的帐户';
  get createError =>  '创建帐户时出错';
  get createHint =>  '（默认值：我的帐户）';
  get createName =>  '名称';
  get createNameError =>  '名称不能为空';
  get createPassword =>  'PIN';
  get createPassword2 =>  '确认 PIN';
  get createPassword2Error =>  'PIN 不一致';
  get createPasswordError =>  'PIN 必须包含至少 4 位数字且不得包含其他符号';
  get createWarn1 =>  '备份舞会';
  get createWarn10 =>  '请勿截图，可能被第三方恶意软件收集，造成资产损失';
  get createWarn2 =>  '获得助记词等于拥有钱包资产';
  get createWarn3 =>  '备份助记符';
  get createWarn4 =>  '用纸和笔正确复制助记符';
  get createWarn5 =>  '如果您的手机丢失、被盗或损坏，助记词将恢复您的资产';
  get createWarn6 =>  '离线存储';
  get createWarn7 =>  '将其安全保存到隔离网络上的安全位置';
  get createWarn8 =>  '不要在网络环境中共享和存储助记词，例如电子邮件、相册、社交应用程序';
  get createWarn9 =>  '不要截图';
  get importDuplicate =>  '账户存在，是否覆盖现有账户？';
  get importEncrypt =>  '加密类型';
  get importInvalid =>  '无效';
  get importType =>  '源类型';
  get keystore =>  '密钥库 (json)';
  get list =>  '账户选择';
  get mnemonic =>  '助记符';
  get next =>  '韦特';
  get observe =>  '观察';
  get observeBrief =>  '\n将此地址标记为观察，\n然后您可以在帐户选择页面中选择此地址\nit\n的资产和操作\n';
  get observeInvalid =>  '无效';
  get observeProxy =>  '使用代理帐户签名';
  get observeProxyBrief =>  '\n可恢复的帐户可以\ns通过代理帐户发送 Tx\n';
  get observeProxyInvalid =>  '无效的代理帐户';
  get observeTx =>  '仅用于观察';
  get path =>  '秘密推导路径';
  get qrScan =>  '扫描二维码';
  get rawSeed =>  '原始种子';
  get uosAccInvalid =>  '帐号无效';
  get uosAccMismatch =>  '账户不匹配';
  get uosCanceled =>  'Tx 取消';
  get uosPush =>  '扫描发布';
  get uosQrInvalid =>  '二维码无效';
  get uosScan =>  '扫描签名并发送';
  get uosSigner =>  '签名者';
  get uosTitle =>  '离线签名';
}
