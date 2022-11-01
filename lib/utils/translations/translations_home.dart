/// contains translations for Home
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsHome {
  String get cancel;
  String get scan;
  String get contacts;
  String get closeApp;
  String get copy;
  String get create;
  String get detail;
  String get exitConfirm;
  String get errorOccurred;

  String get loading;
  String get next;
  String get notifySubmitted;
  String get notifySubmittedQueued;
  String get ok;
  String get pinNeeded;
  String get settingNetwork;
  String get submit;
  String get submitCall;
  String get submitFees;
  String get submitFeesOffline;
  String get submitFrom;
  String get submitNoSign;
  String get submitQr;
  String get submitTransaction;
  String get success;
  String get switchAccount;
  String get switchCommunity;
  String get transactionQueued;
  String get transactionQueuedOffline;
  String get unlock;
  String get unlockAccount;
  String get updateDownload;
  String get updateError;
  String get updateJsUp;
  String get updateLatest;
  String get updateToNewerVersionQ;
  String get accountImport;
  String get txQueued;
  String get txQueuedOffline;
  String get txReady;
  String get txBroadcast;
  String get txInBlock;
  String get txError;
  String get updatingAppState;
  String get cameraPermissionError;
  String get appSettings;
}

class TranslationsEnHome implements TranslationsHome {
  @override
  get cancel => 'Cancel';
  @override
  get scan => 'Scan';
  @override
  get contacts => 'Contacts';
  @override
  get closeApp => 'Close app';
  @override
  get copy => 'Copy to clipboard';
  @override
  get create => 'Create Account';
  @override
  get detail => 'Detail';
  @override
  get exitConfirm => 'Do you want to exit the App?';
  @override
  get errorOccurred => 'An error occurred:';

  @override
  get loading => 'Loading...';
  @override
  get next => 'Next Step';
  @override
  get notifySubmitted => 'transaction Submitted';
  @override
  get notifySubmittedQueued => 'Queued transaction Submitted';
  @override
  get ok => 'OK';
  @override
  get pinNeeded => 'PIN is needed to use the app';
  @override
  get settingNetwork => 'Select Wallet';
  @override
  get submit => 'Sign and Submit';
  @override
  get submitCall => 'Calling ';
  @override
  get submitFees => 'Fees';
  @override
  get submitFeesOffline => 'Fees unavailable (offline)';
  @override
  get submitFrom => 'You are about to sign a transaction from ';
  @override
  get submitNoSign => 'Submit (no sign)';
  @override
  get submitQr => 'Sign via QR';
  @override
  get submitTransaction => 'Submit Transaction';
  @override
  get success => 'Success';
  @override
  get switchAccount => 'Switch Account';
  @override
  get switchCommunity => 'Switch Community';
  @override
  get transactionQueued => 'Queued';
  @override
  get transactionQueuedOffline =>
      'App is not connected to the blockchain. Queued transaction (will be sent automatically upon reconnection).';
  @override
  get unlock => 'Unlock Account with PIN';
  @override
  get unlockAccount => 'Unlock account CURRENT_ACCOUNT_NAME with PIN';
  @override
  get updateDownload => 'Downloading...';
  @override
  get updateError => 'Update Failed';
  @override
  get updateJsUp => 'Metadata needs to be updated to continue.';
  @override
  get updateLatest => 'Your App is the newest version.';
  @override
  get updateToNewerVersionQ => 'New version found, update now?';
  @override
  get accountImport => 'Import account';
  @override
  get txQueued => 'Queued Transaction';
  @override
  get txQueuedOffline => 'You are offline. Transaction will be sent when you are back online.';
  @override
  get txReady => 'Transaction is ready.';
  @override
  get txBroadcast => 'Transaction has been broadcast.';
  @override
  get txInBlock => 'Transaction is in a block.';
  @override
  get txError => 'Transaction error';
  @override
  get updatingAppState => 'Updating the app state...';
  @override
  get cameraPermissionError => 'There was an error getting the camera permission. '
      'Alternatively, you can grant permission in the app settings.';
  @override
  get appSettings => 'App settings';
}

class TranslationsDeHome implements TranslationsHome {
  @override
  get cancel => 'Abbruch';
  @override
  get closeApp => 'App schliessen';
  @override
  get contacts => 'Kontakte';
  @override
  get copy => 'In die Zwischenablage kopieren';
  @override
  get create => 'Konto erstellen';
  @override
  get detail => 'Detail';
  @override
  get exitConfirm => 'Möchtest du die App verlassen?';
  @override
  get errorOccurred => 'Es is ein Fehler aufgetaucht:';

  @override
  get loading => 'Lädt...';
  @override
  get next => 'Nächster Schritt';
  @override
  get notifySubmitted => 'Transaktion eingereicht';
  @override
  get notifySubmittedQueued => 'Die Transaktion in der Warteschlange wurde eingereicht';
  @override
  get ok => 'OK';
  @override
  get pinNeeded => 'PIN ist notwendig um die App zu benutzen';
  @override
  get scan => 'Scannen';
  @override
  get settingNetwork => 'Wähle ein Portemonnaie';
  @override
  get submit => 'Signieren und senden';
  @override
  get submitCall => 'Wird ausgeführt';
  @override
  get submitFees => 'Gebühren';
  @override
  get submitFeesOffline => 'Gebühren nicht verfügbar (offline)';
  @override
  get submitFrom => 'Transaktion wird signiert von ';
  @override
  get submitNoSign => 'Senden (ohne Signatur)';
  @override
  get submitQr => 'Signieren via QR';
  @override
  get submitTransaction => 'Transaktion senden';
  @override
  get success => 'Erfolgreich';
  @override
  get switchAccount => 'Konto wechseln';
  @override
  get switchCommunity => 'Gemeinschaft wechseln';
  @override
  get transactionQueued => 'In der Warteschlange';
  @override
  get transactionQueuedOffline =>
      'Die App ist nicht mit der Blockchain verbunden. Die Transaktionen in der Warteschlange werden automatisch bei erfolgreicher Verbindung versendet.';
  @override
  get unlock => 'Konto entsperren mit PIN';
  @override
  get unlockAccount => 'Entsperre Konto CURRENT_ACCOUNT_NAME mit PIN';
  @override
  get updateDownload => 'Herunterladen...';
  @override
  get updateError => 'Update fehlgeschlagen';
  @override
  get updateJsUp => 'Metadaten müssen aktualisiert werden um fortzusetzen.';
  @override
  get updateLatest => 'Die App ist auf dem neusten Stand.';
  @override
  get updateToNewerVersionQ => 'Neue Version gefunden, jetzt aktualisieren?';
  @override
  get accountImport => 'Konto importieren';
  @override
  get txQueued => 'Transaktion is in der Warteschlange';
  @override
  get txQueuedOffline => 'Du bist offline. Die Transaktion wird geschickt, wenn du wieder online bist.';
  @override
  get txReady => 'Transaktion bereit.';
  @override
  get txBroadcast => 'Transaktion wurde im Netzwerk';
  @override
  get txInBlock => 'Transaction ist in einem Block';
  @override
  get txError => 'Transaktionsfehler';
  @override
  get updatingAppState => 'App-Zustand wird aktualisiert...';
  @override
  get cameraPermissionError => 'Es gab einen Fehler beim überprüfen der Kameraerlaubnis.'
      'Du kannst die Erlaubnis für die Kamera auch über die App-Einstellungen erteilen.';
  @override
  get appSettings => 'App-Einstellungen';
}

class TranslationsFrHome implements TranslationsHome {
  @override
  get cancel => throw UnimplementedError();
  @override
  get scan => throw UnimplementedError();
  @override
  get contacts => throw UnimplementedError();
  @override
  get closeApp => throw UnimplementedError();
  @override
  get copy => throw UnimplementedError();
  @override
  get create => throw UnimplementedError();
  @override
  get detail => throw UnimplementedError();
  @override
  get exitConfirm => throw UnimplementedError();
  @override
  get errorOccurred => throw UnimplementedError();

  @override
  get loading => throw UnimplementedError();
  @override
  get next => throw UnimplementedError();
  @override
  get notifySubmitted => throw UnimplementedError();
  @override
  get notifySubmittedQueued => throw UnimplementedError();
  @override
  get ok => throw UnimplementedError();
  @override
  get pinNeeded => throw UnimplementedError();
  @override
  get settingNetwork => throw UnimplementedError();
  @override
  get submit => throw UnimplementedError();
  @override
  get submitCall => throw UnimplementedError();
  @override
  get submitFees => throw UnimplementedError();
  @override
  get submitFeesOffline => throw UnimplementedError();
  @override
  get submitFrom => throw UnimplementedError();
  @override
  get submitNoSign => throw UnimplementedError();
  @override
  get submitQr => throw UnimplementedError();
  @override
  get submitTransaction => throw UnimplementedError();
  @override
  get success => throw UnimplementedError();
  @override
  get switchAccount => throw UnimplementedError();
  @override
  get switchCommunity => throw UnimplementedError();
  @override
  get transactionQueued => throw UnimplementedError();
  @override
  get transactionQueuedOffline => throw UnimplementedError();
  @override
  get unlock => throw UnimplementedError();
  @override
  get unlockAccount => throw UnimplementedError();
  @override
  get updateDownload => throw UnimplementedError();
  @override
  get updateError => throw UnimplementedError();
  @override
  get updateJsUp => throw UnimplementedError();
  @override
  get updateLatest => throw UnimplementedError();
  @override
  get updateToNewerVersionQ => throw UnimplementedError();
  @override
  get accountImport => throw UnimplementedError();
  @override
  get txQueued => throw UnimplementedError();
  @override
  get txQueuedOffline => throw UnimplementedError();
  @override
  get txReady => throw UnimplementedError();
  @override
  get txBroadcast => throw UnimplementedError();
  @override
  get txInBlock => throw UnimplementedError();
  @override
  get txError => throw UnimplementedError();
  @override
  get updatingAppState => throw UnimplementedError();
  @override
  get cameraPermissionError => throw UnimplementedError();
  @override
  get appSettings => throw UnimplementedError();
}

class TranslationsRuHome implements TranslationsHome {
  @override
  get cancel => 'Отмена';
  @override
  get scan => 'Сканировать';
  @override
  get contacts => 'Контакты';
  @override
  get closeApp => 'Закрыть приложение';
  @override
  get copy => 'Скопировать вв буфер обмена';
  @override
  get create => 'Создать аккаунт';
  @override
  get detail => 'Детали';
  @override
  get exitConfirm => 'Вы хотите выйти из приложения?';
  @override
  get errorOccurred => 'Возникла ошибка:';

  @override
  get loading => 'Загрузка...';
  @override
  get next => 'Следующий шаг';
  @override
  get notifySubmitted => 'Транзакция отправлена';
  @override
  get notifySubmittedQueued => 'Ожидающая транзакция отправлена';
  @override
  get ok => 'OK';
  @override
  get pinNeeded => 'для использования приложения необходим PIN-код';
  @override
  get settingNetwork => 'Выберите кошелек';
  @override
  get submit => 'Войти и отправить';
  @override
  get submitCall => 'Выполнить звонок';
  @override
  get submitFees => 'Платеж';
  @override
  get submitFeesOffline => 'Платеж недоступен (оффлайн)';
  @override
  get submitFrom => 'Вы подписываете транзакцию с ';
  @override
  get submitNoSign => 'Отправить (без подписи)';
  @override
  get submitQr => 'Подписать через QR';
  @override
  get submitTransaction => 'Отправить транзакцию';
  @override
  get success => 'Успешно';
  @override
  get switchAccount => 'Сменить аккаунт';
  @override
  get switchCommunity => 'Сменить сообщество';
  @override
  get transactionQueued => 'В очереди';
  @override
  get transactionQueuedOffline =>
      'Приложение не подключено к блокчейну. Транзакция, которая в очереди (будет отправлена автоматически при подключении).';
  @override
  get unlock => 'Разблокируйте учетную запись с помощью PIN-кода';
  @override
  get unlockAccount => 'Разблокируйте учетную запись CURRENT_ACCOUNT_NAME с помощью PIN-кода';
  @override
  get updateDownload => 'Загружается...';
  @override
  get updateError => 'Не удалось загрузить обновление';
  @override
  get updateJsUp => 'Чтобы продолжить, необходимо обновить метаданные.';
  @override
  get updateLatest => 'Новейшая версия приложения установлена';
  @override
  get updateToNewerVersionQ => 'Доступна новая версия, обновить сейчас?';
  @override
  get accountImport => 'Импортировать учтеную запись';
  @override
  get txQueued => 'Транзакция поставлена в очередь';
  @override
  get txQueuedOffline =>
      'Вы находитесь в оффлайн режиме. Транзакция будет отправлена, когда вы снова подключитесь к сети.';
  @override
  get txReady => 'Транзакция готова.';
  @override
  get txBroadcast => 'Транзакция передана в эфир';
  @override
  get txInBlock => 'Транзакция заблокирована';
  @override
  get txError => 'Ошибка транзакции';
  @override
  get updatingAppState => 'Обновление приложения';
  @override
  get cameraPermissionError =>
      'Произошла ошибка при получении разрешения камеры. Вы можете предоставить разрешение в настройках приложения.';
  @override
  get appSettings => 'Настройки приложения';
}
