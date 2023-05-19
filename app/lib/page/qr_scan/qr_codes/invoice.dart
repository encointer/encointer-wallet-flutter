import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/qr_code_base.dart';

class InvoiceQrCode extends QrCode<InvoiceData> {
  InvoiceQrCode({
    required String account,
    CommunityIdentifier? cid,
    String? network,
    num? amount,
    required String label,
    this.qrCodeVersion = QrCodeVersion.v1_0,
  }) : super(InvoiceData(account: account, cid: cid, network: network, amount: amount, label: label));

  factory InvoiceQrCode.fromPayload(String payload) {
    return InvoiceQrCode.fromQrFields(payload.split('\n'));
  }

  factory InvoiceQrCode.fromQrFields(List<String> fields) {
    if (QrCodeVersionExt.fromQrField(fields[1]) == QrCodeVersion.v1_0) {
      return InvoiceQrCode.withData(InvoiceData.fromQrFieldsV1(fields.sublist(2)));
    } else {
      return InvoiceQrCode.withData(
        InvoiceData.fromQrFieldsV2(fields.sublist(2)),
        qrCodeVersion: QrCodeVersion.v2_0,
      );
    }
  }

  InvoiceQrCode.withData(super.data, {this.qrCodeVersion = QrCodeVersion.v1_0});

  final QrCodeVersion qrCodeVersion;

  @override
  String toQrPayload() {
    final qrFields = [context.toQrField(), version.toVersionNumber()];
    if (version == QrCodeVersion.v1_0) {
      qrFields.addAll(data.toQrFields());
    } else {
      qrFields.addAll(data.toQrFieldsV2());
    }
    return qrFields.join(qrCodeFieldSeparator);
  }

  @override
  QrCodeContext get context => QrCodeContext.invoice;

  @override
  QrCodeVersion get version => qrCodeVersion;
}

class InvoiceData implements ToQrFields {
  InvoiceData({
    required this.account,
    this.cid,
    this.network,
    this.amount,
    required this.label,
  });

  factory InvoiceData.fromQrFieldsV1(List<String> fields) {
    return InvoiceData(
      account: fields[0],
      cid: fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,

      /// fixed bug: if no amount is set in invoice, it works well
      amount: fields[2].trim().isNotEmpty ? double.tryParse(fields[2]) : null,
      label: fields[3],
    );
  }

  factory InvoiceData.fromQrFieldsV2(List<String> fields) {
    return InvoiceData(
      account: fields[0],
      cid: fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
      network: fields[2],
      amount: fields[3].trim().isNotEmpty ? double.parse(fields[3]) : null,
      label: fields[4],
    );
  }

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier.
  final CommunityIdentifier? cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String? network;

  /// Optional payment amount for the invoice.
  num? amount;

  /// Name or other identifier for `account`.
  final String label;

  @override
  List<String> toQrFields() {
    return [
      account,
      cid?.toFmtString() ?? '',
      amount?.toString() ?? '',
      label,
    ];
  }

  List<String> toQrFieldsV2() {
    return [
      account,
      cid?.toFmtString() ?? '',
      network ?? '',
      amount?.toString() ?? '',
      label,
    ];
  }
}
