import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactPage.dart';
import 'package:encointer_wallet/page/qr_scan/qrCodeBase.dart';
import 'package:encointer_wallet/page/qr_scan/qrCodes.dart';
import 'package:flutter/cupertino.dart';

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
  static final String separator = '\n';

  QrCode<dynamic> parse(String rawQrString) {
    List<String> data = rawQrString.split(separator);

    var context = QrCodeContextExt.fromString(data[0]);
    var version = QrCodeVersionExt.fromString(data[1]);

    if (version != QrCodeVersion.v1_0) {
      throw FormatException('QR scan version [${data[1]}] is currently not supported');
    }

    switch (context) {
      case QrCodeContext.contact:
        return ContactQrCode.fromStringList(data);
        break;
      case QrCodeContext.invoice:
        return InvoiceQrCode.fromStringList(data);
        break;
      case QrCodeContext.voucher:
        return VoucherQrCode.fromStringList(data);
        break;
      default:
        throw FormatException('Unhandled qr scan context');
    }
  }

  handleQrScan(BuildContext context, QrScannerContext scanContext, QrCode<dynamic> qrCode) {
    switch (qrCode.context) {
      case QrCodeContext.contact:
        return handleContactQrCodeScan(context, scanContext, qrCode);
        break;
      case QrCodeContext.invoice:
        return handleInvoiceQrCodeScan(context, scanContext, qrCode);
        break;
      case QrCodeContext.voucher:
        return handleVoucherQrCodeScan(context, scanContext, qrCode);
        break;
      default:
        throw FormatException('Unhandled qr scan context');
    }
  }
}

/// Handles the `ContactQrCode` scan based on where it was scanned.
handleContactQrCodeScan(BuildContext context, QrScannerContext scanContext, ContactQrCode qrCode) {
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
          redirect: '/',
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
handleInvoiceQrCodeScan(BuildContext context, QrScannerContext scanContext, InvoiceQrCode qrCode) {
  switch (scanContext) {
    case QrScannerContext.mainPage:
      // go to transfer page and auto-fill data
      Navigator.of(context).popAndPushNamed(
        TransferPage.route,
        arguments: TransferPageParams(
          cid: qrCode.data.cid,
          recipient: qrCode.data.account,
          label: qrCode.data.label,
          amount: qrCode.data.amount,
          redirect: '/',
        ),
      );
      break;
    case QrScannerContext.transferPage:
      // go to transfer page and auto-fill data
      Navigator.of(context).popAndPushNamed(
        TransferPage.route,
        arguments: TransferPageParams(
            cid: qrCode.data.cid,
            recipient: qrCode.data.account,
            label: qrCode.data.label,
            amount: qrCode.data.amount,
            redirect: '/',
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

/// Handles the `VoucherQrCode` scan based on where it was scanned.
handleVoucherQrCodeScan(BuildContext context, QrScannerContext scanContext, VoucherQrCode qrCode) {
  switch (scanContext) {
    case QrScannerContext.mainPage:
      // Todo
      break;
    case QrScannerContext.transferPage:
      // Todo
      break;
    case QrScannerContext.contactsPage:
      // Todo
      break;
  }
}
