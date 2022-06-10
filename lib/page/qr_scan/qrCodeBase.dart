import 'package:encointer_wallet/store/encointer/types/communities.dart';

/// Format of QR-code, (separator: newLine).
/// Values in `[]` are optional and will be empty lines in the QR-code.
///
/// encointer-<context>
/// <QR-version-for-context>
/// <account ss58>
/// [<cid>]
/// [<amount>]
/// [<label>]
///
class QrScanData {
  final QrCodeContext context;

  /// version of our format definition
  final String version;

  /// ss58 encoded public key of the account address.
  /// Payment: account of the receiver of the payment;
  /// contact: account to add to contacts;
  final String account;

  /// community identifier
  final CommunityIdentifier cid;

  /// Optional payment amount for the invoice. Will be emp
  final num amount;

  /// name or other identifier for `account`.
  final String label;

  QrScanData({this.context, this.version, this.account, this.cid, this.amount, this.label});
}

abstract class QrCode<QrCodeData> {

  QrCodeContext context;

  QrCodeVersion version;

  QrCodeData data;

  QrCode<QrCodeData> fromQrCodeString(String data);
}

/// context identifier e.g. encointer-contact
enum QrCodeContext {
  contact,
  invoice,
  voucher
  // claim, currently unsupported and might not be merged into this. Let's see.
}

enum QrCodeVersion {
  v1
}
