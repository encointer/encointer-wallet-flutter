import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';

void main() {
  group('Contact QrCode', () {
    test('toQrPayload V2 works', () async {
      final qrCode = ContactQrCode(
        account: 'account',
        label: 'label',
        cid: CommunityIdentifier.fromFmtString('sqm1v79dF6b'),
        network: 'nctr-k',
        version: QrCodeVersion.v2_0,
      );

      expect(
        qrCode.toQrPayload(),
        'encointer-contact\n'
        'v2.0\n'
        'account\n'
        'sqm1v79dF6b\n'
        'nctr-k\n'
        'label',
      );
    });

    test('fromQrPayload V2 works', () async {
      const payload = 'encointer-contact\n'
          'v2.0\n'
          'account\n'
          'sqm1v79dF6b\n'
          'nctr-k\n'
          'label';

      final qrCode = ContactQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.contact);
      expect(qrCode.version, QrCodeVersion.v2_0);
      expect(qrCode.data.account, 'account');
      expect(qrCode.data.cid!.toFmtString(), 'sqm1v79dF6b');
      expect(qrCode.data.network, 'nctr-k');
      expect(qrCode.data.label, 'label');
    });

    test('toQrPayload V1 works', () async {
      final qrCode = ContactQrCode(
        account: 'account',
        label: 'label',
        version: QrCodeVersion.v1_0,
      );

      expect(
        qrCode.toQrPayload(),
        'encointer-contact\n'
        'v1.0\n'
        'account\n'
        '\n'
        '\n'
        'label',
      );
    });

    test('fromQrPayload V1 works', () async {
      const payload = 'encointer-contact\n'
          'v1.0\n'
          'account\n'
          '\n'
          '\n'
          'label';

      final qrCode = ContactQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.contact);
      expect(qrCode.version, QrCodeVersion.v1_0);
      expect(qrCode.data.account, 'account');
      expect(qrCode.data.label, 'label');
    });
  });
}
