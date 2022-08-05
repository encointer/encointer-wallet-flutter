import 'package:encointer_wallet/store/encointer/types/communities.dart';

import 'qrCodeBase.dart';

class ContactQrCode extends QrCode<ContactData> {
  ContactQrCode.withData(
    ContactData data, {
    this.version = QrCodeVersion.v1_0,
  }) : super(data);

  ContactQrCode({
    required String account,
    CommunityIdentifier? cid,
    String? network,
    required String label,
    this.version = QrCodeVersion.v1_0,
  }) : super(ContactData(account: account, cid: cid, network: network, label: label));

  QrCodeContext? context = QrCodeContext.contact;

  QrCodeVersion? version;

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

  static ContactQrCode fromPayload(String payload) {
    return fromQrFields(payload.split("\n"));
  }

  static ContactQrCode fromQrFields(List<String> fields) {
    if (QrCodeVersionExt.fromQrField(fields[1]) == QrCodeVersion.v1_0) {
      return ContactQrCode.withData(
        ContactData.fromQrFieldsV1(fields.sublist(2)),
        version: QrCodeVersion.v1_0,
      );
    } else {
      return ContactQrCode.withData(
        ContactData.fromQrFieldsV2(fields.sublist(2)),
        version: QrCodeVersion.v2_0,
      );
    }
  }
}

class ContactData implements ToQrFields {
  const ContactData({
    required this.account,
    this.cid,
    this.network,
    required this.label,
  });

  /// ss58 encoded public key of the account address.
  final String account;

  /// Community identifier.
  final CommunityIdentifier? cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String? network;

  /// Name or other identifier for `account`.
  final String label;

  // implicitly is v1 to satisfy interface
  List<String> toQrFields() {
    return [account, "", "", label];
  }

  List<String> toQrFieldsV2() {
    return [account, cid?.toFmtString() ?? "", network ?? "", label];
  }

  static ContactData fromQrFieldsV1(List<String> fields) {
    return ContactData(account: fields[0], label: fields[3]);
  }

  static ContactData fromQrFieldsV2(List<String> fields) {
    print('fields======================>$fields');
    return ContactData(
      account: fields[0],
      cid: null, // fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
      network: fields[0].isNotEmpty ? fields[0] : 'network',
      label: fields[1],
    );

    // ContactData(
    //   account: fields[0],
    //   cid:
    //       null, //fields[1].isNotEmpty ? CommunityIdentifier.fromFmtString(fields[1]) : null,
    //   network: fields[2].isNotEmpty ? fields[2] : 'network',
    //   label: fields[1],
    // );
  }
}
