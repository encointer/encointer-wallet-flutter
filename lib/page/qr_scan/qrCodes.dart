import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter/material.dart';

import 'qrCodeBase.dart';

class ContactQrCode extends QrCode<ContactData> {
  ContactQrCode.withData(ContactData data) : super(data);

  ContactQrCode({
    @required String account,
    @required String label,
  }) : super(ContactData(account: account, label: label));

  var context = QrCodeContext.contact;

  var version = QrCodeVersion.v2_0;

  static ContactQrCode fromPayload(String payload) {
    return fromQrFields(payload.split("\n"));
  }

  static ContactQrCode fromQrFields(List<String> fields) {
    // todo verify context and version
    return ContactQrCode.withData(ContactData.fromQrFields(fields.sublist(2)));
  }
}

class ContactData implements ToQrFields {
  const ContactData({
    @required this.account,
    @required this.label,
  });

  /// ss58 encoded public key of the account address.
  final String account;

  /// Name or other identifier for `account`.
  final String label;

  List<String> toQrFields() {
    return [account, label];
  }

  static ContactData fromQrFields(List<String> fields) {
    return ContactData(account: fields[0], label: fields[1]);
  }
}

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

class VoucherQrCode extends QrCode<VoucherData> {
  VoucherQrCode.withData(VoucherData data) : super(data);
  VoucherQrCode(
      {@required String voucherUri, @required CommunityIdentifier cid, String network, @required String issuer,})
      : super(VoucherData(voucherUri: voucherUri, cid: cid, network: network, issuer: issuer));

  var context = QrCodeContext.voucher;

  var version = QrCodeVersion.v2_0;

  static VoucherQrCode fromPayload(String payload) {
    return fromQrFields(payload.split("\n"));
  }

  static VoucherQrCode fromQrFields(List<String> fields) {
    // todo verify context and version
    return VoucherQrCode.withData(VoucherData.fromQrFields(fields.sublist(2)));
  }
}

class VoucherData implements ToQrFields {
  VoucherData({
    @required this.voucherUri,
    @required this.cid,
    this.network,
    @required this.issuer,
  });

  /// Uri seed of the voucher account, e.g. //adf456.
  final String voucherUri;

  /// Community identifier.
  final CommunityIdentifier cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String network;

  /// Name of issuer.
  final String issuer;

  List<String> toQrFields() {
    return [
      voucherUri,
      cid?.toFmtString() ?? "",
      network,
      issuer,
    ];
  }

  static VoucherData fromQrFields(List<String> fields) {
    return VoucherData(
      voucherUri: fields[0],
      cid: CommunityIdentifier.fromFmtString(fields[1]),
      network: fields[2],
      issuer: fields[3],
    );
  }
}
