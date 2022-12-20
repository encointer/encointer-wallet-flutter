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
  String get cancel => 'Cancel';
  @override
  String get scan => 'Scan';
  @override
  String get contacts => 'Contacts';
  @override
  String get closeApp => 'Close app';
  @override
  String get copy => 'Copy to clipboard';
  @override
  String get create => 'Create Account';
  @override
  String get detail => 'Detail';
  @override
  String get exitConfirm => 'Do you want to exit the App?';
  @override
  String get errorOccurred => 'An error occurred:';
  @override
  String get loading => 'Loading...';
  @override
  String get next => 'Next Step';
  @override
  String get notifySubmitted => 'transaction Submitted';
  @override
  String get notifySubmittedQueued => 'Queued transaction Submitted';
  @override
  String get ok => 'OK';
  @override
  String get pinNeeded => 'PIN is needed to use the app';
  @override
  String get settingNetwork => 'Select Wallet';
  @override
  String get submit => 'Sign and Submit';
  @override
  String get submitCall => 'Calling ';
  @override
  String get submitFees => 'Fees';
  @override
  String get submitFeesOffline => 'Fees unavailable (offline)';
  @override
  String get submitFrom => 'You are about to sign a transaction from ';
  @override
  String get submitNoSign => 'Submit (no sign)';
  @override
  String get submitQr => 'Sign via QR';
  @override
  String get submitTransaction => 'Submit Transaction';
  @override
  String get success => 'Success';
  @override
  String get switchAccount => 'Switch Account';
  @override
  String get switchCommunity => 'Switch Community';
  @override
  String get transactionQueued => 'Queued';
  @override
  String get transactionQueuedOffline =>
      'App is not connected to the blockchain. Queued transaction (will be sent automatically upon reconnection).';
  @override
  String get unlock => 'Unlock Account with PIN';
  @override
  String get unlockAccount => 'Unlock account CURRENT_ACCOUNT_NAME with PIN';
  @override
  String get updateDownload => 'Downloading...';
  @override
  String get updateError => 'Update Failed';
  @override
  String get updateJsUp => 'Metadata needs to be updated to continue.';
  @override
  String get updateLatest => 'Your App is the newest version.';
  @override
  String get updateToNewerVersionQ => 'New version found, update now?';
  @override
  String get accountImport => 'Import account';
  @override
  String get txQueued => 'Queued Transaction';
  @override
  String get txQueuedOffline => 'You are offline. Transaction will be sent when you are back online.';
  @override
  String get txReady => 'Transaction is ready.';
  @override
  String get txBroadcast => 'Transaction has been broadcast.';
  @override
  String get txInBlock => 'Transaction is in a block.';
  @override
  String get txError => 'Transaction error';
  @override
  String get updatingAppState => 'Updating the app state...';
  @override
  String get cameraPermissionError => 'There was an error String getting the camera permission. '
      'Alternatively, you can grant permission in the app settings.';
  @override
  String get appSettings => 'App settings';
}

class TranslationsDeHome implements TranslationsHome {
  @override
  String get cancel => 'Abbruch';
  @override
  String get closeApp => 'App schliessen';
  @override
  String get contacts => 'Kontakte';
  @override
  String get copy => 'In die Zwischenablage kopieren';
  @override
  String get create => 'Konto erstellen';
  @override
  String get detail => 'Detail';
  @override
  String get exitConfirm => 'Möchtest du die App verlassen?';
  @override
  String get errorOccurred => 'Es is ein Fehler aufgetaucht:';
  @override
  String get loading => 'Lädt...';
  @override
  String get next => 'Nächster Schritt';
  @override
  String get notifySubmitted => 'Transaktion eingereicht';
  @override
  String get notifySubmittedQueued => 'Die Transaktion in der Warteschlange wurde eingereicht';
  @override
  String get ok => 'OK';
  @override
  String get pinNeeded => 'PIN ist notwendig um die App zu benutzen';
  @override
  String get scan => 'Scannen';
  @override
  String get settingNetwork => 'Wähle ein Portemonnaie';
  @override
  String get submit => 'Signieren und senden';
  @override
  String get submitCall => 'Wird ausgeführt';
  @override
  String get submitFees => 'Gebühren';
  @override
  String get submitFeesOffline => 'Gebühren nicht verfügbar (offline)';
  @override
  String get submitFrom => 'Transaktion wird signiert von ';
  @override
  String get submitNoSign => 'Senden (ohne Signatur)';
  @override
  String get submitQr => 'Signieren via QR';
  @override
  String get submitTransaction => 'Transaktion senden';
  @override
  String get success => 'Erfolgreich';
  @override
  String get switchAccount => 'Konto wechseln';
  @override
  String get switchCommunity => 'Gemeinschaft wechseln';
  @override
  String get transactionQueued => 'In der Warteschlange';
  @override
  String get transactionQueuedOffline =>
      'Die App ist nicht mit der Blockchain verbunden. Die Transaktionen in der Warteschlange werden automatisch bei erfolgreicher Verbindung versendet.';
  @override
  String get unlock => 'Konto entsperren mit PIN';
  @override
  String get unlockAccount => 'Entsperre Konto CURRENT_ACCOUNT_NAME mit PIN';
  @override
  String get updateDownload => 'Herunterladen...';
  @override
  String get updateError => 'Update fehlgeschlagen';
  @override
  String get updateJsUp => 'Metadaten müssen aktualisiert werden um fortzusetzen.';
  @override
  String get updateLatest => 'Die App ist auf dem neusten Stand.';
  @override
  String get updateToNewerVersionQ => 'Neue Version gefunden, jetzt aktualisieren?';
  @override
  String get accountImport => 'Konto importieren';
  @override
  String get txQueued => 'Transaktion is in der Warteschlange';
  @override
  String get txQueuedOffline => 'Du bist offline. Die Transaktion wird geschickt, wenn du wieder online bist.';
  @override
  String get txReady => 'Transaktion bereit.';
  @override
  String get txBroadcast => 'Transaktion wurde im Netzwerk';
  @override
  String get txInBlock => 'Transaction ist in einem Block';
  @override
  String get txError => 'Transaktionsfehler';
  @override
  String get updatingAppState => 'App-Zustand wird aktualisiert...';
  @override
  String get cameraPermissionError => 'Es gab einen Fehler beim überprüfen der Kameraerlaubnis. '
      'Du kannst die Erlaubnis für die Kamera auch über die App-Einstellungen erteilen.';
  @override
  String get appSettings => 'App-Einstellungen';
}

class TranslationsFrHome implements TranslationsHome {
  @override
  String get cancel => throw UnimplementedError();
  @override
  String get scan => throw UnimplementedError();
  @override
  String get contacts => throw UnimplementedError();
  @override
  String get closeApp => throw UnimplementedError();
  @override
  String get copy => throw UnimplementedError();
  @override
  String get create => throw UnimplementedError();
  @override
  String get detail => throw UnimplementedError();
  @override
  String get exitConfirm => throw UnimplementedError();
  @override
  String get errorOccurred => throw UnimplementedError();
  @override
  String get loading => throw UnimplementedError();
  @override
  String get next => throw UnimplementedError();
  @override
  String get notifySubmitted => throw UnimplementedError();
  @override
  String get notifySubmittedQueued => throw UnimplementedError();
  @override
  String get ok => throw UnimplementedError();
  @override
  String get pinNeeded => throw UnimplementedError();
  @override
  String get settingNetwork => throw UnimplementedError();
  @override
  String get submit => throw UnimplementedError();
  @override
  String get submitCall => throw UnimplementedError();
  @override
  String get submitFees => throw UnimplementedError();
  @override
  String get submitFeesOffline => throw UnimplementedError();
  @override
  String get submitFrom => throw UnimplementedError();
  @override
  String get submitNoSign => throw UnimplementedError();
  @override
  String get submitQr => throw UnimplementedError();
  @override
  String get submitTransaction => throw UnimplementedError();
  @override
  String get success => throw UnimplementedError();
  @override
  String get switchAccount => throw UnimplementedError();
  @override
  String get switchCommunity => throw UnimplementedError();
  @override
  String get transactionQueued => throw UnimplementedError();
  @override
  String get transactionQueuedOffline => throw UnimplementedError();
  @override
  String get unlock => throw UnimplementedError();
  @override
  String get unlockAccount => throw UnimplementedError();
  @override
  String get updateDownload => throw UnimplementedError();
  @override
  String get updateError => throw UnimplementedError();
  @override
  String get updateJsUp => throw UnimplementedError();
  @override
  String get updateLatest => throw UnimplementedError();
  @override
  String get updateToNewerVersionQ => throw UnimplementedError();
  @override
  String get accountImport => throw UnimplementedError();
  @override
  String get txQueued => throw UnimplementedError();
  @override
  String get txQueuedOffline => throw UnimplementedError();
  @override
  String get txReady => throw UnimplementedError();
  @override
  String get txBroadcast => throw UnimplementedError();
  @override
  String get txInBlock => throw UnimplementedError();
  @override
  String get txError => throw UnimplementedError();
  @override
  String get updatingAppState => throw UnimplementedError();
  @override
  String get cameraPermissionError => throw UnimplementedError();
  @override
  String get appSettings => throw UnimplementedError();
}

class TranslationsRuHome implements TranslationsHome {
  @override
  String get cancel => 'Отмена';
  @override
  String get scan => 'Сканировать';
  @override
  String get contacts => 'Контакты';
  @override
  String get closeApp => 'Закрыть приложение';
  @override
  String get copy => 'Скопировать в буфер обмена';
  @override
  String get create => 'Создать аккаунт';
  @override
  String get detail => 'Детали';
  @override
  String get exitConfirm => 'Вы хотите покинуть приложение?';
  @override
  String get errorOccurred => 'Возникла ошибка:';
  @override
  String get loading => 'Загружается...';
  @override
  String get next => 'Следующий шаг';
  @override
  String get notifySubmitted => 'Транзакция отправлена';
  @override
  String get notifySubmittedQueued => 'Транзакция в очереди отправлена';
  @override
  String get ok => 'OK';
  @override
  String get pinNeeded => 'Для использования приложения необходим PIN-код';
  @override
  String get settingNetwork => 'Выберите кошелек';
  @override
  String get submit => 'Войти и отправить';
  @override
  String get submitCall => 'Сделать звонок';
  @override
  String get submitFees => 'Платеж';
  @override
  String get submitFeesOffline => 'Платеж недоступен (оффлайн)';
  @override
  String get submitFrom => 'Вы подписываете транзакцию от ';
  @override
  String get submitNoSign => 'Отправить (без подписи)';
  @override
  String get submitQr => 'Подписать через QR';
  @override
  String get submitTransaction => 'Отправить транзакцию';
  @override
  String get success => 'Успешно';
  @override
  String get switchAccount => 'Сменить аккаунт';
  @override
  String get switchCommunity => 'Сменить общину';
  @override
  String get transactionQueued => 'В очереди';
  @override
  String get transactionQueuedOffline =>
      'Приложение не подключено к блокчейну. Транзакция, которая в очереди (будет отправлена автоматически при подключении).';
  @override
  String get unlock => 'Разблокируйте учетную запись с помощью PIN-кода';
  @override
  String get unlockAccount => 'Разблокируйте учетную запись CURRENT_ACCOUNT_NAME с помощью PIN-кода';
  @override
  String get updateDownload => 'Загружается...';
  @override
  String get updateError => 'Не удалось загрузить обновление';
  @override
  String get updateJsUp => 'Чтобы продолжить, необходимо обновить метаданные.';
  @override
  String get updateLatest => 'Установлена новейшая версия приложения ';
  @override
  String get updateToNewerVersionQ => 'Доступна новая версия, обновить сейчас?';
  @override
  String get accountImport => 'Импортировать учетную запись';
  @override
  String get txQueued => 'Транзакция поставлена в очередь';
  @override
  String get txQueuedOffline =>
      'Вы находитесь в оффлайн режиме. Транзакция будет отправлена, когда вы снова подключитесь к сети.';
  @override
  String get txReady => 'Транзакция готова.';
  @override
  String get txBroadcast => 'Транзакция передана в эфир';
  @override
  String get txInBlock => 'Транзакция заблокирована';
  @override
  String get txError => 'Ошибка транзакции';
  @override
  String get updatingAppState => 'Обновление приложения';
  @override
  String get cameraPermissionError =>
      'Произошла ошибка при получении разрешения камеры. Вы можете предоставить разрешение в настройках приложения.';
  @override
  String get appSettings => 'Настройки приложения';
}
