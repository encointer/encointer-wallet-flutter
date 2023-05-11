/// contains translations for Account
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsAccount {
  String get advanced;
  String get create;
  String get createError;
  String get createHint;
  String get createPassword;
  String get createPassword2;
  String get createPassword2Error;
  String get createPasswordError;
  String get importDuplicate;
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
  String get welcome;
  String get pinError;
  String get signIn;
  String get localizedReason;
  String get biometricAuth;
}

class TranslationsEnAccount implements TranslationsAccount {
  @override
  String get advanced => 'Advanced Options';
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
  @override
  String get welcome => 'Welcome';
  @override
  String get pinError => 'PIN is incorrect';
  @override
  String get signIn => 'Sign in';
  @override
  String get localizedReason => 'Authenticate to access your account.';
  @override
  String get biometricAuth => 'Biometric authentication';
}

class TranslationsDeAccount implements TranslationsAccount {
  @override
  String get advanced => 'Erweiterte Optionen';
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
  @override
  String get welcome => 'Willkommen';
  @override
  String get pinError => 'PIN ist falsch';
  @override
  String get signIn => 'Anmelden';
  @override
  String get localizedReason => 'Authentifizierung notwendig um auf dein Konto zuzugreifen.';
  @override
  String get biometricAuth => 'Biometrische Authentifizierung';
}

class TranslationsFrAccount implements TranslationsAccount {
  @override
  String get advanced => 'Options étendues';
  @override
  String get create => 'Créer un compte';
  @override
  String get createError => "Une erreur s'est produite lors de la création de ton compte";
  @override
  String get createHint => '(Exemple Alice)';
  @override
  String get createPassword => 'NIP';
  @override
  String get createPassword2 => 'Confirmer le NIP';
  @override
  String get createPassword2Error => 'Les codes NIP ne correspondent pas';
  @override
  String get createPasswordError => "Le code NIP doit être composé d'au moins 4 chiffres et d'aucun autre caractère";
  @override
  String get importDuplicate => 'Ce compte existe déjà, veux-tu le remplacer?';
  @override
  String get importInvalid => 'Non valide';
  @override
  String get importInvalidRawSeed => 'Raw seed invalide entré.';
  @override
  String get importInvalidMnemonic => 'Mnémonique invalide entré.';
  @override
  String get importMustNotBeEmpty => "L'entrée ne peut pas être vide";
  @override
  String get importPrivateKeyUnsupported => "Le compte d'importation avec clé privée n'est pas encore pris en charge";
  @override
  String get keystore => 'Keystore (json)';
  @override
  String get list => 'Sélection de compte';
  @override
  String get mnemonic => 'Mnémonique';
  @override
  String get next => 'Prochain';
  @override
  String get observe => 'Moniteur';
  @override
  String get observeBrief =>
      'Marquez cette adresse comme étant à moniteur, puis cette adresse peut être sélectionnée dans la page de sélection de compte pour surveiller ses actifs et ses actions';
  @override
  String get observeProxyInvalid => 'Compte proxy invalide';
  @override
  String get path => 'Chemin de dérivation secret';
  @override
  String get qrScan => 'Scannez le code QR';
  @override
  String get rawSeed => 'Scannes le code QR';
  @override
  String get uosCanceled => 'Transaction est annulée';
  @override
  String get uosPush => 'Scanner pour publier';
  @override
  String get uosScan => 'Scanner et envoyer la transaction signée';
  @override
  String get uosSigner => 'Signataire';
  @override
  String get uosTitle => 'Signature hors ligne';
  @override
  String get welcome => 'Bienvenue';
  @override
  String get pinError => 'Le code PIN est incorrect';
  @override
  String get signIn => 'Se connecter';
  @override
  String get localizedReason => 'Authentification nécessaire pour accéder à ton compte.';
  @override
  String get biometricAuth => 'Authentification biométrique';
}

class TranslationsRuAccount implements TranslationsAccount {
  @override
  String get advanced => 'Дополнительные параметры';
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
  String get observeBrief => 'Отметьте это адрес как подлежащий мониторингу, позже вы сможете выбрать этот '
      'адрес на странице выбора аккаунта, для просмотра его активов и действий';
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
  @override
  String get welcome => 'Добро пожаловать';
  @override
  String get pinError => 'Неверный PIN-код';
  @override
  String get signIn => 'Войти';
  @override
  String get localizedReason => 'Аутентифицируйтесь для доступа к вашей учетной записи.';
  @override
  String get biometricAuth => 'Биометрическая аутентификация';
}
