import 'package:encointer_wallet/page/qr_scan/qrCodeBase.dart';
import 'package:encointer_wallet/page/qr_scan/qrCodes.dart';

/// provides functionality and business logic for scanning QR codes in the encointer app
class QrScanService {
  static final String separator = '\n';

  QrCode<dynamic> parse(String rawQrString) {
    List<String> data = rawQrString.split(separator);

    var context = QrCodeContextExt.fromString(data[0]);
    var version = QrCodeVersionExt.fromString(data[1]);

    if (version != QrCodeVersion.v1_0) {
      throw FormatException('QR scan version [${data[1]}] is currently not supported');
    }

    switch (context) {
      case QrCodeContext.contact:
        return ContactQrCode.fromStringList(data);
        break;
      case QrCodeContext.invoice:
        return InvoiceQrCode.fromStringList(data);
        break;
      case QrCodeContext.voucher:
        return VoucherQrCode.fromStringList(data);
        break;
      default:
        throw FormatException('Unhandled qr scan context');
    }
  }
}
