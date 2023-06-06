import 'dart:developer';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/qr_code_base.dart';

class ContactQrCode extends QrCode<ContactData> {
  ContactQrCode({
    required String account,
    CommunityIdentifier? cid,
    String? network,
    required String label,
    this.qrCodeVersion = QrCodeVersion.v1_0,
  }) : super(ContactData(account: account, cid: cid, network: network, label: label));

  factory ContactQrCode.fromPayload(String payload) {
    return ContactQrCode.fromQrFields(payload.split('\n'));
  }

  factory ContactQrCode.fromQrFields(List<String> fields) {
    if (QrCodeVersionExt.fromQrField(fields[1]) == QrCodeVersion.v1_0) {
      log('fromQrField fields ${fields.length}');
      return ContactQrCode.withData(ContactData.fromQrFieldsV1(fields.sublist(2)));
    } else {
      return ContactQrCode.withData(
        ContactData.fromQrFieldsV2(fields.sublist(2)),
        qrCodeVersion: QrCodeVersion.v2_0,
      );
    }
  }

  ContactQrCode.withData(super.data, {this.qrCodeVersion = QrCodeVersion.v1_0});

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
  QrCodeContext get context => QrCodeContext.contact;

  @override
  QrCodeVersion get version => qrCodeVersion;
}

class ContactData implements ToQrFields {
  const ContactData({
    required this.account,
    this.cid,
    this.network,
    required this.label,
  });

  factory ContactData.fromQrFieldsV1(List<String> fields) {
    return ContactData(account: fields[0], label: fields[3]);
  }

  factory ContactData.fromQrFieldsV2(List<String> fields) {
    return ContactData(
      account: fields[0],
      cid: fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
      network: fields[2],
      label: fields[3],
    );
  }

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier.
  final CommunityIdentifier? cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String? network;

  /// Name or other identifier for `account`.
  final String label;

  // implicitly is v1 to satisfy interface
  @override
  List<String> toQrFields() {
    return [account, '', '', label];
  }

  List<String> toQrFieldsV2() {
    return [account, cid?.toFmtString() ?? '', network ?? '', label];
  }
}
