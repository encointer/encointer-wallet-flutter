/// contains translations for Profile
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsProfile {
  String get about;
  String get aboutBrief;
  String get aboutVersion;
  String get account;
  String get accountDelete;
  String get accountsDelete;
  String get accountsDeleteAll;
  String get accounts;
  String get accountShare;
  String get add;
  String get addressBook;
  String get contactAddress;
  String get contactAddressError;
  String get contactDelete;
  String get contactDeleteWarn;
  String get contactEdit;
  String get contactAlreadyExists;
  String get contactMemo;
  String get contactName;
  String get contactNameError;
  String get contactNameExist;
  String get contactNameSave;
  String get contactSave;
  String get delete;
  String get deleteConfirm;
  String get developer;
  String get enableBazaar;
  String get export;
  String get exportKeystoreOk;
  String get exportMnemonicOk;
  String get exportRawSeedOk;
  String get exportWarn;
  String get noMnemonic;
  String get noMnemonicTxt;
  String get nameChange;
  String get passChange;
  String get passError;
  String get passErrorTxt;
  String get passNew;
  String get passNew2;
  String get passHint1;
  String get passHint2;
  String get passHint;
  String get passInfo;
  String get passSecure;
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
  String get accountAdd;
  String get accountCreate;
  String get accountHave;
  String get accountNameChooseHint;
  String get accountNameChoose;
  String get accountName;
  String get import;
  String get pinHint;
  String get pinInfo;
  String get pinSecure;
  String get recoveryProxy;
  String get ceremonies;
  String get tokenSend;
  String get reputation;
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
  get add => 'Add';
  get addressBook => 'Address Book';
  get contactAddress => 'Address';
  get contactAddressError => 'Invalid address';
  get contactDelete => 'Delete';
  get contactDeleteWarn => 'Are you sure you want to delete this address?';
  get contactEdit => 'Edit';
  get contactAlreadyExists => 'Address exists already';
  get contactMemo => 'Memo';
  get contactName => 'Name';
  get contactNameError => 'Name can not be empty';
  get contactNameExist => 'Name exists already';
  get contactNameSave => 'Save name';
  get contactSave => 'Save';
  get delete => 'Delete Account';
  get deleteConfirm => 'Input your PIN to confirm';
  get developer => 'Developer mode';
  get enableBazaar => 'Enable Bazaar';
  get export => 'Export Account';
  get exportKeystoreOk => 'Keystore was copied to clipboard.';
  get exportMnemonicOk => 'Mnemonic was copied to clipboard.';
  get exportRawSeedOk => 'Raw Seed was copied to clipboard.';
  get exportWarn =>
      'Write these words down on paper. Keep the backup paper safe. These words allows anyone to recover this account and access its funds.';
  get noMnemonic => 'No Mnemonic found';
  get noMnemonicTxt => 'Account was imported with a raw seed and therefore does not have a mnemonic';
  get nameChange => 'Change Name';
  get passChange => 'Change PIN';
  get passError => 'Wrong PIN';
  get passErrorTxt => 'Failed to unlock account, please check PIN.';
  get passNew => 'New PIN';
  get passNew2 => 'Confirm New PIN';
  get passHint1 => 'To change your PIN please enter the current one.';
  get passHint2 => 'Then you can choose a\n new one and you’re all set.';
  get passHint => 'You will need this PIN for transactions and adding a new account.';
  get passInfo =>
      'PIN should consist of at least 4 digits. If the PIN is lost, there is no option to restore the account unless you made a backup via the profile page.';
  get passSecure => 'Secure your account with a PIN.';
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
  get accountAdd => 'Add account';
  get accountCreate => 'Create account';
  get accountHave => 'Already have an account?';
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
  get tokenSend => 'Send Tokens';
}

class TranslationsDeProfile implements TranslationsProfile {
  get about => 'Über';
  get aboutBrief => 'Mobiles Wallet für Encointer';
  get aboutVersion => 'Version';
  get account => 'Konto';
  get accounts => 'Konten';
  get accountDelete => 'Bist du sicher, dass du das Konto löschen möchtest?';
  get accountsDelete => 'Bist du sicher, dass du alle Konten löschen möchtest?';
  get accountsDeleteAll => 'Lösche alle Konten';
  get accountShare => 'Konto teilen';
  get add => 'Hinzufügen';
  get addressBook => 'Adressbuch';
  get contactAddress => 'Addresse';
  get contactAddressError => 'Ungültige Adresse';
  get contactDelete => 'Lösche';
  get contactDeleteWarn => 'Bist du sicher, dass du diese Adresse löschen möchtest?';
  get contactEdit => 'Bearbeiten';
  get contactAlreadyExists => 'Adresse existiert bereits';
  get contactMemo => 'Memo';
  get contactName => 'Name';
  get contactNameError => 'Name muss ausgefüllt werden';
  get contactNameExist => 'Name existiert bereits';
  get contactNameSave => 'Speichere Name';
  get contactSave => 'Speichere';
  get delete => 'Konto löschen';
  get deleteConfirm => 'Gebe die PIN ein um zu bestätigen';
  get developer => 'Entwickler-Modus';
  get enableBazaar => 'Bazaar aktivieren';
  get export => 'Konto exportieren';
  get exportKeystoreOk => 'Keystore wurde in die Zwischenablage kopiert.';
  get exportMnemonicOk => 'Mnemonic wurde in die Zwischenablage kopiert.';
  get exportRawSeedOk => 'Raw Seed wurde in die Zwischenablage kopiert.';
  get exportWarn =>
      'Schreibe diese Wörter auf ein Papier. Behalte das Papier an einem sicheren Ort. Diese Wörter geben jedem Zugriff auf das Konto und das Vermögen';
  get noMnemonic => 'Keine Mnemonic gefunden';
  get noMnemonicTxt => 'Konto wurde mit einem Raw Seed importiert und hat deshalb keine Mnemonic';
  get nameChange => 'Name ändern';
  get passChange => 'PIN ändern';
  get passError => 'Falsche PIN';
  get passErrorTxt => 'Konto konnte nicht entsperrt werden. Bitte überprüfe die eingegebene PIN.';
  get passNew => 'Neue PIN';
  get passNew2 => 'Bestätige neue PIN';
  get passHint1 => 'Gib deinen jetzigen PIN ein\n um den PIN zu ändern.';
  get passHint2 => 'Dann kannst du deinen\n neuen Pin eingeben.';
  get passHint => 'Du wirst diese PIN benötigen um Transaktionen zu tätigen oder neue Konten hinzufügen.';
  get passInfo =>
      'PIN muss mindestens 4 Ziffern enthalten. Bei PIN-Verlust ist der Account nicht wiederherstellbar, ausser man hat ein Backup auf der Profilseite gemacht.';
  get passSecure => 'Sichere dein Konto mit einem PIN.';
  get reputationHistory => 'Reputation History';
  get reputationOverall => 'Allgemeine Reputation';
  get passOld => 'Aktuelle PIN';
  get passSuccess => 'Erfolgreich';
  get passSuccessTxt => 'PIN wurde erfolgreich geändert';
  get receiverAccount => 'Empfangendes Konto:';
  get qrScanHint => 'Gib den Betrag, den du erhalten möchtest ein und lasse den Sender den QR Code scannen.';
  get qrScanHintAccount => 'Bitte den Empfänger den QR-Code in der Encointer App zu scannen.';
  get sendLink => 'Link senden';
  get setting => 'Einstellungen';
  get settingLang => 'Sprache';
  get settingLangAuto => 'Automatisch';
  get settingNode => 'Remote Node';
  get settingNodeList => 'Verfügbare Nodes';
  get settingPrefix => 'Adressenprefix';
  get settingPrefixList => 'Verfügbare Prefix';
  get share => 'Teilen';
  get shareLinkHint => 'Oder über Link teilen:';
  get title => 'Profil';
  get unlock => 'Du musst deinen PIN eingeben um einen neuen Account hinzuzufügen';
  get accountAdd => 'Konto hinzufügen';
  get accountCreate => 'Konto kreieren';
  get accountHave => 'Hast du bereits ein Konto?';
  get accountNameChooseHint => 'You can change it later in your profile settings.';
  get accountNameChoose => 'Wähle einen Kontonamen.';
  get accountName => 'Kontoname';
  get import => 'Importiere';
  get pinHint => 'Du wirst diese PIN benötigen um Transaktionen zu tätigen oder neue Konten hinzufügen.';
  get pinInfo =>
      'PIN muss mindestens 4 Ziffern enthalten. Bei PIN-Verlust ist der Account nicht wiederherstellbar, ausser man hat ein Backup auf der Profilseite gemacht.';
  get pinSecure => 'Sichere dein Konto mit einem PIN.';
  get recoveryProxy => 'recovery proxy';
  get ceremonies => 'Zeremonien';
  get reputation => 'Reputation';
  get tokenSend => 'Sende Tokens';
}

class TranslationsZhProfile implements TranslationsProfile {
  get about => '关于';
  get aboutBrief => 'Encointer 手机钱包';
  get aboutVersion => '版本';
  get account => '账户管理';
  get accounts => '帐户';
  get accountDelete => '您确定要删除该帐户吗？';
  get accountShare => '共享账户';
  get add => '添加';
  get addressBook => '地址簿';
  get contactAddress => '地址';
  get contactAddressError => '无效地址';
  get contactDelete => '删除';
  get contactDeleteWarn => '确认删除该地址吗？';
  get contactEdit => '编辑';
  get contactAlreadyExists => '地址已存在';
  get contactMemo => '备注';
  get contactName => '名称';
  get contactNameError => '名称不能为空';
  get contactNameExist => '名称已存在';
  get contactNameSave => '保存姓名';
  get contactSave => '保存';
  get delete => '删除账户';
  get deleteConfirm => '输入密码确认操作';
  get developer => '开发者模式';
  get export => '导出账户';
  get exportKeystoreOk => 'Keystore 已经复制到剪切板';
  get exportMnemonicOk => 'Mnemonic 已经复制到剪切板';
  get exportRawSeedOk => 'Raw Seed 已经复制到剪切板';
  get exportWarn => '请把以下文字抄写到纸条上并妥善保存，以下文字允许任何人恢复当前账户并获取其中的数字资产。';
  get nameChange => '修改名称';
  get passChange => '修改密码';
  get passError => '密码错误';
  get passErrorTxt => '解锁账户失败，请检查密码';
  get passNew => '新密码';
  get passNew2 => '确认新密码';
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
  get accountHave => '已经有账户了？';
  get accountNameChooseHint => '您可以稍后在您的个人资料设置中更改它';
  get accountNameChoose => '选择一个帐户名。';
  get accountName => '账户名';
  get import => '导入';
  get pinHint => '您将需要此 PIN 进行交易和添加新帐户。';
  get pinInfo => 'PIN 应至少包含 4 位数字。 如果 PIN 码丢失，则无法恢复帐户，除非您通过个人资料页面进行了备份。';
  get pinSecure => '使用 PIN 保护您的帐户。';
  get accountAdd => '添加帐户';
  get recoveryProxy => 'recovery proxy';
  get ceremonies => throw UnimplementedError();
  get reputation => throw UnimplementedError();
  get sendLink => throw UnimplementedError();
  get tokenSend => throw UnimplementedError();
  get qrScanHintAccount => throw UnimplementedError();
  get receiverAccount => throw UnimplementedError();
  get shareLinkHint => throw UnimplementedError();
  get passHint => throw UnimplementedError();
  get passHint1 => throw UnimplementedError();
  get passHint2 => throw UnimplementedError();
  get passInfo => throw UnimplementedError();
  get passSecure => throw UnimplementedError();
  get reputationHistory => throw UnimplementedError();
  get reputationOverall => throw UnimplementedError();
  get accountsDelete => throw UnimplementedError();
  get accountsDeleteAll => throw UnimplementedError();
  get enableBazaar => throw UnimplementedError();
  get noMnemonic => throw UnimplementedError();
  get noMnemonicTxt => throw UnimplementedError();
}
