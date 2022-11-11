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
  String get address => 'Send to Address';
  @override
  String get amountError => 'Invalid amount';
  @override
  String get insufficientBalance => 'Insufficient balance';
  @override
  String get block => 'Block';
  @override
  String get communitiesNotFound => 'no communities found';
  @override
  String get communityChoose => 'Please choose a community';
  @override
  String get communityNotSelected => 'No community selected, hit the icon to select one';
  @override
  String get copy => 'Copy';
  @override
  String get detail => 'Detail';
  @override
  String get done => 'done';
  @override
  String get event => 'Event ID';
  @override
  String get fail => 'Failed';
  @override
  String get fee => 'Fee';
  @override
  String get from => 'From';
  @override
  String get hash => 'transaction hash';
  @override
  String get home => 'Home';
  @override
  String get issuanceClaimed => 'No pending community income';
  @override
  String get issuancePending => 'Claim pending community income';
  @override
  String get receive => 'Receive';
  @override
  String get scan => 'Scan';
  @override
  String get success => 'Success';
  @override
  String get tip => 'Tip';
  @override
  String get tipHint => 'Adding a tip to this transfer, paying the block author for greater priority.';
  @override
  String get to => 'To';
  @override
  String get transfer => 'Send';
  @override
  String get payment => 'Payment';
  @override
  String get value => 'Value';
  @override
  String get amountToBeTransferred => 'Send amount';
  @override
  String get invoiceAmount => 'Invoice amount';
  @override
  String get shareInvoice => 'Share Invoice';
  @override
  String get yourBalanceFor => 'Your balance, ACCOUNT_NAME';
  @override
  String get balance => 'Balance';
  @override
  String get invoice => 'Invoice';
  @override
  String get incomingConfirmed => 'incoming AMOUNT CID_SYMBOL for ACCOUNT_NAME confirmed';
  @override
  String get fundsReceived => 'funds received';
  @override
  String get paymentDoYouWantToProceed => 'Proceed with payment?';
  @override
  String get paymentSubmitting => 'Payment is being submitted...';
  @override
  String get paymentFinished => 'Payment complete';
  @override
  String get paymentError => 'Payment error';
  @override
  String get voucher => 'Voucher';
  @override
  String get voucherBalance => 'Voucher Balance';
  @override
  String get voucherDifferentNetworkAndCommunity => 'The voucher is for a different network. Do you want to change '
      'to NETWORK_PLACEHOLDER and COMMUNITY_PLACEHOLDER? You can change the network back under Profile > Developer mode';
  @override
  String get voucherDifferentCommunity =>
      'The voucher is for a different community. Do you want to change to COMMUNITY_PLACEHOLDER?';
  @override
  String get voucherContainsInexistentCommunity => 'The voucher contains an inexistent community:';
  @override
  String get doYouWantToRedeemThisVoucher => 'Do you want to redeem this voucher to ACCOUNT_PLACEHOLDER?';
  @override
  String get fundVoucher => 'Fund voucher';
  @override
  String get redeemVoucher => 'Redeem voucher';
  @override
  String get redeemSuccess => 'Successfully redeemed voucher.';
  @override
  String get redeemFailure => 'There was an error while redeeming the voucher. Cause:';
  @override
  String get invalidNetwork => 'Invalid Network';
  @override
  String get invalidCommunity => 'Invalid Community';
  @override
  String get transactionError => 'Transaction error';
  @override
  String get insufficientFundsExplanation =>
      'You do not have sufficient funds on this account. See on the website of your'
      ' local community how to get some.';
}

class TranslationsDeAssets implements TranslationsAssets {
  @override
  String get address => 'Sende an Adresse';
  @override
  String get amountError => 'Ungültiger Betrag';
  @override
  String get insufficientBalance => 'Ungenügender Saldo';
  @override
  String get block => 'Block';
  @override
  String get communitiesNotFound => 'Keine Community gefunden';
  @override
  String get communityChoose => 'Bitte wähle eine Community';
  @override
  String get communityNotSelected => 'Keine Community ausgewählt, klicke auf das Icon';
  @override
  String get copy => 'Kopiere';
  @override
  String get detail => 'Detail';
  @override
  String get done => 'Erledigt';
  @override
  String get event => 'Event ID';
  @override
  String get fail => 'Fehlgeschlagen';
  @override
  String get fee => 'Gebühr';
  @override
  String get from => 'Von';
  @override
  String get hash => 'Hash der Transaktion';
  @override
  String get home => 'Startbildschirm';
  @override
  String get issuanceClaimed => 'Kein ausstehendes Gemeinschaftseinkommen';
  @override
  String get issuancePending => 'Ausstehendes Gemeinschaftseinkommen einfordern';
  @override
  String get receive => 'Fordern';
  @override
  String get scan => 'Scannen';
  @override
  String get success => 'Erfolgreich';
  @override
  String get tip => 'Trinkgeld';
  @override
  String get tipHint => 'Trinkgeld für diese Transaktion hinzufügen, bezahle dem Block Author für höhere Priorität.';
  @override
  String get to => 'Nach';
  @override
  String get transfer => 'Senden';
  @override
  String get payment => 'Zahlung';
  @override
  String get value => 'Wert';
  @override
  String get amountToBeTransferred => 'Betrag';
  @override
  String get invoiceAmount => 'Rechnungsbetrag';
  @override
  String get shareInvoice => 'Teile als Rechnung';
  @override
  String get yourBalanceFor => 'Dein Kontostand, ACCOUNT_NAME';
  @override
  String get balance => 'Kontostand';
  @override
  String get invoice => 'Rechnungsbetrag';
  @override
  String get incomingConfirmed => 'Empfang von AMOUNT CID_SYMBOL für ACCOUNT_NAME bestätigt';
  @override
  String get fundsReceived => 'Zahlungseingang';
  @override
  String get paymentDoYouWantToProceed => 'Mit Zahlung fortfahren?';
  @override
  String get paymentSubmitting => 'Zahlung wird eingereicht...';
  @override
  String get paymentFinished => 'Zahlung erfolgt';
  @override
  String get paymentError => 'Zahlungsfehler';
  @override
  String get voucher => 'Gutschein';
  @override
  String get voucherBalance => 'Gutscheinwert';
  @override
  String get voucherDifferentNetworkAndCommunity => 'Der Gutschein ist für ein anderes Netzwerk. Wills du zu '
      'NETWORK_PLACEHOLDER und COMMUNITY_PLACEHOLDER wechseln? Du kannst das Netzwerk zurückändern under Profil > Developer mode.';
  @override
  String get voucherDifferentCommunity =>
      'Der Gutschein ist für eine andere Community. Wills du zu COMMUNITY_PLACEHOLDER wechseln?';
  @override
  String get voucherContainsInexistentCommunity => 'Der Gutschein enthält eine nicht-existente community:';
  @override
  String get doYouWantToRedeemThisVoucher => 'Willst du diesen Gutschein für ACCOUNT_PLACEHOLDER einlösen?';
  @override
  String get fundVoucher => 'Gutschein aufladen';
  @override
  String get redeemVoucher => 'Gutschein einlösen';
  @override
  String get redeemSuccess => 'Gutschein erfolgreich eingelöst.';
  @override
  String get redeemFailure => 'Es gab einen Fehler beim einlösen des Gutscheins. Ursache:';
  @override
  String get invalidNetwork => 'Ungültiges Netzwerk';
  @override
  String get invalidCommunity => 'Ungülige Gemeinschaft';
  @override
  String get transactionError => 'Transaktionsfehler';
  @override
  String get insufficientFundsExplanation => 'Du hast nicht genügend Geld auf diesem Konto. Schaue auf der Webseite'
      ' deiner lokalen gemeinschaft, wie du welches bekommen kannst.';
}

class TranslationsFrAssets implements TranslationsAssets {
  @override
  String get address => throw UnimplementedError();
  @override
  String get amountError => throw UnimplementedError();
  @override
  String get insufficientBalance => throw UnimplementedError();
  @override
  String get block => throw UnimplementedError();
  @override
  String get communitiesNotFound => throw UnimplementedError();
  @override
  String get communityChoose => throw UnimplementedError();
  @override
  String get communityNotSelected => throw UnimplementedError();
  @override
  String get copy => throw UnimplementedError();
  @override
  String get detail => throw UnimplementedError();
  @override
  String get done => throw UnimplementedError();
  @override
  String get event => throw UnimplementedError();
  @override
  String get fail => throw UnimplementedError();
  @override
  String get fee => throw UnimplementedError();
  @override
  String get from => throw UnimplementedError();
  @override
  String get hash => throw UnimplementedError();
  @override
  String get home => throw UnimplementedError();
  @override
  String get issuanceClaimed => throw UnimplementedError();
  @override
  String get issuancePending => throw UnimplementedError();
  @override
  String get receive => throw UnimplementedError();
  @override
  String get scan => throw UnimplementedError();
  @override
  String get success => throw UnimplementedError();
  @override
  String get tip => throw UnimplementedError();
  @override
  String get tipHint => throw UnimplementedError();
  @override
  String get to => throw UnimplementedError();
  @override
  String get transfer => throw UnimplementedError();
  @override
  String get payment => throw UnimplementedError();
  @override
  String get value => throw UnimplementedError();
  @override
  String get amountToBeTransferred => throw UnimplementedError();
  @override
  String get invoiceAmount => throw UnimplementedError();
  @override
  String get shareInvoice => throw UnimplementedError();
  @override
  String get yourBalanceFor => throw UnimplementedError();
  @override
  String get balance => throw UnimplementedError();
  @override
  String get invoice => throw UnimplementedError();
  @override
  String get incomingConfirmed => throw UnimplementedError();
  @override
  String get fundsReceived => throw UnimplementedError();
  @override
  String get paymentDoYouWantToProceed => throw UnimplementedError();
  @override
  String get paymentSubmitting => throw UnimplementedError();
  @override
  String get paymentFinished => throw UnimplementedError();
  @override
  String get paymentError => throw UnimplementedError();
  @override
  String get voucher => throw UnimplementedError();
  @override
  String get voucherBalance => throw UnimplementedError();
  @override
  String get voucherDifferentNetworkAndCommunity => throw UnimplementedError();
  @override
  String get voucherDifferentCommunity => throw UnimplementedError();
  @override
  String get voucherContainsInexistentCommunity => throw UnimplementedError();
  @override
  String get doYouWantToRedeemThisVoucher => throw UnimplementedError();
  @override
  String get fundVoucher => throw UnimplementedError();
  @override
  String get redeemVoucher => throw UnimplementedError();
  @override
  String get redeemSuccess => throw UnimplementedError();
  @override
  String get redeemFailure => throw UnimplementedError();
  @override
  String get invalidNetwork => throw UnimplementedError();
  @override
  String get invalidCommunity => throw UnimplementedError();
  @override
  String get transactionError => throw UnimplementedError();
  @override
  String get insufficientFundsExplanation => throw UnimplementedError();
}
