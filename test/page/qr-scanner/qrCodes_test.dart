import 'package:encointer_wallet/page/qr_scan/qrCodeBase.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Invoice QrCode', () {
    test('toQrPayload works', () async {
      final qrCode = InvoiceQrCode(
        account: "account",
        cid: CommunityIdentifier.fromFmtString("sqm1v79dF6b"),
        amount: 1.001,
        label: "label",
      );

      expect(
        qrCode.toQrPayload(),
        "encointer-invoice\n"
        "v2.0\n"
        "account\n"
        "sqm1v79dF6b\n"
        "1.001\n"
        "label",
      );
    });

    test('fromQrPayload works', () async {
      final payload = "encointer-invoice\n"
          "v2.0\n"
          "account\n"
          "sqm1v79dF6b\n"
          "1.001\n"
          "label";

      final qrCode = InvoiceQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.invoice);
      expect(qrCode.version, QrCodeVersion.v2_0);
      expect(qrCode.data.account, "account");
      expect(qrCode.data.cid.toFmtString(), "sqm1v79dF6b");
      expect(qrCode.data.amount, 1.001);
      expect(qrCode.data.label, "label");
    });
  });

  group('Voucher QrCode', () {
    test('toQrPayload works', () async {
      final qrCode = VoucherQrCode(
        voucherUri: "voucherUri",
        cid: CommunityIdentifier.fromFmtString("sqm1v79dF6b"),
        network: "nctr-k",
        issuer: "issuer",
      );

      expect(
        qrCode.toQrPayload(),
        "encointer-voucher\n"
        "v2.0\n"
        "voucherUri\n"
        "sqm1v79dF6b\n"
        "nctr-k\n"
        "issuer",
      );
    });

    test('fromQrPayload works', () async {
      final payload = "encointer-voucher\n"
          "v2.0\n"
          "voucherUri\n"
          "sqm1v79dF6b\n"
          "nctr-k\n"
          "issuer";

      final qrCode = VoucherQrCode.fromPayload(payload);

      expect(qrCode.context, QrCodeContext.voucher);
      expect(qrCode.version, QrCodeVersion.v2_0);
      expect(qrCode.data.voucherUri, "voucherUri");
      expect(qrCode.data.cid.toFmtString(), "sqm1v79dF6b");
      expect(qrCode.data.network, "nctr-k");
      expect(qrCode.data.issuer, "issuer");
    });
  });
}
