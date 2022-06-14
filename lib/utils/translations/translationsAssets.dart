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
}

class TranslationsEnAssets implements TranslationsAssets {
  get address => 'Send to Address';
  get amountError => 'Invalid amount';
  get insufficientBalance => 'Insufficient balance';
  get block => 'Block';
  get communitiesNotFound => 'no communities found';
  get communityChoose => 'Please choose a community';
  get communityNotSelected => 'No community selected, hit the icon to select one';
  get copy => 'Copy';
  get detail => 'Detail';
  get done => 'done';
  get event => 'Event ID';
  get fail => 'Failed';
  get fee => 'Fee';
  get from => 'From';
  get hash => 'transaction hash';
  get home => 'Home';
  get issuanceClaimed => 'No pending community income';
  get issuancePending => 'Claim pending community income';
  get receive => 'Receive';
  get scan => 'Scan';
  get success => 'Success';
  get tip => 'Tip';
  get tipHint => 'Adding a tip to this transfer, paying the block author for greater priority.';
  get to => 'To';
  get transfer => 'Send';
  get payment => 'Payment';
  get value => 'Value';
  get amountToBeTransferred => 'Send amount';
  get invoiceAmount => 'Invoice amount';
  get shareInvoice => 'Share Invoice';
  get yourBalanceFor => 'Your balance, ACCOUNT_NAME';
  get balance => 'Balance';
  get invoice => 'Invoice';
  get incomingConfirmed => 'incoming AMOUNT CID_SYMBOL for ACCOUNT_NAME confirmed';
  get fundsReceived => 'funds received';
  get paymentDoYouWantToProceed => "Proceed with payment?";
  get paymentSubmitting => "Payment is being submitted...";
  get paymentFinished => "Payment complete";
  get paymentError => "Payment error";
  get voucher => "Voucher";
  get voucherBalance => "Voucher Balance";
  get voucherDifferentNetworkAndCommunity => "The voucher is for a different network. Do you want to change "
      "to NETWORK_PLACEHOLDER and COMMUNITY_PLACEHOLDER? You can change the network back under Profile > Developer mode";
  get voucherDifferentCommunity =>
      "The voucher is for a different community. Do you want to change to COMMUNITY_PLACEHOLDER?";
  get voucherContainsInexistentCommunity => "The voucher contains an inexistent community:";
  get doYouWantToRedeemThisVoucher => "Do you want to redeem this voucher to ACCOUNT_PLACEHOLDER?";
  get fundVoucher => "Fund voucher";
  get redeemVoucher => "Redeem voucher";
  get redeemSuccess => "Successfully redeemed voucher.";
  get redeemFailure => "There was an error while redeeming the voucher. Cause:";
  get invalidNetwork => "Invalid Network";
  get invalidCommunity => "Invalid Community";
}

class TranslationsDeAssets implements TranslationsAssets {
  get address => 'Sende an Adresse';
  get amountError => 'Ungültiger Betrag';
  get insufficientBalance => 'Ungenügender Saldo';
  get block => 'Block';
  get communitiesNotFound => 'Keine Community gefunden';
  get communityChoose => 'Bitte wähle eine Community';
  get communityNotSelected => 'Keine Community ausgewählt, klicke auf das Icon';
  get copy => 'Kopiere';
  get detail => 'Detail';
  get done => 'Erledigt';
  get event => 'Event ID';
  get fail => 'Fehlgeschlagen';
  get fee => 'Gebühr';
  get from => 'Von';
  get hash => 'Hash der Transaktion';
  get home => 'Startbildschirm';
  get issuanceClaimed => 'Kein ausstehendes Gemeinschaftseinkommen';
  get issuancePending => 'Ausstehendes Gemeinschaftseinkommen einfordern';
  get receive => 'Fordern';
  get scan => 'Scannen';
  get success => 'Erfolgreich';
  get tip => 'Trinkgeld';
  get tipHint => 'Trinkgeld für diese Transaktion hinzufügen, bezahle dem Block Author für höhere Priorität.';
  get to => 'Nach';
  get transfer => 'Senden';
  get payment => 'Zahlung';
  get value => 'Wert';
  get amountToBeTransferred => 'Betrag';
  get invoiceAmount => 'Rechnungsbetrag';
  get shareInvoice => 'Teile als Rechnung';
  get yourBalanceFor => 'Dein Kontostand, ACCOUNT_NAME';
  get balance => 'Kontostand';
  get invoice => 'Rechnungsbetrag';
  get incomingConfirmed => 'Empfang von AMOUNT CID_SYMBOL für ACCOUNT_NAME bestätigt';
  get fundsReceived => 'Zahlungseingang';
  get paymentDoYouWantToProceed => "Mit Zahlung fortfahren?";
  get paymentSubmitting => "Zahlung wird eingereicht...";
  get paymentFinished => "Zahlung erfolgt";
  get paymentError => "Zahlungsfehler";
  get voucher => "Gutschein";
  get voucherBalance => "Gutscheinwert";
  get voucherDifferentNetworkAndCommunity => "Der Gutschein ist für ein anderes Netzwerk. Wills du zu "
      "NETWORK_PLACEHOLDER und COMMUNITY_PLACEHOLDER wechseln? Du kannst das Netzwerk zurückändern under Profil > Developer mode.";
  get voucherDifferentCommunity =>
      "Der Gutschein ist für eine andere Community. Wills du zu COMMUNITY_PLACEHOLDER wechseln?";
  get voucherContainsInexistentCommunity => "Der Gutschein enthält eine nicht-existente community:";
  get doYouWantToRedeemThisVoucher => "Willst du diesen Gutschein für ACCOUNT_PLACEHOLDER einlösen?";
  get fundVoucher => "Gutschein aufladen";
  get redeemVoucher => "Gutschein einlösen";
  get redeemSuccess => "Gutschein erfolgreich eingelöst.";
  get redeemFailure => "Es gab einen Fehler beim einlösen des Gutscheins. Ursache:";
  get invalidNetwork => "Ungültiges Netzwerk";
  get invalidCommunity => "Ungülige Gemeinschaft";
}

class TranslationsZhAssets implements TranslationsAssets {
  get address => '收款地址';
  get amountError => '格式错误';
  get insufficientBalance => '余额不足';
  get block => '区块';
  get communitiesNotFound => '没有找到社区';
  get communityChoose => '选择币种';
  get communityNotSelected => '未选择社区，点击图标选择一个';
  get copy => '复制';
  get detail => '详情';
  get done => '完成';
  get event => '交易ID';
  get fail => '失败';
  get fee => '手续费';
  get from => '付款地址';
  get hash => '交易Hash';
  get home => '家';
  get issuanceClaimed => '没有待处理的社区收入';
  get issuancePending => '申领待处理的社区收入';
  get receive => '收款';
  get scan => '扫描';
  get success => '成功';
  get tip => '小费';
  get tipHint => '为出块人支付额外的费用，可以提高交易打包优先级。';
  get to => '收款地址';
  get transfer => '转账';
  get payment => throw UnimplementedError();
  get value => '金额';
  get amountToBeTransferred => '发票金额';
  get invoiceAmount => '发票金额';
  get shareInvoice => '分享二维码';
  get yourBalanceFor => '你的余额';
  get balance => throw UnimplementedError();
  get invoice => throw UnimplementedError();
  get incomingConfirmed => throw UnimplementedError();
  get fundsReceived => throw UnimplementedError();
  get paymentDoYouWantToProceed => throw UnimplementedError();
  get paymentSubmitting => throw UnimplementedError();
  get paymentFinished => throw UnimplementedError();
  get paymentError => throw UnimplementedError();
  get voucher => throw UnimplementedError();
  get voucherBalance => throw UnimplementedError();
  get voucherDifferentNetworkAndCommunity => throw UnimplementedError();
  get voucherDifferentCommunity => throw UnimplementedError();
  get voucherContainsInexistentCommunity => throw UnimplementedError();
  get doYouWantToRedeemThisVoucher => throw UnimplementedError();
  get fundVoucher => throw UnimplementedError();
  get redeemVoucher => throw UnimplementedError();
  get redeemSuccess => throw UnimplementedError();
  get redeemFailure => throw UnimplementedError();
  get invalidNetwork => throw UnimplementedError();
  get invalidCommunity => throw UnimplementedError();
}
