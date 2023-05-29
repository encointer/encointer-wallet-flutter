import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/qr_scan/qr_scan_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/modules/modules.dart';
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
  ScanPage({
    required this.arguments,
    super.key,
  });

  final ScanPageParams arguments;

  static const String route = '/account/scan';

  final QrScanService qrScanService = QrScanService();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final appSettingsStore = context.watch<AppSettings>();

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
      body: appSettingsStore.isIntegrationTest ? _mockAppBuild(context, dic) : _realAppBuild(appSettingsStore, dic),
    );
  }

  FutureBuilder<PermissionStatus> _realAppBuild(AppSettings appSettingsStore, Translations dic) {
    return FutureBuilder<PermissionStatus>(
      future: _canOpenCamera(),
      builder: (BuildContext context, AsyncSnapshot<PermissionStatus> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != PermissionStatus.granted) {
            Log.d('[scanPage] Permission Status: ${snapshot.data}', 'ScanPage');
            return _permissionErrorDialog(context);
          }

          return Stack(
            children: [
              MobileScanner(
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    Log.d('Failed to scan Barcode', 'ScanPage');
                  } else {
                    log('barcode.rawValue: ${barcode.rawValue}');
                    _onScan(context, barcode.rawValue!);
                  }
                },
              ),
              //overlays a semi-transparent rounded square border that is 90% of screen width
              _qrScanTextBuild(context),
            ],
          );
        } else {
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }

  Widget _qrScanTextBuild(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white38, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
          ),
          Text(
            I18n.of(context)!.translationsForLocale().account.qrScan,
            style: const TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _mockAppBuild(BuildContext context, Translations dic) {
    return Stack(
      children: [
        _mockQrDataRow(dic, (v) => _onScan(context, v)),
        //overlays a semi-transparent rounded square border that is 90% of screen width
        _qrScanTextBuild(context),
      ],
    );
  }

  /// Adds some buttons to activate the scanner with mock data.
  Widget _mockQrDataRow(Translations dic, void Function(String) onScan) {
    return Wrap(
      key: const Key('mock-qr-data-row'),
      children: [
        ElevatedButton(
          key: const Key('profile-to-scan'),
          child: Text(dic.profile.addContact),
          onPressed: () => onScan(
            'encointer-contact\nv2.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\n\n\nFirstContactToSave',
          ),
        ),
        ElevatedButton(
          key: const Key('contact-to-save-to-address'),
          child: Text(dic.profile.addToContactFromQrContact),
          onPressed: () => onScan(
            'encointer-contact\nv1.0\nGexcuH8GaJgztyDN3vbFKGaXVePzBUX78Cx29JApZ1gvxyg\n\n\nFromContact',
          ),
        ),
        ElevatedButton(
          key: const Key('invoice-to-save-to-address'),
          child: Text(dic.assets.addInvoiceQrToAddress),
          onPressed: () => onScan(
            'encointer-invoice\nv1.0\n5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty'
            '\nsqm1v79dF6b\n0.01\nFromInvoice',
          ),
        ),
        ElevatedButton(
          key: const Key('invoice-with-amount-to-scan'),
          child: Text(dic.assets.invoice),
          onPressed: () => onScan(
            'encointer-invoice\nv1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX'
            '\nsqm1v79dF6b\n0.023\nAubrey',
          ),
        ),
        ElevatedButton(
          key: const Key('invoice-with-no-amount-to-scan'),
          child: Text(dic.assets.noInvoice),
          onPressed: () => onScan(
            'encointer-invoice\nv1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\nsqm1v79dF6b\n\nAubrey',
          ),
        ),
        ElevatedButton(
          key: const Key('voucher-to-scan'),
          child: const Text('voucher'),
          // There is a unit test in `js_encointer_service/test/service/encointer.test
          // that deposits some funds to this voucher on the local dev-network.
          onPressed: () => onScan(
            'encointer-voucher\nv2.0\n//VoucherUri\nsqm1v79dF6b'
            '\nnctr-gsl-dev\nAubrey',
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(' <<< Devs only', style: TextStyle(color: Colors.orange)),
        ),
      ],
    );
  }

  Widget _permissionErrorDialog(BuildContext context) {
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

  Future<PermissionStatus> _canOpenCamera() async {
    // will do nothing if already granted
    return Permission.camera.request();
  }

  void _onScan(BuildContext context, String data) {
    try {
      final qrCode = qrScanService.parse(data);
      qrScanService.handleQrScan(context, arguments.scannerContext, qrCode);
    } catch (e) {
      RootSnackBar.showMsg(e.toString());
    }
  }
}
