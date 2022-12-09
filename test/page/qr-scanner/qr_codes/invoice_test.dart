import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';

void main() {
  group('Invoice QrCode', () {
    test('toQrPayload V2 works', () async {
      final qrCode = InvoiceQrCode(
        account: 'account',
        cid: CommunityIdentifier.fromFmtString('sqm1v79dF6b'),
        network: 'nctr-k',
        amount: 1.001,
        label: 'label',
        version: QrCodeVersion.v2_0,
      );

      expect(
        qrCode.toQrPayload(),
        'encointer-invoice\n'
        'v2.0\n'
        'account\n'
        'sqm1v79dF6b\n'
        'nctr-k\n'
        '1.001\n'
        'label',
      );
    });

    test('fromQrPayload V2 works', () async {
      const payload = 'encointer-invoice\n'
          'v2.0\n'
          'account\n'
          'sqm1v79dF6b\n'
          'nctr-k\n'
          '1.001\n'
          'label';

      final qrCode = InvoiceQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.invoice);
      expect(qrCode.version, QrCodeVersion.v2_0);
      expect(qrCode.data.account, 'account');
      expect(qrCode.data.cid!.toFmtString(), 'sqm1v79dF6b');
      expect(qrCode.data.network, 'nctr-k');
      expect(qrCode.data.amount, 1.001);
      expect(qrCode.data.label, 'label');
    });
  });

  test('toQrPayload V1 works', () async {
    final qrCode = InvoiceQrCode(
      account: 'account',
      cid: CommunityIdentifier.fromFmtString('sqm1v79dF6b'),
      amount: 1.001,
      label: 'label',
      version: QrCodeVersion.v1_0,
    );

    expect(
      qrCode.toQrPayload(),
      'encointer-invoice\n'
      'v1.0\n'
      'account\n'
      'sqm1v79dF6b\n'
      '1.001\n'
      'label',
    );
  });

  test('fromQrPayload V1 works', () async {
    const payload = 'encointer-invoice\n'
        'v1.0\n'
        'account\n'
        'sqm1v79dF6b\n'
        '1.001\n'
        'label';

    final qrCode = InvoiceQrCode.fromPayload(payload);

    expect(qrCode.context, QrCodeContext.invoice);
    expect(qrCode.version, QrCodeVersion.v1_0);
    expect(qrCode.data.account, 'account');
    expect(qrCode.data.cid!.toFmtString(), 'sqm1v79dF6b');
    expect(qrCode.data.amount, 1.001);
    expect(qrCode.data.label, 'label');
  });
}
