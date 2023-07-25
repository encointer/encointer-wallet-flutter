import 'dart:developer';

import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/qr_scan/qr_scan_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/l10n/l10.dart';

export 'qr_codes/qr_code_base.dart';
export 'qr_scan_service.dart';

class ScanPageParams {
  ScanPageParams({
    required this.scannerContext,
  });

  final QrScannerContext scannerContext;
}

class ScanPage extends StatelessWidget {
  ScanPage({required this.arguments, super.key});

  final ScanPageParams arguments;

  static const String route = '/account/scan';

  final QrScanService qrScanService = QrScanService();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appSettingsStore = context.watch<AppSettings>();

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
            key: const Key(EWTestKeys.closeScanner),
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: appSettingsStore.isIntegrationTest ? _mockAppBuild(context, l10n) : _realAppBuild(appSettingsStore, l10n),
    );
  }

  FutureBuilder<PermissionStatus> _realAppBuild(AppSettings appSettingsStore, AppLocalizations l10n) {
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
                controller: MobileScannerController(detectionTimeoutMs: 1250),
                onDetect: (barcode) async {
                  if (barcode.barcodes.isNotEmpty) {
                    log('barcode.rawValue: ${barcode.barcodes}');
                    await _onScan(context, barcode.barcodes[0].rawValue!);
                  } else {
                    Log.d('Failed to scan Barcode', 'ScanPage');
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
            context.l10n.qrScan,
            style: const TextStyle(color: Colors.white, backgroundColor: Colors.black38, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _mockAppBuild(BuildContext context, AppLocalizations l10n) {
    return Stack(
      children: [
        _mockQrDataRow(l10n, (v) => _onScan(context, v)),
        //overlays a semi-transparent rounded square border that is 90% of screen width
        _qrScanTextBuild(context),
      ],
    );
  }

  /// Adds some buttons to activate the scanner with mock data.
  Widget _mockQrDataRow(AppLocalizations l10n, void Function(String) onScan) {
    return Wrap(
      key: const Key(EWTestKeys.mockQrDataRow),
      children: [
        ElevatedButton(
          key: const Key(EWTestKeys.profileToScan),
          child: Text(l10n.addContact),
          onPressed: () => onScan(
            'encointer-contact\nv2.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX\n\n\nFirstContactToSave',
          ),
        ),
        ElevatedButton(
          key: const Key(EWTestKeys.contactToSaveToAddress),
          child: Text(l10n.addToContactFromQrContact),
          onPressed: () => onScan(
            'encointer-contact\nv1.0\nGexcuH8GaJgztyDN3vbFKGaXVePzBUX78Cx29JApZ1gvxyg\n\n\nFromContact',
          ),
        ),
        ElevatedButton(
          key: const Key(EWTestKeys.invoiceToSaveToAddress),
          child: Text(l10n.addInvoiceQrToAddress),
          onPressed: () => onScan(
            'encointer-invoice\nv1.0\n5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty'
            '\nsqm1v79dF6b\n0.01\nFromInvoice',
          ),
        ),
        ElevatedButton(
          key: const Key(EWTestKeys.invoiceWithAmountToScan),
          child: Text(l10n.invoice),
          onPressed: () => onScan(
            'encointer-invoice\nv1.0\nHgTtJusFEn2gmMmB5wmJDnMRXKD6dzqCpNR7a99kkQ7BNvX'
            '\nsqm1v79dF6b\n0.023\nAubrey',
          ),
        ),
        ElevatedButton(
          key: const Key(EWTestKeys.invoiceWithNoAmountToScan),
          child: Text(l10n.noInvoice),
          onPressed: () => onScan(
            'encointer-invoice\nv1.0\n5Cz75Ln579ZZKt9PoAWPmnCNJFY6WNeB7avYqGokZuYSHMuK\nsqm1v79dF6b\n\nManas',
          ),
        ),
        ElevatedButton(
          key: const Key(EWTestKeys.voucherToScan),
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
    final l10n = context.l10n;

    return CupertinoAlertDialog(
      title: Container(),
      content: Text(l10n.cameraPermissionError),
      actions: <Widget>[
        CupertinoButton(
          child: Text(l10n.ok),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        CupertinoButton(
          onPressed: openAppSettings,
          child: Text(l10n.appSettings),
        ),
      ],
    );
  }

  Future<PermissionStatus> _canOpenCamera() async {
    // will do nothing if already granted
    return Permission.camera.request();
  }

  Future<void> _onScan(BuildContext context, String data) async {
    try {
      final qrCode = qrScanService.parse(data);
      await qrScanService.handleQrScan(context, arguments.scannerContext, qrCode);
    } catch (e) {
      RootSnackBar.showMsg(e.toString());
    }
  }
}
