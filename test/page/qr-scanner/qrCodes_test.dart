import 'package:encointer_wallet/page/qr_scan/qrCodes.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Contact QrCode', () {
    test('toQrPayload works', () async {
      final qrCode = ContactQrCode(ContactData(
        account: "account",
        label: "label",
      ));

      expect(
        qrCode.toQrPayload(),
        "encointer-contact\n"
        "v1.0\n"
        "account\n"
        "label",
      );
    });
  });

  group('Invoice QrCode', () {
    test('toQrPayload works', () async {
      final qrCode = InvoiceQrCode(InvoiceData(
        account: "account",
        cid: CommunityIdentifier.fromFmtString("sqm1v79dF6b"),
        amount: 1.001,
        label: "label",
      ));

      expect(
        qrCode.toQrPayload(),
        "encointer-invoice\n"
        "v1.0\n"
        "account\n"
        "sqm1v79dF6b\n"
        "1.001\n"
        "label",
      );
    });
  });

  group('Voucher QrCode', () {
    test('toQrPayload works', () async {
      final qrCode = VoucherQrCode(VoucherData(
        voucherUri: "voucherUri",
        cid: CommunityIdentifier.fromFmtString("sqm1v79dF6b"),
        network: "nctr-k",
        issuer: "issuer",
      ));

      expect(
        qrCode.toQrPayload(),
        "encointer-voucher\n"
        "v1.0\n"
        "voucherUri\n"
        "sqm1v79dF6b\n"
        "nctr-k\n"
        "issuer",
      );
    });
  });
}
