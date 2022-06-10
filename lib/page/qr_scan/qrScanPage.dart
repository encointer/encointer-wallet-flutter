import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scan/qrcode_reader_view.dart';
import 'package:permission_handler/permission_handler.dart';

import 'qrCodeBase.dart';
import 'qrScanService.dart';

export 'qrCodeBase.dart';
export 'qrScanService.dart';

class ScanPageParams {
  ScanPageParams({this.forceContext});
  final QrCodeContext forceContext;
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

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Text(msg, style: TextStyle(color: Colors.black54)),
      duration: Duration(milliseconds: 2000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    ScanPageParams params = ModalRoute.of(context).settings.arguments;
    Future onScan(String data, String rawData) {
      try {
        QrCode<dynamic> qrCode = qrScanService.parse(data);
        switch (params?.forceContext ?? qrCode.context) {
          case QrCodeContext.contact:
            // show add contact and auto-fill data
            Navigator.of(context).popAndPushNamed(
              ContactPage.route,
              arguments: qrCode.data,
            );
            break;
          case QrCodeContext.invoice:
            // go to transfer page and auto-fill data
            Navigator.of(context).popAndPushNamed(
              TransferPage.route,
              arguments: TransferPageParams(
                  cid: qrCode.data.cid,
                  recipient: qrCode.data.account,
                  label: qrCode.data.label,
                  amount: qrCode.data.amount,
                  redirect: '/'),
            );
            break;
          default:
            throw UnimplementedError(
                'Scan functionality for the case [${qrCode.context}] has not yet been implemented!');
        }
      } catch (e) {
        print("[ScanPage]: ${e.toString()}");
        _showSnackBar(context, e.toString());

        // If we don't wait, scans  of the same qr code are spammed.
        // My fairly recent cellphone gets too much load for duration < 500 ms. We might need to increase
        // this for older phones.
        Future.delayed(const Duration(milliseconds: 1500), () {
          _qrViewKey.currentState.startScan();
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
                              "encointer-contact\nV1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\nsqm1v79dF6b\n\nSara",
                              null),
                        ),
                        ElevatedButton(
                          child: Text(dic.assets.invoice),
                          onPressed: () => onScan(
                              "encointer-invoice\nV1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX"
                              "\nsqm1v79dF6b\n0.2343\nAubrey",
                              null),
                        ),
                        Text(' <<< Devs only', style: TextStyle(color: Colors.orange)),
                      ])
                    : Container(),
                key: _qrViewKey,
                helpWidget: Text(I18n.of(context).translationsForLocale().account.qrScan),
                onScan: onScan,
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
