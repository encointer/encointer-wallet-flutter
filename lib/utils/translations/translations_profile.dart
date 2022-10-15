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
  String get openAppSettings;
  String get enableAutoStart;
}

class TranslationsEnProfile implements TranslationsProfile {
  @override
  get about => 'About';
  @override
  get aboutBrief => 'Mobile Wallet for Encointer';
  @override
  get aboutVersion => 'Version';
  get account => 'Manage Account';
  @override
  get accounts => 'Accounts';
  @override
  get accountDelete => 'Are you sure you want to delete the account?';
  @override
  get accountsDelete => 'Are you sure you want to delete all accounts?';
  @override
  get accountsDeleteAll => 'Remove all Accounts';
  @override
  get accountShare => 'Share Account';
  @override
  get addressBook => 'Address Book';
  @override
  get cantEndorseBootstrapper => 'Bootstrappers are already marked as trusted';
  @override
  get canEndorseInRegisteringPhaseOnly => 'Can endorse in registering phase only';
  @override
  get contactAddress => 'Address';
  @override
  get contactAddressError => 'Invalid address';
  @override
  get contactDelete => 'Delete';
  @override
  get contactDeleteWarn => 'Are you sure you want to delete this address?';
  @override
  get contactEndorse => 'Endorse as trusted contact';
  @override
  get contactAlreadyExists => 'Address exists already';
  @override
  get contactMemo => 'Memo';
  @override
  get contactName => 'Name';
  @override
  get contactNameError => 'Name can not be empty';
  @override
  get contactNameAlreadyExists => 'Name exists already';
  @override
  get contactSave => 'Save';
  @override
  get confirmPin => 'Input your PIN to confirm';
  @override
  get developer => 'Developer mode';
  @override
  get enableBazaar => 'Enable Bazaar';
  @override
  get export => 'Export Account';
  @override
  get exportMnemonicOk => 'Mnemonic was copied to clipboard.';
  @override
  get exportWarn =>
      'Write these words down on paper. Keep the backup paper safe. These words allows anyone to recover this account and access its funds.';
  @override
  get noMnemonicFound => 'No Mnemonic found';
  @override
  get importedWithRawSeedHenceNoMnemonic =>
      'Account was imported with a raw seed and therefore does not have a mnemonic';
  @override
  get changeYourPin => 'Change PIN';
  @override
  get wrongPin => 'Wrong PIN';
  @override
  get wrongPinHint => 'Failed to unlock account, please check PIN.';
  @override
  get yourNewPin => 'New PIN';
  @override
  get pleaseConfirmYourNewPin => 'Confirm New PIN';
  @override
  get hintEnterCurrentPin => 'To change your PIN please enter the current one.';
  @override
  get hintThenEnterANewPin => 'Then you can choose a new one and you’re all set.';
  @override
  get personalKey => 'Personal key';
  @override
  get detailsEnter => 'Enter your details.';
  @override
  get personalKeyEnter => 'Please enter your personal key (12 words) to import the new account.';
  @override
  get reputationHistory => 'Reputation history';
  @override
  get reputationOverall => 'Overall reputation';
  @override
  get passOld => 'Current PIN';
  @override
  get passSuccess => 'Success';
  @override
  get passSuccessTxt => 'PIN changed successfully';
  @override
  get qrScanHint => 'Enter the amount you wish to receive and let the sender scan the QR code.';
  @override
  get qrScanHintAccount => 'Ask the recipient to scan the QR-code in the encointer app.';
  @override
  get receiverAccount => 'Receiving account:';
  @override
  get sendLink => 'Send link';
  @override
  get setting => 'Settings';
  @override
  get settingLang => 'Language';
  @override
  get settingLangAuto => 'Auto Detect';
  @override
  get settingNode => 'Remote Node';
  @override
  get settingNodeList => 'Available Nodes';
  @override
  get settingPrefix => 'Address Prefix';
  @override
  get settingPrefixList => 'Available Prefixes';
  @override
  get share => 'Share';
  @override
  get title => 'Profile';
  @override
  get unlock => 'You need to enter your PIN to add a new account';
  @override
  get addAccount => 'Add account';
  @override
  get addCommunity => 'Add community';
  @override
  get accountCreate => 'Create account';
  @override
  get doYouAlreadyHaveAnAccount => 'Do you already have an account?';
  @override
  get accountNameChooseHint => 'You can change it later in your profile settings.';
  @override
  get accountNameChoose => 'Choose an account name.';
  @override
  get accountName => 'Account name';
  @override
  get import => 'Import';
  @override
  get pinHint => 'You will need this PIN for transactions and adding a new account.';
  @override
  get pinInfo =>
      'PIN should consist of at least 4 digits. If the PIN is lost, there is no option to restore the account unless you made a backup via the profile page.';
  @override
  get pinSecure => 'Secure your account with a PIN.';
  @override
  get recoveryProxy => 'recovery proxy';
  @override
  get ceremonies => 'Ceremonies';
  @override
  get reputation => 'Reputation';
  @override
  get shareLinkHint => 'Or you can share a link:';
  @override
  get tokenSend => 'Send SYMBOL';
  @override
  get addContact => 'Add contact';
  @override
  get deleteAccount => 'delete';
  @override
  get exportAccount => 'export';
  @override
  get errorUserNameIsRequired => 'User name cannot be blank';
  @override
  get observedPendingExtrinsic => 'Pending transaction observed. Please wait for confirmation!';
  @override
  String get appHints => 'App-Hints';
  @override
  String get enableAutoStart => 'Enable autostart';
  @override
  String get meetUpListTileTitle => 'If your device is a Xiaomi or Honor phone, give permission for app-notifications.';
  @override
  String get meetUpNotification => 'Meetup notifications';
  @override
  String get openAppSettings => 'Open App Settings';
}

class TranslationsDeProfile implements TranslationsProfile {
  @override
  get about => 'Über';
  @override
  get aboutBrief => 'Mobiles Wallet für Encointer';
  @override
  get aboutVersion => 'Version';
  @override
  get accounts => 'Konten';
  @override
  get accountDelete => 'Bist du sicher, dass du das Konto löschen möchtest?';
  @override
  get accountsDelete => 'Bist du sicher, dass du alle Konten löschen möchtest?';
  @override
  get accountsDeleteAll => 'Lösche alle Konten';
  @override
  get accountShare => 'Konto teilen';
  @override
  get addressBook => 'Adressbuch';
  @override
  get cantEndorseBootstrapper => 'Bootstrapper sind bereits als zuverlässig markiert';
  @override
  get canEndorseInRegisteringPhaseOnly => 'Du kannst nur in der Registrierungsphase jemanden als zuverlässig markieren';
  @override
  get contactAddress => 'Addresse';
  @override
  get contactAddressError => 'Ungültige Adresse';
  @override
  get contactDelete => 'Löschen';
  @override
  get contactDeleteWarn => 'Bist du sicher, dass du diese Adresse löschen möchtest?';
  @override
  get contactEndorse => 'Als vertrauenswürdig bestätigen';
  @override
  get contactAlreadyExists => 'Adresse existiert bereits';
  @override
  get contactMemo => 'Memo';
  @override
  get contactName => 'Name';
  @override
  get contactNameError => 'Name muss ausgefüllt werden';
  @override
  get contactNameAlreadyExists => 'Name existiert bereits';
  @override
  get contactSave => 'Speichere';
  @override
  get confirmPin => 'Bitte PIN bestätigen';
  @override
  get developer => 'Entwickler-Modus';
  @override
  get enableBazaar => 'Bazaar aktivieren';
  @override
  get export => 'Konto exportieren';
  @override
  get exportMnemonicOk => 'Mnemonik wurde in die Zwischenablage kopiert.';
  @override
  get exportWarn =>
      'Schreibe diese Wörter auf ein Papier. Behalte das Papier an einem sicheren Ort. Diese Wörter geben jedem Zugriff auf das Konto und das Vermögen';
  @override
  get noMnemonicFound => 'Keine Mnemonik gefunden';
  @override
  get importedWithRawSeedHenceNoMnemonic => 'Konto wurde mit einem Raw Seed importiert und hat deshalb keine Mnemonik';
  @override
  get changeYourPin => 'PIN ändern';
  @override
  get wrongPin => 'Falscher PIN';
  @override
  get wrongPinHint => 'Konto konnte nicht entsperrt werden. Bitte überprüfe die eingegebene PIN.';
  @override
  get yourNewPin => 'Neue PIN';
  @override
  get pleaseConfirmYourNewPin => 'Bestätige neue PIN';
  @override
  get hintEnterCurrentPin => 'Gib deinen jetzigen PIN ein um den PIN zu ändern.';
  @override
  get hintThenEnterANewPin => 'Dann kannst du deinen neuen Pin eingeben.';
  @override
  get detailsEnter => 'Gib deine Details ein.';
  @override
  get personalKeyEnter => 'Gib deinen persönlichen Key ein (12 Wörter), um dein Konto zu importieren.';
  @override
  get reputationHistory => 'Reputation History';
  @override
  get reputationOverall => 'Allgemeine Reputation';
  @override
  get passOld => 'Aktuelle PIN';
  @override
  get passSuccess => 'Erfolgreich';
  @override
  get passSuccessTxt => 'PIN wurde erfolgreich geändert';
  @override
  get receiverAccount => 'Empfangendes Konto:';
  @override
  get personalKey => 'Persönlicher Schlüssel';
  @override
  get qrScanHint => 'Gib den Betrag, den du erhalten möchtest ein und lasse den Sender den QR Code scannen.';
  @override
  get qrScanHintAccount => 'Bitte den Empfänger den QR-Code in der Encointer App zu scannen.';
  @override
  get sendLink => 'Link senden';
  @override
  get setting => 'Einstellungen';
  @override
  get settingLang => 'Sprache';
  @override
  get settingLangAuto => 'Automatisch';
  @override
  get settingNode => 'Entfernter Knoten';
  @override
  get settingNodeList => 'Verfügbare Knoten';
  @override
  get settingPrefix => 'Adressenpräfix';
  @override
  get settingPrefixList => 'Verfügbare Präfix';
  @override
  get share => 'Teilen';
  @override
  get shareLinkHint => 'Oder über Link teilen:';
  @override
  get title => 'Profil';
  @override
  get unlock => 'Du musst deinen PIN eingeben um einen neuen Account hinzuzufügen';
  @override
  get addAccount => 'Konto hinzufügen';
  @override
  get addCommunity => 'Gem. hinzufügen';
  @override
  get accountCreate => 'Konto kreieren';
  @override
  get doYouAlreadyHaveAnAccount => 'Hast du bereits ein Konto?';
  @override
  get accountNameChooseHint => 'Du kannst den Namen später ändern in den Profileinstellungen.';
  @override
  get accountNameChoose => 'Wähle einen Kontonamen.';
  @override
  get accountName => 'Kontoname';
  @override
  get import => 'Importiere';
  @override
  get pinHint => 'Du wirst diese PIN benötigen um Transaktionen zu tätigen oder neue Konten hinzufügen.';
  @override
  get pinInfo =>
      'PIN muss mindestens 4 Ziffern enthalten. Bei PIN-Verlust ist der Account nicht wiederherstellbar, ausser man hat ein Backup auf der Profilseite gemacht.';
  @override
  get pinSecure => 'Sichere dein Konto mit einem PIN.';
  @override
  get recoveryProxy => 'Wiederherstellungsproxy';
  @override
  get ceremonies => 'Zeremonien';
  @override
  get reputation => 'Reputation';
  @override
  get tokenSend => 'SYMBOL senden';
  @override
  get addContact => 'Kontakt hinzufügen';
  @override
  get deleteAccount => 'löschen';
  @override
  get exportAccount => 'exportieren';
  @override
  get errorUserNameIsRequired => 'Benutzername darf nicht leer sein';
  @override
  get observedPendingExtrinsic => 'Es wurde eine unbestätigte Transaktion beobachtet. Bitte warte auf Bestätigung!';

  @override
  String get appHints => 'App-Tipps';
  @override
  String get meetUpListTileTitle =>
      'Wenn Dein Gerät ein Xiaomi oder Honor Smartphone is, muss die Erlaubnis für App-Mitteilungen über die'
      ' App-Einstellungen gegeben werden';
  @override
  String get meetUpNotification => 'Meetup-Benachrichtigungen';
  @override
  String get openAppSettings => 'App-Einstellungen öffnen';
  @override
  String get enableAutoStart => 'Autostart der App erlauben';
}

class TranslationsZhProfile implements TranslationsProfile {
  @override
  get about => '关于';
  @override
  get aboutBrief => 'Encointer 手机钱包';
  @override
  get aboutVersion => '版本';
  @override
  get accounts => '帐户';
  @override
  get accountDelete => '您确定要删除该帐户吗？';
  @override
  get accountShare => '共享账户';
  @override
  get addressBook => '地址簿';
  @override
  get cantEndorseBootstrapper => throw UnimplementedError();
  @override
  get canEndorseInRegisteringPhaseOnly => throw UnimplementedError();
  @override
  get contactAddress => '地址';
  @override
  get contactAddressError => '无效地址';
  @override
  get contactDelete => '删除';
  @override
  get contactDeleteWarn => '确认删除该地址吗？';
  @override
  get contactEndorse => throw UnimplementedError();
  @override
  get contactAlreadyExists => '地址已存在';
  @override
  get contactMemo => '备注';
  @override
  get contactName => '名称';
  @override
  get contactNameError => '名称不能为空';
  @override
  get contactNameAlreadyExists => '名称已存在';
  @override
  get contactSave => '保存';
  @override
  get confirmPin => '输入密码确认操作';
  @override
  get developer => '开发者模式';
  @override
  get export => '导出账户';
  @override
  get exportMnemonicOk => 'Mnemonic 已经复制到剪切板';
  @override
  get exportWarn => '请把以下文字抄写到纸条上并妥善保存，以下文字允许任何人恢复当前账户并获取其中的数字资产。';
  @override
  get changeYourPin => '修改密码';
  @override
  get wrongPin => '密码错误';
  @override
  get wrongPinHint => '解锁账户失败，请检查密码';
  @override
  get yourNewPin => '新密码';
  @override
  get pleaseConfirmYourNewPin => '确认新密码';
  @override
  get passOld => '当前密码';
  @override
  get passSuccess => '操作成功';
  @override
  get passSuccessTxt => '密码已修改';
  @override
  get qrScanHint => '请输入您希望收到的金额并让发件人扫描二维码。';
  @override
  get setting => '设置';
  @override
  get settingLang => '语言';
  @override
  get settingLangAuto => '自动检测';
  @override
  get settingNode => '远程节点';
  @override
  get settingNodeList => '可选节点';
  @override
  get settingPrefix => '地址前缀';
  @override
  get settingPrefixList => '可选格式';
  @override
  get share => '分享';
  @override
  get title => '设置';
  @override
  get unlock => '您需要输入您的 PIN 才能添加新帐户';
  @override
  get accountCreate => '创建帐户';
  @override
  get doYouAlreadyHaveAnAccount => '已经有账户了？';
  @override
  get accountNameChooseHint => '您可以稍后在您的个人资料设置中更改它';
  @override
  get accountNameChoose => '选择一个帐户名。';
  @override
  get accountName => '账户名';
  @override
  get import => '导入';
  @override
  get pinHint => '您将需要此 PIN 进行交易和添加新帐户。';
  @override
  get pinInfo => 'PIN 应至少包含 4 位数字。 如果 PIN 码丢失，则无法恢复帐户，除非您通过个人资料页面进行了备份。';
  @override
  get pinSecure => '使用 PIN 保护您的帐户。';
  @override
  get addAccount => '添加帐户';
  @override
  get addCommunity => throw UnimplementedError();
  @override
  get recoveryProxy => 'recovery proxy';
  @override
  get ceremonies => throw UnimplementedError();
  @override
  get reputation => throw UnimplementedError();
  @override
  get sendLink => throw UnimplementedError();
  @override
  get tokenSend => throw UnimplementedError();
  @override
  get qrScanHintAccount => throw UnimplementedError();
  @override
  get receiverAccount => throw UnimplementedError();
  @override
  get shareLinkHint => throw UnimplementedError();
  @override
  get hintEnterCurrentPin => throw UnimplementedError();
  @override
  get hintThenEnterANewPin => throw UnimplementedError();
  @override
  get reputationHistory => throw UnimplementedError();
  @override
  get reputationOverall => throw UnimplementedError();
  @override
  get accountsDelete => throw UnimplementedError();
  @override
  get accountsDeleteAll => throw UnimplementedError();
  @override
  get personalKeyEnter => throw UnimplementedError();
  @override
  get detailsEnter => throw UnimplementedError();
  @override
  get personalKey => throw UnimplementedError();
  @override
  get enableBazaar => throw UnimplementedError();
  @override
  get noMnemonicFound => throw UnimplementedError();
  @override
  get importedWithRawSeedHenceNoMnemonic => throw UnimplementedError();
  @override
  get addContact => throw UnimplementedError();
  @override
  get deleteAccount => throw UnimplementedError();
  @override
  get exportAccount => throw UnimplementedError();
  @override
  get errorUserNameIsRequired => throw UnimplementedError();
  @override
  get observedPendingExtrinsic => throw UnimplementedError();
  @override
  String get appHints => '應用提示';
  @override
  String get enableAutoStart => '點擊自動\n啟動允許/拒絕應用程序自動啟動';
  @override
  String get meetUpListTileTitle => '如果您的設備 Xiaomi 或 Honor：請允許聚會通知';
  @override
  String get meetUpNotification => '聚會通知';
  @override
  String get openAppSettings => '打開應用設置';
}
