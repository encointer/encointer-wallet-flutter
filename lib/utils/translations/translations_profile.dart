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
  String get meetUpNotifications;
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
  String get meetUpNotifications => 'Meetup notifications';
  @override
  String get meetUpListTileTitle => 'If your device is a Xiaomi or Honor phone, please enable autostart to '
      'receive meetup notifications.';
  @override
  String get openAppSettings => 'Open App Settings';
  @override
  String get enableAutoStart => 'Enable autostart';
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
  String get meetUpNotifications => 'Meetup-Benachrichtigungen';
  @override
  String get meetUpListTileTitle =>
      'Wenn Dein Gerät ein Xiaomi oder Honor Smartphone is, muss Autostart aktiviert sein um Meetup-Benachrichtigungen'
      'zu erhalten.';
  @override
  String get openAppSettings => 'App-Einstellungen öffnen';
  @override
  String get enableAutoStart => 'Autostart aktivieren';
}

class TranslationsFrProfile implements TranslationsProfile {
  @override
  get about => throw UnimplementedError();
  @override
  get aboutBrief => throw UnimplementedError();
  @override
  get aboutVersion => throw UnimplementedError();
  @override
  get accounts => throw UnimplementedError();
  @override
  get accountDelete => throw UnimplementedError();
  @override
  get accountShare => throw UnimplementedError();
  @override
  get addressBook => throw UnimplementedError();
  @override
  get cantEndorseBootstrapper => throw UnimplementedError();
  @override
  get canEndorseInRegisteringPhaseOnly => throw UnimplementedError();
  @override
  get contactAddress => throw UnimplementedError();
  @override
  get contactAddressError => throw UnimplementedError();
  @override
  get contactDelete => throw UnimplementedError();
  @override
  get contactDeleteWarn => throw UnimplementedError();
  @override
  get contactEndorse => throw UnimplementedError();
  @override
  get contactAlreadyExists => throw UnimplementedError();
  @override
  get contactMemo => throw UnimplementedError();
  @override
  get contactName => throw UnimplementedError();
  @override
  get contactNameError => throw UnimplementedError();
  @override
  get contactNameAlreadyExists => throw UnimplementedError();
  @override
  get contactSave => throw UnimplementedError();
  @override
  get confirmPin => throw UnimplementedError();
  @override
  get developer => throw UnimplementedError();
  @override
  get export => throw UnimplementedError();
  @override
  get exportMnemonicOk => throw UnimplementedError();
  @override
  get exportWarn => throw UnimplementedError();
  @override
  get changeYourPin => throw UnimplementedError();
  @override
  get wrongPin => throw UnimplementedError();
  @override
  get wrongPinHint => throw UnimplementedError();
  @override
  get yourNewPin => throw UnimplementedError();
  @override
  get pleaseConfirmYourNewPin => throw UnimplementedError();
  @override
  get passOld => throw UnimplementedError();
  @override
  get passSuccess => throw UnimplementedError();
  @override
  get passSuccessTxt => throw UnimplementedError();
  @override
  get qrScanHint => throw UnimplementedError();
  @override
  get setting => throw UnimplementedError();
  @override
  get settingLang => throw UnimplementedError();
  @override
  get settingLangAuto => throw UnimplementedError();
  @override
  get settingNode => throw UnimplementedError();
  @override
  get settingNodeList => throw UnimplementedError();
  @override
  get settingPrefix => throw UnimplementedError();
  @override
  get settingPrefixList => throw UnimplementedError();
  @override
  get share => throw UnimplementedError();
  @override
  get title => throw UnimplementedError();
  @override
  get unlock => throw UnimplementedError();
  @override
  get accountCreate => throw UnimplementedError();
  @override
  get doYouAlreadyHaveAnAccount => throw UnimplementedError();
  @override
  get accountNameChooseHint => throw UnimplementedError();
  @override
  get accountNameChoose => throw UnimplementedError();
  @override
  get accountName => throw UnimplementedError();
  @override
  get import => throw UnimplementedError();
  @override
  get pinHint => throw UnimplementedError();
  @override
  get pinInfo => throw UnimplementedError();
  @override
  get pinSecure => throw UnimplementedError();
  @override
  get addAccount => throw UnimplementedError();
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
  String get appHints => throw UnimplementedError();
  @override
  String get meetUpNotifications => throw UnimplementedError();
  @override
  String get meetUpListTileTitle => throw UnimplementedError();
  @override
  String get openAppSettings => throw UnimplementedError();
  @override
  String get enableAutoStart => throw UnimplementedError();
}
