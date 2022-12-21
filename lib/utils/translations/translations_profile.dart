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
  String get contactUs;
  String get checkEmailApp;
}

class TranslationsEnProfile implements TranslationsProfile {
  @override
  String get about => 'About';
  @override
  String get checkEmailApp => 'Check that you have downloaded the Email app';
  @override
  String get contactUs => 'Contact Us';
  @override
  String get aboutBrief => 'Mobile Wallet for Encointer';
  @override
  String get aboutVersion => 'Version';
  @override
  String get accounts => 'Accounts';
  @override
  String get accountDelete => 'Are you sure you want to delete the account?';
  @override
  String get accountsDelete => 'Are you sure you want to delete all accounts?';
  @override
  String get accountsDeleteAll => 'Remove all Accounts';
  @override
  String get accountShare => 'Share Account';
  @override
  String get addressBook => 'Address Book';
  @override
  String get cantEndorseBootstrapper => 'Bootstrappers are already marked as trusted';
  @override
  String get canEndorseInRegisteringPhaseOnly => 'Can endorse in registering phase only';
  @override
  String get contactAddress => 'Address';
  @override
  String get contactAddressError => 'Invalid address';
  @override
  String get contactDelete => 'Delete';
  @override
  String get contactDeleteWarn => 'Are you sure you want to delete this address?';
  @override
  String get contactEndorse => 'Endorse as trusted contact';
  @override
  String get contactAlreadyExists => 'Address exists already';
  @override
  String get contactMemo => 'Contact information';
  @override
  String get contactName => 'Name';
  @override
  String get contactNameError => 'Name can not be empty';
  @override
  String get contactNameAlreadyExists => 'Name exists already';
  @override
  String get contactSave => 'Save';
  @override
  String get confirmPin => 'Input your PIN to confirm';
  @override
  String get developer => 'Developer mode';
  @override
  String get enableBazaar => 'Enable Bazaar';
  @override
  String get export => 'Export Account';
  @override
  String get exportMnemonicOk => 'Mnemonic was copied to clipboard.';
  @override
  String get exportWarn =>
      'Write these words down on paper. Keep the backup paper safe. These words allows anyone to recover this account and access its funds.';
  @override
  String get noMnemonicFound => 'No Mnemonic found';
  @override
  String get importedWithRawSeedHenceNoMnemonic =>
      'Account was imported with a raw seed and therefore does not have a mnemonic';
  @override
  String get changeYourPin => 'Change PIN';
  @override
  String get wrongPin => 'Wrong PIN';
  @override
  String get wrongPinHint => 'Failed to unlock account, please check PIN.';
  @override
  String get yourNewPin => 'New PIN';
  @override
  String get pleaseConfirmYourNewPin => 'Confirm New PIN';
  @override
  String get hintEnterCurrentPin => 'To change your PIN please enter the current one.';
  @override
  String get hintThenEnterANewPin => 'Then you can choose a new one and you’re all set.';
  @override
  String get personalKey => 'Personal key';
  @override
  String get detailsEnter => 'Enter your details.';
  @override
  String get personalKeyEnter => 'Please enter your personal key (12 words) to import the new account.';
  @override
  String get reputationHistory => 'Reputation history';
  @override
  String get reputationOverall => 'Overall reputation';
  @override
  String get passOld => 'Current PIN';
  @override
  String get passSuccess => 'Success';
  @override
  String get passSuccessTxt => 'PIN changed successfully';
  @override
  String get qrScanHint => 'Enter the amount you wish to receive and let the sender scan the QR code.';
  @override
  String get qrScanHintAccount => 'Ask the recipient to scan the QR-code in the encointer app.';
  @override
  String get receiverAccount => 'Receiving account:';
  @override
  String get sendLink => 'Send link';
  @override
  String get setting => 'Settings';
  @override
  String get settingLang => 'Language';
  @override
  String get settingLangAuto => 'Auto Detect';
  @override
  String get settingNode => 'Remote Node';
  @override
  String get settingNodeList => 'Available Nodes';
  @override
  String get settingPrefix => 'Address Prefix';
  @override
  String get settingPrefixList => 'Available Prefixes';
  @override
  String get share => 'Share';
  @override
  String get title => 'Profile';
  @override
  String get unlock => 'You need to enter your PIN to add a new account';
  @override
  String get addAccount => 'Add account';
  @override
  String get addCommunity => 'Add community';
  @override
  String get accountCreate => 'Create account';
  @override
  String get doYouAlreadyHaveAnAccount => 'Do you already have an account?';
  @override
  String get accountNameChooseHint => 'You can change it later in your profile settings.';
  @override
  String get accountNameChoose => 'Choose an account name.';
  @override
  String get accountName => 'Account name';
  @override
  String get import => 'Import';
  @override
  String get pinHint => 'You will need this PIN for transactions and adding a new account.';
  @override
  String get pinInfo =>
      'PIN should consist of at least 4 digits. If the PIN is lost, there is no option to restore the account unless you made a backup via the profile page.';
  @override
  String get pinSecure => 'Secure your account with a PIN.';
  @override
  String get recoveryProxy => 'recovery proxy';
  @override
  String get reputation => 'Reputation';
  @override
  String get shareLinkHint => 'Or you can share a link:';
  @override
  String get tokenSend => 'Send SYMBOL';
  @override
  String get addContact => 'Add contact';
  @override
  String get deleteAccount => 'delete';
  @override
  String get exportAccount => 'export';
  @override
  String get errorUserNameIsRequired => 'User name cannot be blank';
  @override
  String get observedPendingExtrinsic => 'Pending transaction observed. Please wait for confirmation!';
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
  String get checkEmailApp => 'Keine Email-App installiert';
  @override
  String get contactUs => 'Kontaktiere Uns';
  @override
  String get about => 'Über';
  @override
  String get aboutBrief => 'Mobiles Wallet für Encointer';
  @override
  String get aboutVersion => 'Version';
  @override
  String get accounts => 'Konten';
  @override
  String get accountDelete => 'Bist du sicher, dass du das Konto löschen möchtest?';
  @override
  String get accountsDelete => 'Bist du sicher, dass du alle Konten löschen möchtest?';
  @override
  String get accountsDeleteAll => 'Lösche alle Konten';
  @override
  String get accountShare => 'Konto teilen';
  @override
  String get addressBook => 'Adressbuch';
  @override
  String get cantEndorseBootstrapper => 'Bootstrapper sind bereits als zuverlässig markiert';
  @override
  String get canEndorseInRegisteringPhaseOnly =>
      'Du kannst nur in der Registrierungsphase jemanden als zuverlässig markieren';
  @override
  String get contactAddress => 'Addresse';
  @override
  String get contactAddressError => 'Ungültige Adresse';
  @override
  String get contactDelete => 'Löschen';
  @override
  String get contactDeleteWarn => 'Bist du sicher, dass du diese Adresse löschen möchtest?';
  @override
  String get contactEndorse => 'Als vertrauenswürdig bestätigen';
  @override
  String get contactAlreadyExists => 'Adresse existiert bereits';
  @override
  String get contactMemo => 'Kontaktinformationen';
  @override
  String get contactName => 'Name';
  @override
  String get contactNameError => 'Name muss ausgefüllt werden';
  @override
  String get contactNameAlreadyExists => 'Name existiert bereits';
  @override
  String get contactSave => 'Speichere';
  @override
  String get confirmPin => 'Bitte PIN bestätigen';
  @override
  String get developer => 'Entwickler-Modus';
  @override
  String get enableBazaar => 'Bazaar aktivieren';
  @override
  String get export => 'Konto exportieren';
  @override
  String get exportMnemonicOk => 'Mnemonik wurde in die Zwischenablage kopiert.';
  @override
  String get exportWarn =>
      'Schreibe diese Wörter auf ein Papier. Behalte das Papier an einem sicheren Ort. Diese Wörter geben jedem Zugriff auf das Konto und das Vermögen';
  @override
  String get noMnemonicFound => 'Keine Mnemonik gefunden';
  @override
  String get importedWithRawSeedHenceNoMnemonic =>
      'Konto wurde mit einem Raw Seed importiert und hat deshalb keine Mnemonik';
  @override
  String get changeYourPin => 'PIN ändern';
  @override
  String get wrongPin => 'Falscher PIN';
  @override
  String get wrongPinHint => 'Konto konnte nicht entsperrt werden. Bitte überprüfe die eingegebene PIN.';
  @override
  String get yourNewPin => 'Neue PIN';
  @override
  String get pleaseConfirmYourNewPin => 'Bestätige neue PIN';
  @override
  String get hintEnterCurrentPin => 'Gib deinen jetzigen PIN ein um den PIN zu ändern.';
  @override
  String get hintThenEnterANewPin => 'Dann kannst du deinen neuen Pin eingeben.';
  @override
  String get detailsEnter => 'Gib deine Details ein.';
  @override
  String get personalKeyEnter => 'Gib deinen persönlichen Key ein (12 Wörter), um dein Konto zu importieren.';
  @override
  String get reputationHistory => 'Reputation History';
  @override
  String get reputationOverall => 'Allgemeine Reputation';
  @override
  String get passOld => 'Aktuelle PIN';
  @override
  String get passSuccess => 'Erfolgreich';
  @override
  String get passSuccessTxt => 'PIN wurde erfolgreich geändert';
  @override
  String get receiverAccount => 'Empfangendes Konto:';
  @override
  String get personalKey => 'Persönlicher Schlüssel';
  @override
  String get qrScanHint => 'Gib den Betrag, den du erhalten möchtest ein und lasse den Sender den QR Code scannen.';
  @override
  String get qrScanHintAccount => 'Bitte den Empfänger den QR-Code in der Encointer App zu scannen.';
  @override
  String get sendLink => 'Link senden';
  @override
  String get setting => 'Einstellungen';
  @override
  String get settingLang => 'Sprache';
  @override
  String get settingLangAuto => 'Automatisch';
  @override
  String get settingNode => 'Entfernter Knoten';
  @override
  String get settingNodeList => 'Verfügbare Knoten';
  @override
  String get settingPrefix => 'Adressenpräfix';
  @override
  String get settingPrefixList => 'Verfügbare Präfix';
  @override
  String get share => 'Teilen';
  @override
  String get shareLinkHint => 'Oder über Link teilen:';
  @override
  String get title => 'Profil';
  @override
  String get unlock => 'Du musst deinen PIN eingeben um einen neuen Account hinzuzufügen';
  @override
  String get addAccount => 'Konto hinzufügen';
  @override
  String get addCommunity => 'Gem. hinzufügen';
  @override
  String get accountCreate => 'Konto kreieren';
  @override
  String get doYouAlreadyHaveAnAccount => 'Hast du bereits ein Konto?';
  @override
  String get accountNameChooseHint => 'Du kannst den Namen später ändern in den Profileinstellungen.';
  @override
  String get accountNameChoose => 'Wähle einen Kontonamen.';
  @override
  String get accountName => 'Kontoname';
  @override
  String get import => 'Importiere';
  @override
  String get pinHint => 'Du wirst diese PIN benötigen um Transaktionen zu tätigen oder neue Konten hinzufügen.';
  @override
  String get pinInfo =>
      'PIN muss mindestens 4 Ziffern enthalten. Bei PIN-Verlust ist der Account nicht wiederherstellbar, ausser man hat ein Backup auf der Profilseite gemacht.';
  @override
  String get pinSecure => 'Sichere dein Konto mit einem PIN.';
  @override
  String get recoveryProxy => 'Wiederherstellungsproxy';
  @override
  String get reputation => 'Reputation';
  @override
  String get tokenSend => 'SYMBOL senden';
  @override
  String get addContact => 'Kontakt hinzufügen';
  @override
  String get deleteAccount => 'löschen';
  @override
  String get exportAccount => 'exportieren';
  @override
  String get errorUserNameIsRequired => 'Benutzername darf nicht leer sein';
  @override
  String get observedPendingExtrinsic =>
      'Es wurde eine unbestätigte Transaktion beobachtet. Bitte warte auf Bestätigung!';
  @override
  String get appHints => 'App-Tipps';
  @override
  String get meetUpNotifications => 'Meetup-Benachrichtigungen';
  @override
  String get meetUpListTileTitle =>
      'Wenn Dein Gerät ein Xiaomi oder Honor Smartphone is, muss Autostart aktiviert sein um Meetup-Benachrichtigungen '
      'zu erhalten.';
  @override
  String get openAppSettings => 'App-Einstellungen öffnen';
  @override
  String get enableAutoStart => 'Autostart aktivieren';
}

class TranslationsFrProfile implements TranslationsProfile {
  @override
  String get checkEmailApp => throw UnimplementedError();
  @override
  String get contactUs => throw UnimplementedError();
  @override
  String get about => throw UnimplementedError();
  @override
  String get aboutBrief => throw UnimplementedError();
  @override
  String get aboutVersion => throw UnimplementedError();
  @override
  String get accounts => throw UnimplementedError();
  @override
  String get accountDelete => throw UnimplementedError();
  @override
  String get accountShare => throw UnimplementedError();
  @override
  String get addressBook => throw UnimplementedError();
  @override
  String get cantEndorseBootstrapper => throw UnimplementedError();
  @override
  String get canEndorseInRegisteringPhaseOnly => throw UnimplementedError();
  @override
  String get contactAddress => throw UnimplementedError();
  @override
  String get contactAddressError => throw UnimplementedError();
  @override
  String get contactDelete => throw UnimplementedError();
  @override
  String get contactDeleteWarn => throw UnimplementedError();
  @override
  String get contactEndorse => throw UnimplementedError();
  @override
  String get contactAlreadyExists => throw UnimplementedError();
  @override
  String get contactMemo => throw UnimplementedError();
  @override
  String get contactName => throw UnimplementedError();
  @override
  String get contactNameError => throw UnimplementedError();
  @override
  String get contactNameAlreadyExists => throw UnimplementedError();
  @override
  String get contactSave => throw UnimplementedError();
  @override
  String get confirmPin => throw UnimplementedError();
  @override
  String get developer => throw UnimplementedError();
  @override
  String get export => throw UnimplementedError();
  @override
  String get exportMnemonicOk => throw UnimplementedError();
  @override
  String get exportWarn => throw UnimplementedError();
  @override
  String get changeYourPin => throw UnimplementedError();
  @override
  String get wrongPin => throw UnimplementedError();
  @override
  String get wrongPinHint => throw UnimplementedError();
  @override
  String get yourNewPin => throw UnimplementedError();
  @override
  String get pleaseConfirmYourNewPin => throw UnimplementedError();
  @override
  String get passOld => throw UnimplementedError();
  @override
  String get passSuccess => throw UnimplementedError();
  @override
  String get passSuccessTxt => throw UnimplementedError();
  @override
  String get qrScanHint => throw UnimplementedError();
  @override
  String get setting => throw UnimplementedError();
  @override
  String get settingLang => throw UnimplementedError();
  @override
  String get settingLangAuto => throw UnimplementedError();
  @override
  String get settingNode => throw UnimplementedError();
  @override
  String get settingNodeList => throw UnimplementedError();
  @override
  String get settingPrefix => throw UnimplementedError();
  @override
  String get settingPrefixList => throw UnimplementedError();
  @override
  String get share => throw UnimplementedError();
  @override
  String get title => throw UnimplementedError();
  @override
  String get unlock => throw UnimplementedError();
  @override
  String get accountCreate => throw UnimplementedError();
  @override
  String get doYouAlreadyHaveAnAccount => throw UnimplementedError();
  @override
  String get accountNameChooseHint => throw UnimplementedError();
  @override
  String get accountNameChoose => throw UnimplementedError();
  @override
  String get accountName => throw UnimplementedError();
  @override
  String get import => throw UnimplementedError();
  @override
  String get pinHint => throw UnimplementedError();
  @override
  String get pinInfo => throw UnimplementedError();
  @override
  String get pinSecure => throw UnimplementedError();
  @override
  String get addAccount => throw UnimplementedError();
  @override
  String get addCommunity => throw UnimplementedError();
  @override
  String get recoveryProxy => 'recovery proxy';
  @override
  String get reputation => throw UnimplementedError();
  @override
  String get sendLink => throw UnimplementedError();
  @override
  String get tokenSend => throw UnimplementedError();
  @override
  String get qrScanHintAccount => throw UnimplementedError();
  @override
  String get receiverAccount => throw UnimplementedError();
  @override
  String get shareLinkHint => throw UnimplementedError();
  @override
  String get hintEnterCurrentPin => throw UnimplementedError();
  @override
  String get hintThenEnterANewPin => throw UnimplementedError();
  @override
  String get reputationHistory => throw UnimplementedError();
  @override
  String get reputationOverall => throw UnimplementedError();
  @override
  String get accountsDelete => throw UnimplementedError();
  @override
  String get accountsDeleteAll => throw UnimplementedError();
  @override
  String get personalKeyEnter => throw UnimplementedError();
  @override
  String get detailsEnter => throw UnimplementedError();
  @override
  String get personalKey => throw UnimplementedError();
  @override
  String get enableBazaar => throw UnimplementedError();
  @override
  String get noMnemonicFound => throw UnimplementedError();
  @override
  String get importedWithRawSeedHenceNoMnemonic => throw UnimplementedError();
  @override
  String get addContact => throw UnimplementedError();
  @override
  String get deleteAccount => throw UnimplementedError();
  @override
  String get exportAccount => throw UnimplementedError();
  @override
  String get errorUserNameIsRequired => throw UnimplementedError();
  @override
  String get observedPendingExtrinsic => throw UnimplementedError();
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

class TranslationsRuProfile implements TranslationsProfile {
  @override
  String get checkEmailApp => 'Убедитесь, что вы загрузили приложение электронной почты';
  @override
  String get contactUs => 'Связаться с нами';
  @override
  String get about => 'О';
  @override
  String get aboutBrief => 'Мобильный кошелек Encointer';
  @override
  String get aboutVersion => 'Версия';
  @override
  String get accounts => 'Учетные записи';
  @override
  String get accountDelete => 'Вы уверены, что хотите удалить аккаунт?';
  @override
  String get accountsDelete => 'Вы уверены, что хотите удалить все аккаунты?';
  @override
  String get accountsDeleteAll => 'Удалить все аккаунты';
  @override
  String get accountShare => 'Поделиться аккаунтом';
  @override
  String get addressBook => 'Адресная книга';
  @override
  String get cantEndorseBootstrapper => 'Бутсреперы уже отмечены как надежные';
  @override
  String get canEndorseInRegisteringPhaseOnly => 'Может быть одобрен только на этапе регистрации';
  @override
  String get contactAddress => 'Адрес';
  @override
  String get contactAddressError => 'Неправильный адрес';
  @override
  String get contactDelete => 'Удалить';
  @override
  String get contactDeleteWarn => 'Вы уверены, что хотите удалить этот адрес?';
  @override
  String get contactEndorse => 'Утвердить в качестве доверенного контакта';
  @override
  String get contactAlreadyExists => 'Адрес уже существует';
  @override
  String get contactMemo => 'Контактная информация';
  @override
  String get contactName => 'Имя';
  @override
  String get contactNameError => 'Графа Имя не может быть пустой';
  @override
  String get contactNameAlreadyExists => 'Имя уже существует';
  @override
  String get contactSave => 'Сохранить';
  @override
  String get confirmPin => 'Для подтверждения введите свой PIN-код';
  @override
  String get developer => 'Режим разработчика';
  @override
  String get enableBazaar => 'Включить Базар';
  @override
  String get export => 'Экпорт аккаунта';
  @override
  String get exportMnemonicOk => 'Мнемоника скопирована в буфер обмена.';
  @override
  String get exportWarn =>
      'Запишите эти слова на бумаге. Храните бумагу в безопасном месте. Эти слова позволят восстановить этот аккаунт и получить доступ к его средствам.';
  @override
  String get noMnemonicFound => 'Мнемоника не найдена';
  @override
  String get importedWithRawSeedHenceNoMnemonic =>
      'Аккаунт был импортирован с необработанным исходным кодом и поэтому не имеет мнемоники';
  @override
  String get changeYourPin => 'Изменить PIN-код';
  @override
  String get wrongPin => 'Неправильный PIN-код';
  @override
  String get wrongPinHint => 'Не удалось разблокировать аккаунт, пожалуйста, проверьте PIN-код.';
  @override
  String get yourNewPin => 'Новый PIN-код';
  @override
  String get pleaseConfirmYourNewPin => 'Подтвердите PIN-код';
  @override
  String get hintEnterCurrentPin => 'Чтобы изменить PIN-код пожалуйста введите текущий.';
  @override
  String get hintThenEnterANewPin => 'Вы можете выбрать новый, и все готово.';
  @override
  String get personalKey => 'Секретный ключ';
  @override
  String get detailsEnter => 'Введите свои данные.';
  @override
  String get personalKeyEnter => 'Пожалуйста, введите секретный ключ (из 12 слов), чтобы импортировать аккаунт.';
  @override
  String get reputationHistory => 'История репутции';
  @override
  String get reputationOverall => 'Общая репутация';
  @override
  String get passOld => 'Текущий PIN-код';
  @override
  String get passSuccess => 'Успешный';
  @override
  String get passSuccessTxt => 'PIN-код иземенен успешно';
  @override
  String get qrScanHint => 'Введите сумму, которую хотите получить, и позвольте отправителю отсканировать QR-код.';
  @override
  String get qrScanHintAccount => 'Попросите получателя отсканировать QR-код в приложении Еncointer.';
  @override
  String get receiverAccount => 'Аккаунт получателя:';
  @override
  String get sendLink => 'Отправить ссылку';
  @override
  String get setting => 'Настройки';
  @override
  String get settingLang => 'Язык';
  @override
  String get settingLangAuto => 'Авто-определение';
  @override
  String get settingNode => 'Дистанционный режим';
  @override
  String get settingNodeList => 'Доступные режимы';
  @override
  String get settingPrefix => 'Префикс адреса';
  @override
  String get settingPrefixList => 'Доступные префиксы';
  @override
  String get share => 'Поделиться';
  @override
  String get title => 'Профиль';
  @override
  String get unlock => 'Вам необходимо ввести свой PIN-код, чтобы добавить новую учетную запись';
  @override
  String get addAccount => 'Добавить аккаунт';
  @override
  String get addCommunity => 'Добавить общину';
  @override
  String get accountCreate => 'Создать аккаунт';
  @override
  String get doYouAlreadyHaveAnAccount => 'У вас уже есть аккаунт?';
  @override
  String get accountNameChooseHint => 'Вы можете изменить его позже в настройках профиля.';
  @override
  String get accountNameChoose => 'Выберите имя Аккаунта';
  @override
  String get accountName => 'Имя Аккаунта';
  @override
  String get import => 'Импортировать';
  @override
  String get pinHint => 'Этот PIN-код понадобится вам для транзакций и добавления новой учетной записи.';
  @override
  String get pinInfo =>
      'PIN-код должен состоять как минимум из 4 цифр. При утере PIN-кода, восстановить аккаунт невозможно, если только вы не сделали резервную копию в профиле.';
  @override
  String get pinSecure => 'Защитите свой аккаунт с помощью PIN-кода.';
  @override
  String get recoveryProxy => 'Прокси-сервер для восстановления';
  @override
  String get reputation => 'Репутация';
  @override
  String get shareLinkHint => 'Или вы можете поделиться ссылкой:';
  @override
  String get tokenSend => 'Отправить SYMBOL';
  @override
  String get addContact => 'Добавить контакт';
  @override
  String get deleteAccount => 'Удалить';
  @override
  String get exportAccount => 'Экспорт';
  @override
  String get errorUserNameIsRequired => 'Имя пользователя не может быть пустым';
  @override
  String get observedPendingExtrinsic => 'Наблюдается незавершенная транзакция. Пожалуйста, дождитесь подтверждения!';
  @override
  String get appHints => 'Рекомендации по использованию приложения';
  @override
  String get meetUpNotifications => 'Meetup - уведомления';
  @override
  String get meetUpListTileTitle =>
      'Если ваше устройство является телефоном Xiaomi или Honor, включите автозапуск, чтобы получать Meetup - уведомления.';
  @override
  String get openAppSettings => 'Открыть настройки приложения';
  @override
  String get enableAutoStart => 'Включить автозапуск';
}
