import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter/material.dart';

import '../qrCodeBase.dart';

class InvoiceQrCode extends QrCode<InvoiceData> {
  InvoiceQrCode.withData(InvoiceData data) : super(data);

  InvoiceQrCode({
    @required String account,
    CommunityIdentifier cid,
    num amount,
    @required String label,
  }) : super(InvoiceData(account: account, cid: cid, amount: amount, label: label));

  var context = QrCodeContext.invoice;

  var version = QrCodeVersion.v2_0;

  static InvoiceQrCode fromPayload(String payload) {
    return fromQrFields(payload.split("\n"));
  }

  static InvoiceQrCode fromQrFields(List<String> fields) {
    // todo verify context and version
    return InvoiceQrCode.withData(InvoiceData.fromQrFields(fields.sublist(2)));
  }
}

class InvoiceData implements ToQrFields {
  InvoiceData({
    @required this.account,
    this.cid,
    this.amount,
    @required this.label,
  });

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier.
  final CommunityIdentifier cid;

  /// Optional payment amount for the invoice.
  num amount;

  /// Name or other identifier for `account`.
  final String label;

  List<String> toQrFields() {
    return [
      account,
      cid?.toFmtString() ?? "",
      amount?.toString() ?? "",
      label,
    ];
  }

  static InvoiceData fromQrFields(List<String> fields) {
    return InvoiceData(
      account: fields[0],
      cid: fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
      amount: fields[2].trim().isNotEmpty ? double.parse(fields[2]) : null,
      label: fields[3],
    );
  }
}
