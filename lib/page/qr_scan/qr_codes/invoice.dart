import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter/material.dart';

import '../qrCodeBase.dart';

class InvoiceQrCode extends QrCode<InvoiceData> {
  InvoiceQrCode.withData(
    InvoiceData data, {
    this.version = QrCodeVersion.v1_0,
  }) : super(data);

  InvoiceQrCode({
    @required String account,
    CommunityIdentifier cid,
    String network,
    num amount,
    @required String label,
    this.version = QrCodeVersion.v1_0,
  }) : super(InvoiceData(account: account, cid: cid, network: network, amount: amount, label: label));

  var context = QrCodeContext.invoice;

  var version;

  @override
  String toQrPayload() {
    final qrFields = [context.toQrField(), version.toVersionNumber()];
    if (version == QrCodeVersion.v1_0) {
      qrFields.addAll(this.data.toQrFields());
    } else {
      qrFields.addAll(this.data.toQrFieldsV2());
    }
    return qrFields.join(QR_CODE_FIELD_SEPARATOR);
  }

  static InvoiceQrCode fromPayload(String payload) {
    return fromQrFields(payload.split("\n"));
  }

  static InvoiceQrCode fromQrFields(List<String> fields) {
    if (QrCodeVersionExt.fromQrField(fields[1]) == QrCodeVersion.v1_0) {
      return InvoiceQrCode.withData(
        InvoiceData.fromQrFieldsV1(fields.sublist(2)),
        version: QrCodeVersion.v1_0,
      );
    } else {
      return InvoiceQrCode.withData(
        InvoiceData.fromQrFieldsV2(fields.sublist(2)),
        version: QrCodeVersion.v2_0,
      );
    }
  }
}

class InvoiceData implements ToQrFields {
  InvoiceData({
    @required this.account,
    this.cid,
    this.network,
    this.amount,
    @required this.label,
  });

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier.
  final CommunityIdentifier cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String network;

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

  List<String> toQrFieldsV2() {
    return [
      account,
      cid?.toFmtString() ?? "",
      network,
      amount?.toString() ?? "",
      label,
    ];
  }

  static InvoiceData fromQrFieldsV1(List<String> fields) {
    return InvoiceData(
      account: fields[0],
      cid: fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
      amount: fields[2].trim().isNotEmpty ? double.parse(fields[2]) : null,
      label: fields[3],
    );
  }

  static InvoiceData fromQrFieldsV2(List<String> fields) {
    return InvoiceData(
      account: fields[0],
      cid: fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
      network: fields[2],
      amount: fields[3].trim().isNotEmpty ? double.parse(fields[3]) : null,
      label: fields[4],
    );
  }
}
