/// contains translations for Profile
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsProfile {
  String get about;
  String get aboutBrief;
  String get aboutVersion;
  String get accountDelete;
  String get accountsDelete;
  String get accountsDeleteAll;
  String get accounts;
  String get accountShare;
  String get addressBook;
  String get cantEndorseBootstrapper;
  String get canEndorseInRegisteringPhaseOnly;
  String get contactAddress;
  String get contactAddressError;
  String get contactDelete;
  String get contactDeleteWarn;
  String get contactEndorse;
  String get contactAlreadyExists;
  String get contactMemo;
  String get contactName;
  String get contactNameError;
  String get contactNameAlreadyExists;
  String get contactSave;
  String get detailsEnter;
  String get confirmPin;
  String get developer;
  String get enableBazaar;
  String get export;
  String get exportMnemonicOk;
  String get exportWarn;
  String get noMnemonicFound;
  String get importedWithRawSeedHenceNoMnemonic;
  String get changeYourPin;
  String get wrongPin;
  String get wrongPinHint;
  String get yourNewPin;
  String get pleaseConfirmYourNewPin;
  String get hintEnterCurrentPin;
  String get hintThenEnterANewPin;
  String get reputationHistory;
  String get reputationOverall;
  String get passOld;
  String get passSuccess;
  String get passSuccessTxt;
  String get qrScanHint;
  String get qrScanHintAccount;
  String get receiverAccount;
  String get sendLink;
  String get setting;
  String get settingLang;
  String get settingLangAuto;
  String get settingNode;
  String get settingNodeList;
  String get settingPrefix;
  String get settingPrefixList;
  String get share;
  String get shareLinkHint;
  String get title;
  String get unlock;
  String get addAccount;
  String get addCommunity;
  String get accountCreate;
  String get doYouAlreadyHaveAnAccount;
  String get accountNameChooseHint;
  String get accountNameChoose;
  String get accountName;
  String get import;
  String get personalKeyEnter;
  String get pinHint;
  String get pinInfo;
  String get pinSecure;
  String get personalKey;
  String get recoveryProxy;
  String get ceremonies;
  String get tokenSend;
  String get reputation;
  String get addContact;
  String get deleteAccount;
  String get exportAccount;
  String get errorUserNameIsRequired;
  String get observedPendingExtrinsic;
  String get appHints;
  String get meetUpNotification;
  String get meetUpListTileTitle;
  String get click;
  String get openAppSettings;
  String get enableAutoStart;
}

class TranslationsEnProfile implements TranslationsProfile {
  get about => 'About';
  get aboutBrief => 'Mobile Wallet for Encointer';
  get aboutVersion => 'Version';
  get account => 'Manage Account';
  get accounts => 'Accounts';
  get accountDelete => 'Are you sure you want to delete the account?';
  get accountsDelete => 'Are you sure you want to delete all accounts?';
  get accountsDeleteAll => 'Remove all Accounts';
  get accountShare => 'Share Account';
  get addressBook => 'Address Book';
  get cantEndorseBootstrapper => 'Bootstrappers are already marked as trusted';
  get canEndorseInRegisteringPhaseOnly => 'Can endorse in registering phase only';
  get contactAddress => 'Address';
  get contactAddressError => 'Invalid address';
  get contactDelete => 'Delete';
  get contactDeleteWarn => 'Are you sure you want to delete this address?';
  get contactEndorse => 'Endorse as trusted contact';
  get contactAlreadyExists => 'Address exists already';
  get contactMemo => 'Memo';
  get contactName => 'Name';
  get contactNameError => 'Name can not be empty';
  get contactNameAlreadyExists => 'Name exists already';
  get contactSave => 'Save';
  get confirmPin => 'Input your PIN to confirm';
  get developer => 'Developer mode';
  get enableBazaar => 'Enable Bazaar';
  get export => 'Export Account';
  get exportMnemonicOk => 'Mnemonic was copied to clipboard.';
  get exportWarn =>
      'Write these words down on paper. Keep the backup paper safe. These words allows anyone to recover this account and access its funds.';
  get noMnemonicFound => 'No Mnemonic found';
  get importedWithRawSeedHenceNoMnemonic =>
      'Account was imported with a raw seed and therefore does not have a mnemonic';
  get changeYourPin => 'Change PIN';
  get wrongPin => 'Wrong PIN';
  get wrongPinHint => 'Failed to unlock account, please check PIN.';
  get yourNewPin => 'New PIN';
  get pleaseConfirmYourNewPin => 'Confirm New PIN';
  get hintEnterCurrentPin => 'To change your PIN please enter the current one.';
  get hintThenEnterANewPin => 'Then you can choose a new one and you’re all set.';
  get personalKey => 'Personal key';
  get detailsEnter => 'Enter your details.';
  get personalKeyEnter => 'Please enter your personal key (12 words) to import the new account.';
  get reputationHistory => 'Reputation history';
  get reputationOverall => 'Overall reputation';
  get passOld => 'Current PIN';
  get passSuccess => 'Success';
  get passSuccessTxt => 'PIN changed successfully';
  get qrScanHint => 'Enter the amount you wish to receive and let the sender scan the QR code.';
  get qrScanHintAccount => 'Ask the recipient to scan the QR-code in the encointer app.';
  get receiverAccount => 'Receiving account:';
  get sendLink => 'Send link';
  get setting => 'Settings';
  get settingLang => 'Language';
  get settingLangAuto => 'Auto Detect';
  get settingNode => 'Remote Node';
  get settingNodeList => 'Available Nodes';
  get settingPrefix => 'Address Prefix';
  get settingPrefixList => 'Available Prefixes';
  get share => 'Share';
  get title => 'Profile';
  get unlock => 'You need to enter your PIN to add a new account';
  get addAccount => 'Add account';
  get addCommunity => 'Add community';
  get accountCreate => 'Create account';
  get doYouAlreadyHaveAnAccount => 'Do you already have an account?';
  get accountNameChooseHint => 'You can change it later in your profile settings.';
  get accountNameChoose => 'Choose an account name.';
  get accountName => 'Account name';
  get import => 'Import';
  get pinHint => 'You will need this PIN for transactions and adding a new account.';
  get pinInfo =>
      'PIN should consist of at least 4 digits. If the PIN is lost, there is no option to restore the account unless you made a backup via the profile page.';
  get pinSecure => 'Secure your account with a PIN.';
  get recoveryProxy => 'recovery proxy';
  get ceremonies => 'Ceremonies';
  get reputation => 'Reputation';
  get shareLinkHint => 'Or you can share a link:';
  get tokenSend => 'Send SYMBOL';
  get addContact => 'Add contact';
  get deleteAccount => 'delete';
  get exportAccount => 'export';
  get errorUserNameIsRequired => 'User name cannot be blank';
  get observedPendingExtrinsic => 'Pending transaction observed. Please wait for confirmation!';

  @override
  String get appHints => 'App-Hints';

  @override
  String get click => 'Click';

  @override
  String get enableAutoStart => 'Tap on Autostart\nAllow/Deny an App to autostart';

  @override
  String get meetUpListTileTitle => 'If your device Xiaomi or Honor: Please give permission for meetup notification';

  @override
  String get meetUpNotification => 'Meetup notifications';

  @override
  String get openAppSettings => 'Open App Settings';
}

class TranslationsDeProfile implements TranslationsProfile {
  get about => 'Über';
  get aboutBrief => 'Mobiles Wallet für Encointer';
  get aboutVersion => 'Version';
  get accounts => 'Konten';
  get accountDelete => 'Bist du sicher, dass du das Konto löschen möchtest?';
  get accountsDelete => 'Bist du sicher, dass du alle Konten löschen möchtest?';
  get accountsDeleteAll => 'Lösche alle Konten';
  get accountShare => 'Konto teilen';
  get addressBook => 'Adressbuch';
  get cantEndorseBootstrapper => 'Bootstrapper sind bereits als zuverlässig markiert';
  get canEndorseInRegisteringPhaseOnly => 'Du kannst nur in der Registrierungsphase jemanden als zuverlässig markieren';
  get contactAddress => 'Addresse';
  get contactAddressError => 'Ungültige Adresse';
  get contactDelete => 'Löschen';
  get contactDeleteWarn => 'Bist du sicher, dass du diese Adresse löschen möchtest?';
  get contactEndorse => 'Als vertrauenswürdig bestätigen';
  get contactAlreadyExists => 'Adresse existiert bereits';
  get contactMemo => 'Memo';
  get contactName => 'Name';
  get contactNameError => 'Name muss ausgefüllt werden';
  get contactNameAlreadyExists => 'Name existiert bereits';
  get contactSave => 'Speichere';
  get confirmPin => 'Bitte PIN bestätigen';
  get developer => 'Entwickler-Modus';
  get enableBazaar => 'Bazaar aktivieren';
  get export => 'Konto exportieren';
  get exportMnemonicOk => 'Mnemonik wurde in die Zwischenablage kopiert.';
  get exportWarn =>
      'Schreibe diese Wörter auf ein Papier. Behalte das Papier an einem sicheren Ort. Diese Wörter geben jedem Zugriff auf das Konto und das Vermögen';
  get noMnemonicFound => 'Keine Mnemonik gefunden';
  get importedWithRawSeedHenceNoMnemonic => 'Konto wurde mit einem Raw Seed importiert und hat deshalb keine Mnemonik';
  get changeYourPin => 'PIN ändern';
  get wrongPin => 'Falscher PIN';
  get wrongPinHint => 'Konto konnte nicht entsperrt werden. Bitte überprüfe die eingegebene PIN.';
  get yourNewPin => 'Neue PIN';
  get pleaseConfirmYourNewPin => 'Bestätige neue PIN';
  get hintEnterCurrentPin => 'Gib deinen jetzigen PIN ein um den PIN zu ändern.';
  get hintThenEnterANewPin => 'Dann kannst du deinen neuen Pin eingeben.';
  get detailsEnter => 'Gib deine Details ein.';
  get personalKeyEnter => 'Gib deinen persönlichen Key ein (12 Wörter), um dein Konto zu importieren.';
  get reputationHistory => 'Reputation History';
  get reputationOverall => 'Allgemeine Reputation';
  get passOld => 'Aktuelle PIN';
  get passSuccess => 'Erfolgreich';
  get passSuccessTxt => 'PIN wurde erfolgreich geändert';
  get receiverAccount => 'Empfangendes Konto:';
  get personalKey => 'Persönlicher Schlüssel';
  get qrScanHint => 'Gib den Betrag, den du erhalten möchtest ein und lasse den Sender den QR Code scannen.';
  get qrScanHintAccount => 'Bitte den Empfänger den QR-Code in der Encointer App zu scannen.';
  get sendLink => 'Link senden';
  get setting => 'Einstellungen';
  get settingLang => 'Sprache';
  get settingLangAuto => 'Automatisch';
  get settingNode => 'Entfernter Knoten';
  get settingNodeList => 'Verfügbare Knoten';
  get settingPrefix => 'Adressenpräfix';
  get settingPrefixList => 'Verfügbare Präfix';
  get share => 'Teilen';
  get shareLinkHint => 'Oder über Link teilen:';
  get title => 'Profil';
  get unlock => 'Du musst deinen PIN eingeben um einen neuen Account hinzuzufügen';
  get addAccount => 'Konto hinzufügen';
  get addCommunity => 'Gem. hinzufügen';
  get accountCreate => 'Konto kreieren';
  get doYouAlreadyHaveAnAccount => 'Hast du bereits ein Konto?';
  get accountNameChooseHint => 'Du kannst den Namen später ändern in den Profileinstellungen.';
  get accountNameChoose => 'Wähle einen Kontonamen.';
  get accountName => 'Kontoname';
  get import => 'Importiere';
  get pinHint => 'Du wirst diese PIN benötigen um Transaktionen zu tätigen oder neue Konten hinzufügen.';
  get pinInfo =>
      'PIN muss mindestens 4 Ziffern enthalten. Bei PIN-Verlust ist der Account nicht wiederherstellbar, ausser man hat ein Backup auf der Profilseite gemacht.';
  get pinSecure => 'Sichere dein Konto mit einem PIN.';
  get recoveryProxy => 'Wiederherstellungsproxy';
  get ceremonies => 'Zeremonien';
  get reputation => 'Reputation';
  get tokenSend => 'SYMBOL senden';
  get addContact => 'Kontakt hinzufügen';
  get deleteAccount => 'löschen';
  get exportAccount => 'exportieren';
  get errorUserNameIsRequired => 'Benutzername darf nicht leer sein';
  get observedPendingExtrinsic => 'Es wurde eine unbestätigte Transaktion beobachtet. Bitte warte auf Bestätigung!';

  @override
  String get appHints => 'App-Tipps';

  @override
  String get click => 'Klicken';

  @override
  String get enableAutoStart => 'Tippen Sie auf Autostart\nApp zulassen/verweigern, um automatisch zu starten';

  @override
  String get meetUpListTileTitle =>
      'Wenn Ihr Gerät Xiaomi oder Honor ist: Bitte geben Sie die Erlaubnis für die Meetup-Benachrichtigung';

  @override
  String get meetUpNotification => 'Meetup-Benachrichtigungen';

  @override
  String get openAppSettings => 'App-Einstellungen öffnen';
}

class TranslationsZhProfile implements TranslationsProfile {
  get about => '关于';
  get aboutBrief => 'Encointer 手机钱包';
  get aboutVersion => '版本';
  get accounts => '帐户';
  get accountDelete => '您确定要删除该帐户吗？';
  get accountShare => '共享账户';
  get addressBook => '地址簿';
  get cantEndorseBootstrapper => throw UnimplementedError();
  get canEndorseInRegisteringPhaseOnly => throw UnimplementedError();
  get contactAddress => '地址';
  get contactAddressError => '无效地址';
  get contactDelete => '删除';
  get contactDeleteWarn => '确认删除该地址吗？';
  get contactEndorse => throw UnimplementedError();
  get contactAlreadyExists => '地址已存在';
  get contactMemo => '备注';
  get contactName => '名称';
  get contactNameError => '名称不能为空';
  get contactNameAlreadyExists => '名称已存在';
  get contactSave => '保存';
  get confirmPin => '输入密码确认操作';
  get developer => '开发者模式';
  get export => '导出账户';
  get exportMnemonicOk => 'Mnemonic 已经复制到剪切板';
  get exportWarn => '请把以下文字抄写到纸条上并妥善保存，以下文字允许任何人恢复当前账户并获取其中的数字资产。';
  get changeYourPin => '修改密码';
  get wrongPin => '密码错误';
  get wrongPinHint => '解锁账户失败，请检查密码';
  get yourNewPin => '新密码';
  get pleaseConfirmYourNewPin => '确认新密码';
  get passOld => '当前密码';
  get passSuccess => '操作成功';
  get passSuccessTxt => '密码已修改';
  get qrScanHint => '请输入您希望收到的金额并让发件人扫描二维码。';
  get setting => '设置';
  get settingLang => '语言';
  get settingLangAuto => '自动检测';
  get settingNode => '远程节点';
  get settingNodeList => '可选节点';
  get settingPrefix => '地址前缀';
  get settingPrefixList => '可选格式';
  get share => '分享';
  get title => '设置';
  get unlock => '您需要输入您的 PIN 才能添加新帐户';
  get accountCreate => '创建帐户';
  get doYouAlreadyHaveAnAccount => '已经有账户了？';
  get accountNameChooseHint => '您可以稍后在您的个人资料设置中更改它';
  get accountNameChoose => '选择一个帐户名。';
  get accountName => '账户名';
  get import => '导入';
  get pinHint => '您将需要此 PIN 进行交易和添加新帐户。';
  get pinInfo => 'PIN 应至少包含 4 位数字。 如果 PIN 码丢失，则无法恢复帐户，除非您通过个人资料页面进行了备份。';
  get pinSecure => '使用 PIN 保护您的帐户。';
  get addAccount => '添加帐户';
  get addCommunity => throw UnimplementedError();
  get recoveryProxy => 'recovery proxy';
  get ceremonies => throw UnimplementedError();
  get reputation => throw UnimplementedError();
  get sendLink => throw UnimplementedError();
  get tokenSend => throw UnimplementedError();
  get qrScanHintAccount => throw UnimplementedError();
  get receiverAccount => throw UnimplementedError();
  get shareLinkHint => throw UnimplementedError();
  get hintEnterCurrentPin => throw UnimplementedError();
  get hintThenEnterANewPin => throw UnimplementedError();
  get reputationHistory => throw UnimplementedError();
  get reputationOverall => throw UnimplementedError();
  get accountsDelete => throw UnimplementedError();
  get accountsDeleteAll => throw UnimplementedError();
  get personalKeyEnter => throw UnimplementedError();
  get detailsEnter => throw UnimplementedError();
  get personalKey => throw UnimplementedError();
  get enableBazaar => throw UnimplementedError();
  get noMnemonicFound => throw UnimplementedError();
  get importedWithRawSeedHenceNoMnemonic => throw UnimplementedError();
  get addContact => throw UnimplementedError();
  get deleteAccount => throw UnimplementedError();
  get exportAccount => throw UnimplementedError();
  get errorUserNameIsRequired => throw UnimplementedError();
  get observedPendingExtrinsic => throw UnimplementedError();

  @override
  String get appHints => '應用提示';

  @override
  String get click => '點擊';

  @override
  String get enableAutoStart => '點擊自動\n啟動允許/拒絕應用程序自動啟動';

  @override
  String get meetUpListTileTitle => '如果您的設備 Xiaomi 或 Honor：請允許聚會通知';

  @override
  String get meetUpNotification => '聚會通知';

  @override
  String get openAppSettings => '打開應用設置';
}
