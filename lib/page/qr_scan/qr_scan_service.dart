import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/page/reap_voucher/reap_voucher_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

enum QrScannerContext {
  /// QrScanner was opened from the main page
  mainPage,

  /// QrScanner was opened form the transfer page
  transferPage,

  /// QrScanner was opened from the contacts page
  contactsPage,
}

/// Handles QrCode scans.
class QrScanService {
  QrCode<dynamic> parse(String rawQrString) {
    Log.d('Raw qrcode data: $rawQrString', 'QrScanService');

    // FIXME: this is a hack to redirect old Leu community vouchers to new cid
    final qrStringReplaced = rawQrString.replaceAll('u0qj92QX9PQ', 'u0qj944rhWE');
    final qrString = qrStringReplaced.replaceAll('u0qj9QqA2Q', 'u0qj944rhWE');

    final data = qrString.split(qrCodeFieldSeparator);

    final context = QrCodeContextExt.fromQrField(data[0]);

    switch (context) {
      case QrCodeContext.contact:
        return ContactQrCode.fromQrFields(data);
      case QrCodeContext.invoice:
        return InvoiceQrCode.fromQrFields(data);
      case QrCodeContext.voucher:
        return VoucherQrCode.fromQrFields(data);
      default:
        throw const FormatException('[parseQrScan] Unhandled qr scan context');
    }
  }

  void handleQrScan(BuildContext context, QrScannerContext scanContext, QrCode<dynamic> qrCode) {
    switch (qrCode.context) {
      case QrCodeContext.contact:
        return handleContactQrCodeScan(context, scanContext, qrCode as ContactQrCode);
      case QrCodeContext.invoice:
        return handleInvoiceQrCodeScan(context, scanContext, qrCode as InvoiceQrCode);
      case QrCodeContext.voucher:
        return handleVoucherQrCodeScan(context, scanContext, qrCode as VoucherQrCode);
      default:
        throw const FormatException('[handleQrScan] Unhandled qr scan context');
    }
  }
}

/// Handles the `ContactQrCode` scan based on where it was scanned.
void handleContactQrCodeScan(BuildContext context, QrScannerContext scanContext, ContactQrCode qrCode) {
  switch (scanContext) {
    case QrScannerContext.mainPage:
      // show add contact and auto-fill data
      Navigator.of(context).popAndPushNamed(
        ContactPage.route,
        arguments: qrCode.data,
      );
      break;
    case QrScannerContext.transferPage:
      // go to transfer page and auto-fill data, but skip
      // the fields for cid or amount
      Navigator.of(context).popAndPushNamed(
        TransferPage.route,
        arguments: TransferPageParams(
          recipient: qrCode.data.account,
          label: qrCode.data.label,
        ),
      );
      break;
    case QrScannerContext.contactsPage:
      Navigator.of(context).popAndPushNamed(
        ContactPage.route,
        arguments: qrCode.data,
      );
      break;
  }
}

/// Handles the `InvoiceQrCode` scan based on where it was scanned.
void handleInvoiceQrCodeScan(BuildContext context, QrScannerContext scanContext, InvoiceQrCode qrCode) {
  switch (scanContext) {
    case QrScannerContext.mainPage:
      // go to transfer page and auto-fill data
      Navigator.of(context).popAndPushNamed(
        TransferPage.route,
        arguments: TransferPageParams.fromInvoiceData(qrCode.data),
      );
      break;
    case QrScannerContext.transferPage:
      // go back to transfer page and auto-fill data
      Navigator.of(context).pop(qrCode.data);
      break;
    case QrScannerContext.contactsPage:
      Navigator.of(context).popAndPushNamed(ContactPage.route,
          arguments: ContactData(
            account: qrCode.data.account,
            label: qrCode.data.label,
          ));
      break;
  }
}

/// Handles the `VoucherQrCode` scan based on where it was scanned.
void handleVoucherQrCodeScan(BuildContext context, QrScannerContext? scanContext, VoucherQrCode qrCode) {
  var showFundVoucher = false;
  if (scanContext == QrScannerContext.transferPage) {
    showFundVoucher = true;
  }

  Navigator.of(context).popAndPushNamed(ReapVoucherPage.route,
      arguments: ReapVoucherParams(
        voucher: qrCode.data,
        showFundVoucher: showFundVoucher,
      ));
}
