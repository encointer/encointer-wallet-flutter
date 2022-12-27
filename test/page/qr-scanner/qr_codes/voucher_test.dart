import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';

void main() {
  group('Voucher QrCode', () {
    test('toQrPayload works', () async {
      final qrCode = VoucherQrCode(
        voucherUri: 'voucherUri',
        cid: CommunityIdentifier.fromFmtString('sqm1v79dF6b'),
        network: 'nctr-k',
        issuer: 'issuer',
      );

      expect(
        qrCode.toQrPayload(),
        'encointer-voucher\n'
        'v2.0\n'
        'voucherUri\n'
        'sqm1v79dF6b\n'
        'nctr-k\n'
        'issuer',
      );
    });

    test('fromQrPayload works', () async {
      const payload = 'encointer-voucher\n'
          'v2.0\n'
          'voucherUri\n'
          'sqm1v79dF6b\n'
          'nctr-k\n'
          'issuer';

      final qrCode = VoucherQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.voucher);
      expect(qrCode.version, QrCodeVersion.v2_0);
      expect(qrCode.data.voucherUri, 'voucherUri');
      expect(qrCode.data.cid.toFmtString(), 'sqm1v79dF6b');
      expect(qrCode.data.network, 'nctr-k');
      expect(qrCode.data.issuer, 'issuer');
    });
  });
}
