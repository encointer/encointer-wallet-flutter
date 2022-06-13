import 'package:flutter/material.dart';

import '../qrCodeBase.dart';

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
