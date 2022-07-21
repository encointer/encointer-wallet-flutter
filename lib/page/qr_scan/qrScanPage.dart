import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snackBar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/qrcode_reader_view.dart';
import 'package:permission_handler/permission_handler.dart';

import 'qrScanService.dart';
import 'qr_codes/qrCodeBase.dart';

export 'qrScanService.dart';
export 'qr_codes/qrCodeBase.dart';

class ScanPageParams {
  ScanPageParams({
    required this.scannerContext,
  });
  final QrScannerContext scannerContext;
}

class ScanPage extends StatelessWidget {
  ScanPage(this.store);

  static const String route = '/account/scan';
  final GlobalKey<QrcodeReaderViewState> _qrViewKey = GlobalKey();

  final QrScanService qrScanService = QrScanService();
  final AppStore store;

  Future<bool> canOpenCamera() async {
    // will do nothing if already granted
    return Permission.camera.request().isGranted;
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    ScanPageParams params = ModalRoute.of(context)!.settings.arguments! as ScanPageParams;
    Future? onScan(String? data, String? rawData) {
      try {
        QrCode<dynamic> qrCode = qrScanService.parse(data!);
        qrScanService.handleQrScan(context, params.scannerContext, qrCode);
      } catch (e) {
        print("[ScanPage]: ${e.toString()}");
        RootSnackBar.showMsg(e.toString());

        // If we don't wait, scans  of the same qr code are spammed.
        // My fairly recent cellphone gets too much load for duration < 500 ms. We might need to increase
        // this for older phones.
        Future.delayed(const Duration(milliseconds: 1500), () {
          _qrViewKey.currentState!.startScan();
        });
      }

      return null;
    }

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            key: Key('close-scanner'),
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: canOpenCamera(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return QrcodeReaderView(
                headerWidget: store.settings.developerMode
                    ? Row(children: [
                        ElevatedButton(
                          child: Text(dic.profile.addContact),
                          onPressed: () => onScan(
                              "encointer-contact\nv2.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\nSara", null),
                        ),
                        ElevatedButton(
                          child: Text(dic.assets.invoice),
                          onPressed: () => onScan(
                              "encointer-invoice\nv2.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX"
                              "\nsqm1v79dF6b\n0.2343\nAubrey",
                              null),
                        ),
                        ElevatedButton(
                          child: Text("voucher"),
                          onPressed: () => onScan(
                              "encointer-voucher\nv2.0\n//VoucherUri\nsqm1v79dF6b"
                              "\nnctr-gsl-dev\nAubrey",
                              null),
                        ),
                        Text(' <<< Devs only', style: TextStyle(color: Colors.orange)),
                      ])
                    : Container(),
                key: _qrViewKey,
                helpWidget: Text(I18n.of(context)!.translationsForLocale().account.qrScan),
                onScan: onScan as Future<dynamic> Function(String?, String?),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
