/// contains translations for Assets
/// always add a new getter here in the abstract class first, then generate/implement the getters in the subclasses
abstract class TranslationsAssets {
  String get address;
  String get amountError;
  String get insufficientBalance;
  String get block;
  String get communitiesNotFound;
  String get communityChoose;
  String get communityNotSelected;
  String get copy;
  String get detail;
  String get done;
  String get event;
  String get fail;
  String get fee;
  String get from;
  String get hash;
  String get home;
  String get issuanceClaimed;
  String get issuancePending;
  String get receive;
  String get scan;
  String get success;
  String get tip;
  String get tipHint;
  String get to;
  String get transfer;
  String get payment;
  String get value;
  String get amountToBeTransferred;
  String get invoiceAmount;
  String get shareInvoice;
  String get yourBalanceFor;
  String get balance;
  String get invoice;
  String get incomingConfirmed;
  String get fundsReceived;
  String get paymentDoYouWantToProceed;
  String get paymentSubmitting;
  String get paymentFinished;
  String get paymentError;
  String get voucher;
  String get voucherBalance;
  String get voucherDifferentNetworkAndCommunity;
  String get voucherDifferentCommunity;
  String get voucherContainsInexistentCommunity;
  String get doYouWantToRedeemThisVoucher;
  String get fundVoucher;
  String get redeemVoucher;
  String get redeemSuccess;
  String get redeemFailure;
  String get invalidNetwork;
  String get invalidCommunity;
  String get transactionError;
  String get insufficientFundsExplanation;
}

class TranslationsEnAssets implements TranslationsAssets {
  @override
  get address => 'Send to Address';
  @override
  get amountError => 'Invalid amount';
  @override
  get insufficientBalance => 'Insufficient balance';
  @override
  get block => 'Block';
  @override
  get communitiesNotFound => 'no communities found';
  @override
  get communityChoose => 'Please choose a community';
  @override
  get communityNotSelected => 'No community selected, hit the icon to select one';
  @override
  get copy => 'Copy';
  @override
  get detail => 'Detail';
  @override
  get done => 'done';
  @override
  get event => 'Event ID';
  @override
  get fail => 'Failed';
  @override
  get fee => 'Fee';
  @override
  get from => 'From';
  @override
  get hash => 'transaction hash';
  @override
  get home => 'Home';
  @override
  get issuanceClaimed => 'No pending community income';
  @override
  get issuancePending => 'Claim pending community income';
  @override
  get receive => 'Receive';
  @override
  get scan => 'Scan';
  @override
  get success => 'Success';
  @override
  get tip => 'Tip';
  @override
  get tipHint => 'Adding a tip to this transfer, paying the block author for greater priority.';
  @override
  get to => 'To';
  @override
  get transfer => 'Send';
  @override
  get payment => 'Payment';
  @override
  get value => 'Value';
  @override
  get amountToBeTransferred => 'Send amount';
  @override
  get invoiceAmount => 'Invoice amount';
  @override
  get shareInvoice => 'Share Invoice';
  @override
  get yourBalanceFor => 'Your balance, ACCOUNT_NAME';
  @override
  get balance => 'Balance';
  @override
  get invoice => 'Invoice';
  @override
  get incomingConfirmed => 'incoming AMOUNT CID_SYMBOL for ACCOUNT_NAME confirmed';
  @override
  get fundsReceived => 'funds received';
  @override
  get paymentDoYouWantToProceed => 'Proceed with payment?';
  @override
  get paymentSubmitting => 'Payment is being submitted...';
  @override
  get paymentFinished => 'Payment complete';
  @override
  get paymentError => 'Payment error';
  @override
  get voucher => 'Voucher';
  @override
  get voucherBalance => 'Voucher Balance';
  @override
  get voucherDifferentNetworkAndCommunity => 'The voucher is for a different network. Do you want to change '
      'to NETWORK_PLACEHOLDER and COMMUNITY_PLACEHOLDER? You can change the network back under Profile > Developer mode';
  @override
  get voucherDifferentCommunity =>
      'The voucher is for a different community. Do you want to change to COMMUNITY_PLACEHOLDER?';
  @override
  get voucherContainsInexistentCommunity => 'The voucher contains an inexistent community:';
  @override
  get doYouWantToRedeemThisVoucher => 'Do you want to redeem this voucher to ACCOUNT_PLACEHOLDER?';
  @override
  get fundVoucher => 'Fund voucher';
  @override
  get redeemVoucher => 'Redeem voucher';
  @override
  get redeemSuccess => 'Successfully redeemed voucher.';
  @override
  get redeemFailure => 'There was an error while redeeming the voucher. Cause:';
  @override
  get invalidNetwork => 'Invalid Network';
  @override
  get invalidCommunity => 'Invalid Community';
  @override
  get transactionError => 'Transaction error';
  @override
  get insufficientFundsExplanation => 'You do not have sufficient funds on this account. See on the website of your'
      ' local community how to get some.';
}

class TranslationsDeAssets implements TranslationsAssets {
  @override
  get address => 'Sende an Adresse';
  @override
  get amountError => 'Ungültiger Betrag';
  @override
  get insufficientBalance => 'Ungenügender Saldo';
  @override
  get block => 'Block';
  @override
  get communitiesNotFound => 'Keine Community gefunden';
  @override
  get communityChoose => 'Bitte wähle eine Community';
  @override
  get communityNotSelected => 'Keine Community ausgewählt, klicke auf das Icon';
  @override
  get copy => 'Kopiere';
  @override
  get detail => 'Detail';
  @override
  get done => 'Erledigt';
  @override
  get event => 'Event ID';
  @override
  get fail => 'Fehlgeschlagen';
  @override
  get fee => 'Gebühr';
  @override
  get from => 'Von';
  @override
  get hash => 'Hash der Transaktion';
  @override
  get home => 'Startbildschirm';
  @override
  get issuanceClaimed => 'Kein ausstehendes Gemeinschaftseinkommen';
  @override
  get issuancePending => 'Ausstehendes Gemeinschaftseinkommen einfordern';
  @override
  get receive => 'Fordern';
  @override
  get scan => 'Scannen';
  @override
  get success => 'Erfolgreich';
  @override
  get tip => 'Trinkgeld';
  @override
  get tipHint => 'Trinkgeld für diese Transaktion hinzufügen, bezahle dem Block Author für höhere Priorität.';
  @override
  get to => 'Nach';
  @override
  get transfer => 'Senden';
  @override
  get payment => 'Zahlung';
  @override
  get value => 'Wert';
  @override
  get amountToBeTransferred => 'Betrag';
  @override
  get invoiceAmount => 'Rechnungsbetrag';
  @override
  get shareInvoice => 'Teile als Rechnung';
  @override
  get yourBalanceFor => 'Dein Kontostand, ACCOUNT_NAME';
  @override
  get balance => 'Kontostand';
  @override
  get invoice => 'Rechnungsbetrag';
  @override
  get incomingConfirmed => 'Empfang von AMOUNT CID_SYMBOL für ACCOUNT_NAME bestätigt';
  @override
  get fundsReceived => 'Zahlungseingang';
  @override
  get paymentDoYouWantToProceed => 'Mit Zahlung fortfahren?';
  @override
  get paymentSubmitting => 'Zahlung wird eingereicht...';
  @override
  get paymentFinished => 'Zahlung erfolgt';
  @override
  get paymentError => 'Zahlungsfehler';
  @override
  get voucher => 'Gutschein';
  @override
  get voucherBalance => 'Gutscheinwert';
  @override
  get voucherDifferentNetworkAndCommunity => 'Der Gutschein ist für ein anderes Netzwerk. Wills du zu '
      'NETWORK_PLACEHOLDER und COMMUNITY_PLACEHOLDER wechseln? Du kannst das Netzwerk zurückändern under Profil > Developer mode.';
  @override
  get voucherDifferentCommunity =>
      'Der Gutschein ist für eine andere Community. Wills du zu COMMUNITY_PLACEHOLDER wechseln?';
  @override
  get voucherContainsInexistentCommunity => 'Der Gutschein enthält eine nicht-existente community:';
  @override
  get doYouWantToRedeemThisVoucher => 'Willst du diesen Gutschein für ACCOUNT_PLACEHOLDER einlösen?';
  @override
  get fundVoucher => 'Gutschein aufladen';
  @override
  get redeemVoucher => 'Gutschein einlösen';
  @override
  get redeemSuccess => 'Gutschein erfolgreich eingelöst.';
  @override
  get redeemFailure => 'Es gab einen Fehler beim einlösen des Gutscheins. Ursache:';
  @override
  get invalidNetwork => 'Ungültiges Netzwerk';
  @override
  get invalidCommunity => 'Ungülige Gemeinschaft';
  @override
  get transactionError => 'Transaktionsfehler';
  @override
  get insufficientFundsExplanation => 'Du hast nicht genügend Geld auf diesem Konto. Schaue auf der Webseite'
      ' deiner lokalen gemeinschaft, wie du welches bekommen kannst.';
}

class TranslationsZhAssets implements TranslationsAssets {
  @override
  get address => '收款地址';
  @override
  get amountError => '格式错误';
  @override
  get insufficientBalance => '余额不足';
  @override
  get block => '区块';
  @override
  get communitiesNotFound => '没有找到社区';
  @override
  get communityChoose => '选择币种';
  @override
  get communityNotSelected => '未选择社区，点击图标选择一个';
  @override
  get copy => '复制';
  @override
  get detail => '详情';
  @override
  get done => '完成';
  @override
  get event => '交易ID';
  @override
  get fail => '失败';
  @override
  get fee => '手续费';
  @override
  get from => '付款地址';
  @override
  get hash => '交易Hash';
  @override
  get home => '家';
  @override
  get issuanceClaimed => '没有待处理的社区收入';
  @override
  get issuancePending => '申领待处理的社区收入';
  @override
  get receive => '收款';
  @override
  get scan => '扫描';
  @override
  get success => '成功';
  @override
  get tip => '小费';
  @override
  get tipHint => '为出块人支付额外的费用，可以提高交易打包优先级。';
  @override
  get to => '收款地址';
  @override
  get transfer => '转账';
  @override
  get payment => throw UnimplementedError();
  @override
  get value => '金额';
  @override
  get amountToBeTransferred => '发票金额';
  @override
  get invoiceAmount => '发票金额';
  @override
  get shareInvoice => '分享二维码';
  @override
  get yourBalanceFor => '你的余额';
  @override
  get balance => throw UnimplementedError();
  @override
  get invoice => throw UnimplementedError();
  @override
  get incomingConfirmed => throw UnimplementedError();
  @override
  get fundsReceived => throw UnimplementedError();
  @override
  get paymentDoYouWantToProceed => throw UnimplementedError();
  @override
  get paymentSubmitting => throw UnimplementedError();
  @override
  get paymentFinished => throw UnimplementedError();
  @override
  get paymentError => throw UnimplementedError();
  @override
  get voucher => throw UnimplementedError();
  @override
  get voucherBalance => throw UnimplementedError();
  @override
  get voucherDifferentNetworkAndCommunity => throw UnimplementedError();
  @override
  get voucherDifferentCommunity => throw UnimplementedError();
  @override
  get voucherContainsInexistentCommunity => throw UnimplementedError();
  @override
  get doYouWantToRedeemThisVoucher => throw UnimplementedError();
  @override
  get fundVoucher => throw UnimplementedError();
  @override
  get redeemVoucher => throw UnimplementedError();
  @override
  get redeemSuccess => throw UnimplementedError();
  @override
  get redeemFailure => throw UnimplementedError();
  @override
  get invalidNetwork => throw UnimplementedError();
  @override
  get invalidCommunity => throw UnimplementedError();
  @override
  get transactionError => throw UnimplementedError();
  @override
  get insufficientFundsExplanation => throw UnimplementedError();
}
