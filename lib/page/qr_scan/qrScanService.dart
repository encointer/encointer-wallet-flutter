import 'package:encointer_wallet/page/qr_scan/qrCodeBase.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';

/// provides functionality and business logic for scanning QR codes in the encointer app
class QrScanService {
  static final String separator = '\n';
  static final int numberOfRowsV1 = 6;

  QrScanData parse(String rawQrString) {
    List<String> data = rawQrString.split(separator);
    String rawContext = 'QrScanContext.${data[0].substring(10)}';
    if (data[1].toLowerCase() == 'v1.0') {
      if (data.length != numberOfRowsV1) {
        throw FormatException('QR scan data illegal number of rows [${data.length}] expected: $numberOfRowsV1');
      }
      return QrScanData(
        context: QrCodeContext.values.firstWhere(
          (qrContext) => qrContext.toString() == rawContext,
          orElse: () {
            throw FormatException(
                'QR scan context [${data[0]}] -> [$rawContext] is not supported; supported values are: ${QrCodeContext.values}');
          },
        ),
        version: data[1].toLowerCase(),
        account: data[2],
        cid: data[3].isNotEmpty ? CommunityIdentifier.fromFmtString(data[3]) : null,
        amount: data[4].trim().isNotEmpty ? double.parse(data[4]) : null,
        label: data[5],
      );
    } else {
      throw FormatException('QR scan data format [${data[1]}] is currently not supported');
    }
  }
}
