import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_service.dart';
import 'package:encointer_wallet/page/reap_voucher/reap_voucher_page.dart';
import 'package:encointer_wallet/service/log/log.dart';

bool _initialURILinkHandled = false;

Future<void> initialDeepLinks(BuildContext context) async {
  final appLinks = AppLinks();
  if (!_initialURILinkHandled) {
    _initialURILinkHandled = true;
    final url = await appLinks.getInitialAppLinkString();
    await _init(context, url);
  }
  appLinks.stringLinkStream.listen((url) async {
    await _init(context, url);
  });
}

Future<void> _init(BuildContext context, String? link) async {
  if (link != null) {
    try {
      final qrScanService = QrScanService();
      final qrCode = qrScanService.parse(link.replaceAll(encointerLink, '').replaceAll('_', '\n'));
      await _navigationWithWrScanContext(context, qrCode);
    } catch (e, s) {
      Log.e('Deeplink format $e', 'initialDeepLinks', s);
    }
  }
}

Future<void> _navigationWithWrScanContext(BuildContext context, QrCode<dynamic> qrCode) async {
  switch (qrCode.context) {
    case QrCodeContext.invoice:
      await Navigator.of(context).pushNamed(
        TransferPage.route,
        arguments: TransferPageParams(
          recipient: qrCode.data.account as String,
          label: qrCode.data.label as String?,
          amount: qrCode.data.amount as double?,
        ),
      );
      break;
    case QrCodeContext.contact:
      await Navigator.of(context).pushNamed(
        ContactPage.route,
        arguments: qrCode.data,
      );
      break;
    case QrCodeContext.voucher:
      await Navigator.of(context).pushNamed(
        ReapVoucherPage.route,
        arguments: ReapVoucherParams(
          voucher: qrCode.data as VoucherData,
        ),
      );
      break;
    default:
      break;
  }
}
