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
}

class TranslationsEnHome implements TranslationsHome {
  get cancel => 'Cancel';
  get scan => 'Scan';
  get contacts => 'Contacts';
  get closeApp => 'Close app';
  get copy => 'Copy to clipboard';
  get create => 'Create Account';
  get detail => 'Detail';
  get exitConfirm => 'Do you want to exit the App?';
  get inputInvalid => 'Invalid input';
  get loading => 'Loading...';
  get next => 'Next Step';
  get notifySubmitted => 'transaction Submitted';
  get notifySubmittedQueued => 'Queued transaction Submitted';
  get ok => 'OK';
  get pinNeeded => 'PIN is needed to use the app';
  get settingNetwork => 'Select Wallet';
  get submit => 'Sign and Submit';
  get submitCall => 'Calling ';
  get submitFees => 'Fees';
  get submitFeesOffline => 'Fees unavailable (offline)';
  get submitFrom => 'You are about to sign a transaction from ';
  get submitNoSign => 'Submit (no sign)';
  get submitQr => 'Sign via QR';
  get submitTransaction => 'Submit Transaction';
  get success => 'Success';
  get switchAccount => 'Switch Account';
  get transactionQueued => 'Queued';
  get transactionQueuedOffline =>
      'App is not connected to the blockchain. Queued transaction (will be sent automatically upon reconnection).';
  get unlock => 'Unlock Account with PIN';
  get unlockAccount => 'Unlock account CURRENT_ACCOUNT_NAME with PIN';
  get updateDownload => 'Downloading...';
  get updateError => 'Update Failed';
  get updateJsUp => 'Metadata needs to be updated to continue.';
  get updateLatest => 'Your App is the newest version.';
  get updateToNewerVersionQ => 'New version found, update now?';
  get accountImport => 'Import account';
}

class TranslationsDeHome implements TranslationsHome {
  get cancel => 'Abbruch';
  get closeApp => 'App schliessen';
  get contacts => 'Kontakte';
  get copy => 'In die Zwischenablage kopieren';
  get create => 'Konto erstellen';
  get detail => 'Detail';
  get exitConfirm => 'Möchtest du die App verlassen?';
  get loading => 'Lädt...';
  get next => 'Nächster Schritt';
  get notifySubmitted => 'Transaktion eingereicht';
  get notifySubmittedQueued => 'Die Transaktion in der Warteschlange wurde eingereicht';
  get ok => 'OK';
  get pinNeeded => 'PIN ist notwendig um die App zu benutzen';
  get scan => 'Scannen';
  get settingNetwork => 'Wähle ein Portemonnaie';
  get submit => 'Signieren und senden';
  get submitCall => 'Wird ausgeführt';
  get submitFees => 'Gebühren';
  get submitFeesOffline => 'Gebühren nicht verfügbar (offline)';
  get submitFrom => 'Transaktion wird signiert von ';
  get submitNoSign => 'Senden (ohne Signatur)';
  get submitQr => 'Signieren via QR';
  get submitTransaction => 'Transaktion senden';
  get success => 'Erfolgreich';
  get switchAccount => 'Konto wechseln';
  get transactionQueued => 'In der Warteschlange';
  get transactionQueuedOffline =>
      'Die App ist nicht mit der Blockchain verbunden. Die Transaktionen in der Warteschlange werden automatisch bei erfolgreicher Verbindung versendet.';
  get unlock => 'Konto entsperren mit PIN';
  get unlockAccount => 'Entsperre Konto CURRENT_ACCOUNT_NAME mit PIN';
  get updateDownload => 'Herunterladen...';
  get updateError => 'Update fehlgeschlagen';
  get updateJsUp => 'Metadaten müssen aktualisiert werden um fortzusetzen.';
  get updateLatest => 'Die App ist auf dem neusten Stand.';
  get updateToNewerVersionQ => 'Neue Version gefunden, jetzt aktualisieren?';
  get accountImport => 'Konto importieren';
}

class TranslationsZhHome implements TranslationsHome {
  get cancel => '取消';
  get scan => '扫描';
  get contacts => '联系人';
  get closeApp => '关闭应用程序';
  get copy => '复制到剪贴板';
  get create => '新建账户';
  get detail => '详情';
  get exitConfirm => '确定要退出 App 吗？';
  get loading => '载入中。。。';
  get next => '下一步';
  get notifySubmitted => '交易已打包完成';
  get notifySubmittedQueued => '已提交排队传输';
  get ok => '确认';
  get pinNeeded => '需要一个密码才能使用该应用程序';
  get settingNetwork => '选择钱包';
  get submit => '签名并发送';
  get submitCall => '调用 ';
  get submitFees => '交易费';
  get submitFeesOffline => '费用不可用（该应用程序处于离线状态）';
  get submitFrom => '你将使用以下账户发送交易：';
  get submitNoSign => '发送(不签名)';
  get submitQr => '二维码签名';
  get submitTransaction => '发送交易';
  get success => '操作成功';
  get switchAccount => '切换帐号';
  get transactionQueued => '已加入队列';
  get transactionQueuedOffline => '该应用程序未连接到区块链。 排队交易（将在重新连接时自动发送）';
  get unlock => '使用密码解锁账户';
  get unlockAccount => '使用 PIN 解锁帐户 CURRENT_ACCOUNT_NAME';
  get updateDownload => '正在下载...';
  get updateError => '更新失败';
  get updateJsUp => '发现网络 Metadata 更新，需要下载才能继续使用。';
  get updateLatest => '您的应用已是最新版本。';
  get updateToNewerVersionQ => '发现新版本，立即更新吗？';
  get accountImport => '导入账户';
}
