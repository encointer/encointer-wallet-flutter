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
  String get transferHistory;
  String get noTransactions;
  String get unknownError;
  String get openMapApplication;
  String get unRegisterDescriptoin;
  String get unRegister;
  String get unRegisterDialogTitle;
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
  @override
  String get noTransactions => 'No Transactions';
  @override
  String get transferHistory => 'Transactions';
  @override
  String get unknownError => 'Unknown Error';
  @override
  String get openMapApplication => 'Open Map Application';
  @override
  String get unRegister => 'Unregister';
  @override
  String get unRegisterDescriptoin =>
      'If you want to cancel your registration for the meeting, you can cancel it here.';
  @override
  String get unRegisterDialogTitle => 'Make sure you want to cancel the registration';
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
  @override
  String get noTransactions => 'Keine Transaktionen';
  @override
  String get transferHistory => 'Transaktionen';
  @override
  String get unknownError => 'Unbekannter Fehler';
  @override
  String get openMapApplication => 'In Karte öffnen';
  @override
  String get unRegister => 'Abmelden';
  @override
  String get unRegisterDescriptoin =>
      'Wenn Sie sich von der Veranstaltung abmelden möchten, können Sie sich hier abmelden.';
  @override
  String get unRegisterDialogTitle => 'Stellen Sie sicher, dass Sie die Anmeldung wirklich stornieren möchten.';
}

class TranslationsFrHome implements TranslationsHome {
  @override
  String get cancel => 'Annuler';
  @override
  String get scan => 'Scanner';
  @override
  String get contacts => 'Contacts';
  @override
  String get closeApp => "Fermer l'application";
  @override
  String get copy => 'Copier dans le presse-papiers';
  @override
  String get create => 'Créer un compte';
  @override
  String get detail => 'Détail';
  @override
  String get exitConfirm => "Tu veux quitter l'application?";
  @override
  String get errorOccurred => 'Une erreur est apparue:';
  @override
  String get loading => 'Chargement…';
  @override
  String get next => 'Prochaine étape';
  @override
  String get notifySubmitted => 'Transaction soumise';
  @override
  String get notifySubmittedQueued => "La transaction dans la file d'attente a été soumise";
  @override
  String get ok => 'OK';
  @override
  String get pinNeeded => "Le code NIP est nécessaire pour utiliser l'application";
  @override
  String get settingNetwork => 'Choisir un wallet';
  @override
  String get submit => 'Signer et envoyer';
  @override
  String get submitCall => 'Appelant';
  @override
  String get submitFees => 'Frais';
  @override
  String get submitFeesOffline => 'Frais non disponibles (hors ligne)';
  @override
  String get submitFrom => 'Transaction signée par';
  @override
  String get submitNoSign => 'Envoyer (sans signature)';
  @override
  String get submitQr => 'Signer par QR';
  @override
  String get submitTransaction => 'Envoyer la transaction';
  @override
  String get success => 'Réussite';
  @override
  String get switchAccount => 'Changer de compte';
  @override
  String get switchCommunity => 'Changer de communauté';
  @override
  String get transactionQueued => "Dans la file d'attente";
  @override
  String get transactionQueuedOffline =>
      "L'application n'est pas connectée à la blockchain. Les transactions dans la file d'attente sont envoyées automatiquement en cas de connexion réussie.";
  @override
  String get unlock => 'Débloquer le compte avec le code NIP.';
  @override
  String get unlockAccount => 'Débloquer le compte CURRENT_ACCOUNT_NAME avec un code NIP.';
  @override
  String get updateDownload => 'Téléchargement ...';
  @override
  String get updateError => 'Échec de la mise à jour';
  @override
  String get updateJsUp => 'Les métadonnées doivent être mises à jour pour pouvoir continuer.';
  @override
  String get updateLatest => "L'application est à jour.";
  @override
  String get updateToNewerVersionQ => 'Nouvelle version trouvée, mettre à jour maintenant?';
  @override
  String get accountImport => 'Importer un compte';
  @override
  String get txQueued => "La transaction est dans la file d'attente.";
  @override
  String get txQueuedOffline => 'Tu es hors ligne. La transaction sera envoyée lorsque tu seras en ligne.';
  @override
  String get txReady => 'La transaction est prête.';
  @override
  String get txBroadcast => 'La transaction a été envoyée sur le réseau';
  @override
  String get txInBlock => 'Transaction est dans un bloc';
  @override
  String get txError => 'Erreur de transaction';
  @override
  String get updatingAppState => "L'état de l'app est mis à jour...";
  @override
  String get cameraPermissionError =>
      "Une erreur s'est produite lors de la vérification de l'autorisation de la caméra "
      "Tu peux aussi donner l'autorisation pour la caméra via les paramètres de l'app.";
  @override
  String get appSettings => "Paramètres de l'app";
  @override
  String get noTransactions => 'Aucune transaction';
  @override
  String get transferHistory => 'Transactions';
  @override
  String get unknownError => 'Erreur inconnue';
  @override
  String get openMapApplication => "Ouvrer l'application de carte";
  @override
  String get unRegister => 'Se désinscrire';
  @override
  String get unRegisterDescriptoin =>
      'Si vous souhaitez annuler votre inscription à la réunion, vous pouvez vous désinscrire ici.';
  @override
  String get unRegisterDialogTitle => "Assurez-vous que vous voulez vraiment annuler l'inscription.";
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
  String get notifySubmittedQueued => 'Транзакция, в очереди, отправлена';
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
  String get switchCommunity => 'Сменить сообщество';
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
  String get cameraPermissionError => 'Произошла ошибка при получении разрешения камеры. '
      'Вы можете предоставить разрешение в настройках приложения.';
  @override
  String get appSettings => 'Настройки приложения';
  @override
  String get noTransactions => 'Нет транзакций';
  @override
  String get transferHistory => 'Транзакции';
  @override
  String get unknownError => 'Неизвестная ошибка';
  @override
  String get openMapApplication => 'Открыть приложение Карты';
  @override
  String get unRegister => 'Отменить регистрацию';
  @override
  String get unRegisterDescriptoin =>
      'Если вы хотите отменить свою регистрацию на встречу, вы можете отменить ее здесь.';
  @override
  String get unRegisterDialogTitle => 'Убедитесь, что вы действительно хотите отменить регистрацию';
}
