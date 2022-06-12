import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter/material.dart';

import 'qrCodeBase.dart';

class ContactQrCode extends QrCode<ContactData> {
  ContactQrCode(this.data);

  var context = QrCodeContext.contact;

  var version = QrCodeVersion.v1_0;

  ContactData data;

  static ContactQrCode fromStringList(List<String> values) {
    // todo verify context and version
    return ContactQrCode(ContactData(
      account: values[2],
      label: values[3],
    ));
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
}

class InvoiceQrCode extends QrCode<InvoiceData> {
  InvoiceQrCode(this.data);

  var context = QrCodeContext.invoice;

  var version = QrCodeVersion.v1_0;

  InvoiceData data;

  static InvoiceQrCode fromStringList(List<String> values) {
    // todo verify context and version
    return InvoiceQrCode(
      InvoiceData(
        account: values[2],
        cid: values[3].isNotEmpty ? CommunityIdentifier.fromFmtString(values[3]) : null,
        amount: values[4].trim().isNotEmpty ? double.parse(values[4]) : null,
        label: values[5],
      ),
    );
  }
}

class InvoiceData implements ToQrFields{
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
  final num amount;

  /// Name or other identifier for `account`.
  final String label;

  List<String> toQrFields() {
    return [
      account,
      cid.toFmtString(),
      amount.toString(),
      label,
    ];
  }
}

class VoucherQrCode extends QrCode<VoucherData> {
  VoucherQrCode(this.data);

  var context = QrCodeContext.voucher;

  var version = QrCodeVersion.v1_0;

  VoucherData data;

  static VoucherQrCode fromStringList(List<String> values) {
    // todo verify context and version
    return VoucherQrCode(
      VoucherData(
        voucherUri: values[2],
        cid: CommunityIdentifier.fromFmtString(values[3]),
        network: values[4],
        issuer: values[5],
      ),
    );
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
      cid.toFmtString(),
      network,
      issuer,
    ];
  }
}
