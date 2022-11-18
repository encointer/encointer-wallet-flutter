import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/qr_code_base.dart';

class VoucherQrCode extends QrCode<VoucherData> {
  VoucherQrCode.withData(VoucherData data) : super(data);

  VoucherQrCode({
    required String voucherUri,
    required CommunityIdentifier cid,
    required String network,
    required String issuer,
  }) : super(VoucherData(voucherUri: voucherUri, cid: cid, network: network, issuer: issuer));

  @override
  QrCodeContext? context = QrCodeContext.voucher;

  @override
  QrCodeVersion? version = QrCodeVersion.v2_0;

  static VoucherQrCode fromPayload(String payload) {
    return fromQrFields(payload.split('\n'));
  }

  static VoucherQrCode fromQrFields(List<String> fields) {
    // todo verify context and version
    return VoucherQrCode.withData(VoucherData.fromQrFields(fields.sublist(2)));
  }
}

class VoucherData implements ToQrFields {
  VoucherData({
    required this.voucherUri,
    required this.cid,
    required this.network,
    required this.issuer,
  });

  /// Uri seed of the voucher account, e.g. //adf456.
  final String voucherUri;

  /// Community identifier.
  final CommunityIdentifier cid;

  /// Network, e.g: nctr-k, nctr-r.
  final String network;

  /// Name of issuer.
  final String issuer;

  @override
  List<String> toQrFields() {
    return [
      voucherUri,
      cid.toFmtString(),
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
