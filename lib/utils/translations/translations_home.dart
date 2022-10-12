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
  String get restart;
  String get restartDes;
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
  get inputInvalid => 'Invalid input';
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
  @override
  String get restartDes => 'According to some operations we recommend you to restart the application.';
  @override
  String get restart => 'Do you want to restart App?';
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
  @override
  String get restart => 'Möchten Sie die App neu starten?';
  @override
  String get restartDes => 'Bei einigen Vorgängen empfehlen wir Ihnen, die Anwendung neu zu starten.';
}

class TranslationsZhHome implements TranslationsHome {
  @override
  get cancel => '取消';
  @override
  get scan => '扫描';
  @override
  get contacts => '联系人';
  @override
  get closeApp => '关闭应用程序';
  @override
  get copy => '复制到剪贴板';
  @override
  get create => '新建账户';
  @override
  get detail => '详情';
  @override
  get exitConfirm => '确定要退出 App 吗？';
  @override
  get errorOccurred => throw UnimplementedError();
  @override
  get loading => '载入中。。。';
  @override
  get next => '下一步';
  @override
  get notifySubmitted => '交易已打包完成';
  @override
  get notifySubmittedQueued => '已提交排队传输';
  @override
  get ok => '确认';
  @override
  get pinNeeded => '需要一个密码才能使用该应用程序';
  @override
  get settingNetwork => '选择钱包';
  @override
  get submit => '签名并发送';
  @override
  get submitCall => '调用 ';
  @override
  get submitFees => '交易费';
  @override
  get submitFeesOffline => '费用不可用（该应用程序处于离线状态）';
  @override
  get submitFrom => '你将使用以下账户发送交易：';
  @override
  get submitNoSign => '发送(不签名)';
  @override
  get submitQr => '二维码签名';
  @override
  get submitTransaction => '发送交易';
  @override
  get success => '操作成功';
  @override
  get switchAccount => '切换帐号';
  @override
  get switchCommunity => throw UnimplementedError();
  @override
  get transactionQueued => '已加入队列';
  @override
  get transactionQueuedOffline => '该应用程序未连接到区块链。 排队交易（将在重新连接时自动发送）';
  @override
  get unlock => '使用密码解锁账户';
  @override
  get unlockAccount => '使用 PIN 解锁帐户 CURRENT_ACCOUNT_NAME';
  @override
  get updateDownload => '正在下载...';
  @override
  get updateError => '更新失败';
  @override
  get updateJsUp => '发现网络 Metadata 更新，需要下载才能继续使用。';
  @override
  get updateLatest => '您的应用已是最新版本。';
  @override
  get updateToNewerVersionQ => '发现新版本，立即更新吗？';
  @override
  get accountImport => '导入账户';
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
  @override
  String get restart => '是否要重新啟動應用程序？';
  @override
  String get restartDes => '根據某些操作，我們建議您重新啟動應用程序。';
}
