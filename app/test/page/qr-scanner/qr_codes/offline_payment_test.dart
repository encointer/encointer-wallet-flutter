import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';

void main() {
  group('OfflinePaymentQrCode', () {
    const testProof = 'dGVzdC1wcm9vZi1iYXNlNjQ=';
    const testSender = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
    const testRecipient = '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty';
    const testCid = 'sqm1v79dF6b';
    const testNetwork = 'nctr-k';
    const testAmount = '1.5';
    final testNullifier = 'ab' * 32;
    final testCommitment = 'cd' * 32;
    const testReputation = 3;
    const testLabel = 'Alice';

    test('toQrPayload produces correct format', () {
      final qrCode = OfflinePaymentQrCode(
        proofBase64: testProof,
        sender: testSender,
        recipient: testRecipient,
        cidFmt: testCid,
        network: testNetwork,
        amount: testAmount,
        nullifierHex: testNullifier,
        commitmentHex: testCommitment,
        reputationCount: testReputation,
        label: testLabel,
      );

      expect(
        qrCode.toQrPayload(),
        'encointer-offlinepay\n'
        'v1.0\n'
        '$testProof\n'
        '$testSender\n'
        '$testRecipient\n'
        '$testCid\n'
        '$testNetwork\n'
        '$testAmount\n'
        '$testNullifier\n'
        '$testCommitment\n'
        '$testReputation\n'
        '$testLabel',
      );
    });

    test('fromPayload decodes correctly', () {
      final payload = 'encointer-offlinepay\n'
          'v1.0\n'
          '$testProof\n'
          '$testSender\n'
          '$testRecipient\n'
          '$testCid\n'
          '$testNetwork\n'
          '$testAmount\n'
          '$testNullifier\n'
          '$testCommitment\n'
          '$testReputation\n'
          '$testLabel';

      final qrCode = OfflinePaymentQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.offlinepay);
      expect(qrCode.version, QrCodeVersion.v1_0);
      expect(qrCode.data.proofBase64, testProof);
      expect(qrCode.data.sender, testSender);
      expect(qrCode.data.recipient, testRecipient);
      expect(qrCode.data.cidFmt, testCid);
      expect(qrCode.data.network, testNetwork);
      expect(qrCode.data.amount, testAmount);
      expect(qrCode.data.nullifierHex, testNullifier);
      expect(qrCode.data.commitmentHex, testCommitment);
      expect(qrCode.data.reputationCount, testReputation);
      expect(qrCode.data.label, testLabel);
    });

    test('encode-decode round-trip preserves all fields', () {
      final original = OfflinePaymentQrCode(
        proofBase64: testProof,
        sender: testSender,
        recipient: testRecipient,
        cidFmt: testCid,
        network: testNetwork,
        amount: testAmount,
        nullifierHex: testNullifier,
        commitmentHex: testCommitment,
        reputationCount: testReputation,
        label: testLabel,
      );

      final payload = original.toQrPayload();
      final decoded = OfflinePaymentQrCode.fromPayload(payload);

      expect(decoded.data.proofBase64, original.data.proofBase64);
      expect(decoded.data.sender, original.data.sender);
      expect(decoded.data.recipient, original.data.recipient);
      expect(decoded.data.cidFmt, original.data.cidFmt);
      expect(decoded.data.network, original.data.network);
      expect(decoded.data.amount, original.data.amount);
      expect(decoded.data.nullifierHex, original.data.nullifierHex);
      expect(decoded.data.commitmentHex, original.data.commitmentHex);
      expect(decoded.data.reputationCount, original.data.reputationCount);
      expect(decoded.data.label, original.data.label);
    });

    test('QrScanService.parse recognizes offlinepay context', () {
      final payload = 'encointer-offlinepay\n'
          'v1.0\n'
          '$testProof\n'
          '$testSender\n'
          '$testRecipient\n'
          '$testCid\n'
          '$testNetwork\n'
          '$testAmount\n'
          '$testNullifier\n'
          '$testCommitment\n'
          '$testReputation\n'
          '$testLabel';

      final context = QrCodeContextExt.fromQrField('encointer-offlinepay');
      expect(context, QrCodeContext.offlinepay);

      final qrCode = OfflinePaymentQrCode.fromPayload(payload);
      expect(qrCode.context, QrCodeContext.offlinepay);
    });
  });
}
