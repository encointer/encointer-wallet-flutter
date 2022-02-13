/// contains translations for Encointer
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsEncointer {
  String get registerParticipant;
  String get attestationsSubmit;
  String get ceremony;
  String get ceremonyNext;
  String get claimQr;
  String get claimsScanned;
  String get claimsScannedAlready;
  String get claimsScannedDecodeFailed;
  String get claimsScannedNew;
  String get claimsScannedNOfM;
  String get claimsSubmitDetail;
  String get communities;
  String get done;
  String get encointer;
  String get encointerRegistering;
  String get faucetBrief;
  String get faucetError;
  String get faucetInsufficientBalance;
  String get faucetLimit;
  String get faucetOk;
  String get faucetTitle;
  String get faucetTry;
  String get finish;
  String get loanTxs;
  String get meetupAttended;
  String get meetupClaimantInvalid;
  String get meetupNotAssigned;
  String get meetupRemaining;
  String get meetupStart;
  String get registered;
  String get scan;
  String get txsAction;
}

class TranslationsEnEncointer implements TranslationsEncointer {
  get registerParticipant => 'Register Participant';
  get attestationsSubmit => 'Submit attestations';
  get ceremony => 'Encointer Ceremony';
  get ceremonyNext => 'Next ceremony will happen at high sun on:';
  get claimQr => 'My Claim of Attendance';
  get claimsScanned => 'You have scanned AMOUNT_PLACEHOLDER claims';
  get claimsScannedAlready => 'Updated previously scanned claim';
  get claimsScannedDecodeFailed => 'Could not decode scanned claim.';
  get claimsScannedNew => 'Scanned new claim';
  get claimsScannedNOfM => "Scanned SCANNED_COUNT / TOTAL_COUNT Claims";
  get claimsSubmitDetail => 'Submitting AMOUNT claims for the recent ceremony';
  get communities => 'Communities';
  get done => 'Done';
  get encointer => 'Encointer Ceremony';
  get encointerRegistering => 'Registering';
  get faucetBrief => 'Get test Tokens Encointer testnet.';
  get faucetError => 'Request error, try again later.';
  get faucetInsufficientBalance => 'Faucet has run out of funds. Please notify the administrator';
  get faucetLimit => 'You have enough funds, you don\'t need the faucet';
  get faucetOk => 'Test Tokens were sent.';
  get faucetTitle => 'Faucet';
  get faucetTry => 'Try the faucet to get your new account started with some funds!';
  get finish => 'Finish';
  get loanTxs => 'History';
  get meetupAttended => 'Attended last meetup';
  get meetupClaimantInvalid => 'This claimant is not part of the meetup. Claim is not stored.';
  get meetupNotAssigned => 'You are not assigned to a meetup';
  get meetupRemaining => 'Time to meetup:';
  get meetupStart => 'start meetup';
  get registered => 'Already Registered';
  get scan => 'Scan';
  get txsAction => 'Action';
}

class TranslationsDeEncointer implements TranslationsEncointer {
  get registerParticipant => 'Registeriere Teilnehmer';
  get attestationsSubmit => 'Anwesenheit einreichen';
  get ceremony => 'Encointer Zeremonie';
  get ceremonyNext => 'Nächste Zeremonie findet statt am Mittag am:';
  get claimQr => 'Meine Behauptung der Anwesenheit';
  get claimsScanned => 'Du hast AMOUNT_PLACEHOLDER Behauptungen gescannt';
  get claimsScannedAlready => 'Letzte gescannte Behauptung wurde aktualisiert';
  get claimsScannedDecodeFailed => 'Gescannte Behauptung konnte nicht dekodiert werden.';
  get claimsScannedNew => 'Neue Behauptung gescannt';
  get claimsScannedNOfM => "SCANNED_COUNT / TOTAL_COUNT gescannte Behauptungen";
  get claimsSubmitDetail => 'Reiche AMOUNT Behauptungen für die letzte Zeremonie ein';
  get communities => 'Communities';
  get done => 'Fertig';
  get encointer => 'Encointer Zeremonie';
  get encointerRegistering => 'Registriert...';
  get faucetBrief => 'Erhalte test Tokens Encointer testnet.';
  get faucetError => 'Fehler bei der Anfrage, versuche später erneut.';
  get faucetInsufficientBalance => 'Das Faucet ist leer. Bitte benachrichtige den Administrator';
  get faucetLimit => 'Du hast genügend Kapital, du brauchst das Faucet nicht';
  get faucetOk => 'Test Tokens wurden versendet.';
  get faucetTitle => 'Faucet';
  get faucetTry => 'Nutze das Faucet um dein Konto mit einem Startkapital zu versehen!';
  get finish => 'Abschliessen';
  get loanTxs => 'History';
  get meetupAttended => 'Am letzen Treffen teilgenommen';
  get meetupClaimantInvalid => 'Dieser Antragssteller gehört nicht zum Treffen. Behauptung wurde nicht gespeichert.';
  get meetupNotAssigned => 'Du wurdest keinem Treffen zugewiesen';
  get meetupRemaining => 'Zeit bis zum Treffen:';
  get meetupStart => 'Treffen starten';
  get registered => 'Bereits registriert';
  get scan => 'Scan';
  get txsAction => 'Aktion';
}

class TranslationsZhEncointer implements TranslationsEncointer {
  get registerParticipant => '注册参与者';
  get attestationsSubmit => '提交证明';
  get ceremony => 'Encointer 仪式';
  get ceremonyNext => '下一个仪式将在烈日下举行：';
  get claimQr => '我的出席声明';
  get claimsScanned => '您已扫描 AMOUNT_PLACEHOLDER 声明';
  get claimsScannedAlready => '更新了之前扫描的声明';
  get claimsScannedDecodeFailed => '无法解码扫描的声明。';
  get claimsScannedNew => '扫描的新声​​明';
  get claimsScannedNOfM => "扫描的 SCANNED_COUNT / TOTAL_COUNT 个索赔";
  get claimsSubmitDetail => '为最近的仪式提交 AMOUNT 索赔';
  get done => '完成';
  get encointer => 'Encointer 仪式';
  get encointerRegistering => '注册中';
  get faucetBrief => '获取测试令牌 Encointer 测试网。';
  get faucetError => '请求错误，稍后再试。';
  get faucetInsufficientBalance => 'Faucet 资金已用完。请通知管理员';
  get faucetLimit => '你有足够的资金，你不需要水龙头';
  get faucetOk => '测试令牌已发送。';
  get faucetTitle => '水龙头';
  get faucetTry => '试试水龙头，让你的新帐户开始使用一些资金！';
  get finish => '完成';
  get loanTxs => '历史';
  get meetupAttended => '参加了上次聚会';
  get meetupClaimantInvalid => '此索赔人不是聚会的一部分。声明未存储。';
  get meetupNotAssigned => '你没有被分配到一个聚会';
  get meetupRemaining => '聚会时间：';
  get meetupStart => '开始聚会';
  get registered => '已经注册';
  get scan => '扫描';
  get txsAction => '动作';

  @override
  // TODO: implement communities
  String get communities => throw UnimplementedError();
}
