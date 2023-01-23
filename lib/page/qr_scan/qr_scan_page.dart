import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/flutter_qr_reader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/qr_scan/qr_scan_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

export 'qr_codes/qr_code_base.dart';
export 'qr_scan_service.dart';

class ScanPageParams {
  ScanPageParams({
    required this.scannerContext,
  });

  final QrScannerContext scannerContext;
}

class ScanPage extends StatelessWidget {
  ScanPage({super.key});

  static const String route = '/account/scan';

  final QrScanService qrScanService = QrScanService();

  Future<PermissionStatus> canOpenCamera() async {
    // will do nothing if already granted
    return Permission.camera.request();
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
            key: const Key('close-scanner'),
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: FutureBuilder<PermissionStatus>(
        future: canOpenCamera(),
        builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != PermissionStatus.granted) {
              Log.d('[scanPage] Permission Status: ${snapshot.data}', 'ScanPage');
              return permissionErrorDialog(context);
            }

            return Stack(
              children: [
                QrcodeReaderView(
                  text: I18n.of(context)!.translationsForLocale().account.qrScan,
                  onScan: (barcode, args) async {
                    if (barcode == null) {
                      Log.e('Failed to scan Barcode', 'ScanPage');
                    } else {
                      onScan(barcode);
                    }
                  },
                ),
                if (context.select<AppStore, bool>((store) => store.settings.developerMode)) mockQrDataRow(dic, onScan)
              ],
            );
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}

/// Adds some buttons to activate the scanner with mock data.
Widget mockQrDataRow(Translations dic, void Function(String) onScan) {
  return Row(children: [
    ElevatedButton(
      child: Text(dic.profile.addContact),
      onPressed: () => onScan(
        'encointer-contact\nv2.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\n\n\nSara',
      ),
    ),
    ElevatedButton(
      child: Text(dic.assets.invoice),
      onPressed: () => onScan(
        'encointer-invoice\nv1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX'
        '\nsqm1v79dF6b\n0.2343\nAubrey',
      ),
    ),
    ElevatedButton(
      child: const Text('voucher'),
      // There is a unit test in `js_encointer_service/test/service/encointer.test
      // that deposits some funds to this voucher on the local dev-network.
      onPressed: () => onScan(
        'encointer-voucher\nv2.0\n//VoucherUri\nsqm1v79dF6b'
        '\nnctr-gsl-dev\nAubrey',
      ),
    ),
    const Text(' <<< Devs only', style: TextStyle(color: Colors.orange)),
  ]);
}

Widget permissionErrorDialog(BuildContext context) {
  final dic = I18n.of(context)!.translationsForLocale();

  return CupertinoAlertDialog(
    title: Container(),
    content: Text(dic.home.cameraPermissionError),
    actions: <Widget>[
      CupertinoButton(
        child: Text(dic.home.ok),
        onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
      CupertinoButton(
        onPressed: openAppSettings,
        child: Text(dic.home.appSettings),
      ),
    ],
  );
}
