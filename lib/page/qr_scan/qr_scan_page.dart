import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'qr_scan_service.dart';

export 'qr_codes/qr_code_base.dart';
export 'qr_scan_service.dart';

class ScanPageParams {
  ScanPageParams({
    required this.scannerContext,
  });
  final QrScannerContext scannerContext;
}

class ScanPage extends StatelessWidget {
  ScanPage(this.store);

  static const String route = '/account/scan';

  final QrScanService qrScanService = QrScanService();
  final AppStore store;

  Future<bool> canOpenCamera() async {
    // will do nothing if already granted
    return Permission.camera.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final params = ModalRoute.of(context)!.settings.arguments! as ScanPageParams;
    void onScan(String data) {
      try {
        final qrCode = qrScanService.parse(data);
        qrScanService.handleQrScan(context, params.scannerContext, qrCode);
      } catch (e) {
        RootSnackBar.showMsg(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            key: Key('close-scanner'),
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: FutureBuilder<bool>(
        future: canOpenCamera(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Stack(
              children: [
                MobileScanner(
                  allowDuplicates: false,
                  onDetect: (barcode, args) {
                    if (barcode.rawValue == null) {
                      debugPrint('Failed to scan Barcode');
                    } else {
                      onScan(barcode.rawValue!);
                    }
                  },
                ),
                store.settings.developerMode ? mockQrDataRow(dic, onScan) : Container(),
                //overlays a semi-transparent rounded square border that is 90% of screen width
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white38, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        ),
                      ),
                      Text(
                        I18n.of(context)!.translationsForLocale().account.qrScan,
                        style: TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}

/// Adds some buttons to activate the scanner with mock data.
Widget mockQrDataRow(Translations dic, Function(String) onScan) {
  return Row(children: [
    ElevatedButton(
      child: Text(dic.profile.addContact),
      onPressed: () => onScan(
        "encointer-contact\nv2.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\nSara",
      ),
    ),
    ElevatedButton(
      child: Text(dic.assets.invoice),
      onPressed: () => onScan(
        "encointer-invoice\nv1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX"
        "\nsqm1v79dF6b\n0.2343\nAubrey",
      ),
    ),
    ElevatedButton(
      child: Text("voucher"),
      onPressed: () => onScan(
        "encointer-voucher\nv2.0\n//VoucherUri\nsqm1v79dF6b"
        "\nnctr-gsl-dev\nAubrey",
      ),
    ),
    Text(' <<< Devs only', style: TextStyle(color: Colors.orange)),
  ]);
}
