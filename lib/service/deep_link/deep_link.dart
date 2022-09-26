import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

bool _initialURILinkHandled = false;

Future<void> initialDeepLinks(BuildContext context) async {
  if (!_initialURILinkHandled) {
    _initialURILinkHandled = true;
    final url = await getInitialLink();
    await _init(context, url);
  }
  linkStream.listen((url) async {
    await _init(context, url);
  });
}

Future<void> _init(BuildContext context, String? link) async {
  Log.d('==============> initialDeepLink started', 'initialDeepLinks');

  if (link != null) {
    try {
      final qrScanService = QrScanService();
      final qrCode = qrScanService.parse(link.replaceAll(encointerLink, '').replaceAll('_', '\n'));
      _navigationWithWrScanContext(context, qrCode);
      Log.d('==============> $qrCode', 'initialDeepLinks');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(qrCode.data.toString())));
    } catch (e, s) {
      Log.e('Deeplink format $e', 'initialDeepLinks', s);
    }
  } else {
    Log.d('==============> $link', 'initialDeepLinks');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('url null keldi')));
  }
}

void _navigationWithWrScanContext(BuildContext context, QrCode<dynamic> qrCode) {
  switch (qrCode.context) {
    case QrCodeContext.invoice:
      Log.d('==============> qrCode.context QrCodeContext.invoice', 'initialDeepLinks');
      Navigator.of(context).pushNamed(
        TransferPage.route,
        arguments: TransferPageParams(
          recipient: qrCode.data.account,
          label: qrCode.data.label,
          amount: qrCode.data.amount,
        ),
      );
      break;
    case QrCodeContext.contact:
      Navigator.of(context).pushNamed(
        ContactPage.route,
        arguments: qrCode.data,
      );
      Log.d('==============> qrCode.context QrCodeContext.contact', 'initialDeepLinks');
      break;
    case QrCodeContext.voucher:
      Log.d('==============> qrCode.context QrCodeContext.voucher', 'initialDeepLinks');
      break;
    default:
      throw const FormatException('[handleQrScan] Unhandled qr scan context');
  }
}
