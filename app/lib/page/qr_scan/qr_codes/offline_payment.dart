import 'package:encointer_wallet/page/qr_scan/qr_codes/qr_code_base.dart';

class OfflinePaymentQrCode extends QrCode<OfflinePaymentData> {
  OfflinePaymentQrCode({
    required String proofBase64,
    required String sender,
    required String recipient,
    required String cidFmt,
    required String network,
    required String amount,
    required String nullifierHex,
    required String commitmentHex,
    required int reputationCount,
    required String label,
  }) : super(OfflinePaymentData(
          proofBase64: proofBase64,
          sender: sender,
          recipient: recipient,
          cidFmt: cidFmt,
          network: network,
          amount: amount,
          nullifierHex: nullifierHex,
          commitmentHex: commitmentHex,
          reputationCount: reputationCount,
          label: label,
        ));

  factory OfflinePaymentQrCode.fromPayload(String payload) {
    return OfflinePaymentQrCode.fromQrFields(payload.split('\n'));
  }

  factory OfflinePaymentQrCode.fromQrFields(List<String> fields) {
    return OfflinePaymentQrCode.withData(OfflinePaymentData.fromQrFields(fields.sublist(2)));
  }

  OfflinePaymentQrCode.withData(super.data);

  @override
  QrCodeContext get context => QrCodeContext.offlinepay;

  @override
  QrCodeVersion get version => QrCodeVersion.v1_0;
}

class OfflinePaymentData implements ToQrFields {
  const OfflinePaymentData({
    required this.proofBase64,
    required this.sender,
    required this.recipient,
    required this.cidFmt,
    required this.network,
    required this.amount,
    required this.nullifierHex,
    required this.commitmentHex,
    required this.reputationCount,
    required this.label,
  });

  factory OfflinePaymentData.fromQrFields(List<String> fields) {
    return OfflinePaymentData(
      proofBase64: fields[0],
      sender: fields[1],
      recipient: fields[2],
      cidFmt: fields[3],
      network: fields[4],
      amount: fields[5],
      nullifierHex: fields[6],
      commitmentHex: fields[7],
      reputationCount: int.parse(fields[8]),
      label: fields[9],
    );
  }

  /// Base64-encoded ZK proof bytes.
  final String proofBase64;

  /// SS58-encoded sender address.
  final String sender;

  /// SS58-encoded recipient address.
  final String recipient;

  /// Community identifier in fmt string form.
  final String cidFmt;

  /// Network identifier, e.g. nctr-k, nctr-r.
  final String network;

  /// Payment amount as string.
  final String amount;

  /// Hex-encoded nullifier (64 chars).
  final String nullifierHex;

  /// Hex-encoded commitment (64 chars).
  final String commitmentHex;

  /// Number of ceremonies the sender has participated in.
  final int reputationCount;

  /// Sender display name.
  final String label;

  @override
  List<String> toQrFields() {
    return [
      proofBase64,
      sender,
      recipient,
      cidFmt,
      network,
      amount,
      nullifierHex,
      commitmentHex,
      reputationCount.toString(),
      label,
    ];
  }
}
