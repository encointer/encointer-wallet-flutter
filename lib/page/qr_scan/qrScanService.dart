import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/profile/contacts/contactPage.dart';
import 'package:encointer_wallet/page/qr_scan/qrCodeBase.dart';
import 'package:encointer_wallet/page/qr_scan/qrCodes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'reapVoucherPage.dart';

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
    List<String> data = rawQrString.split(QR_CODE_FIELD_SEPARATOR);

    var context = QrCodeContextExt.fromQrField(data[0]);
    var version = QrCodeVersionExt.fromQrField(data[1]);

    if (version != QrCodeVersion.v2_0) {
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
        throw FormatException('[parseQrScan] Unhandled qr scan context');
    }
  }

  void handleQrScan(BuildContext context, QrScannerContext scanContext, QrCode<dynamic> qrCode) {
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
        throw FormatException('[handleQrScan] Unhandled qr scan context');
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
void handleInvoiceQrCodeScan(BuildContext context, QrScannerContext scanContext, InvoiceQrCode qrCode) {
  switch (scanContext) {
    case QrScannerContext.mainPage:
      // go to transfer page and auto-fill data
      popAndPushTransferPageWithInvoice(context, qrCode.data);
      break;
    case QrScannerContext.transferPage:
      // go to transfer page and auto-fill data
      popAndPushTransferPageWithInvoice(context, qrCode.data);
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
void handleVoucherQrCodeScan(BuildContext context, QrScannerContext scanContext, VoucherQrCode qrCode) {
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

void popAndPushTransferPageWithInvoice(BuildContext context, InvoiceData data) {
  Navigator.of(context).popAndPushNamed(
    TransferPage.route,
    arguments: TransferPageParams(
      cid: data.cid,
      recipient: data.account,
      label: data.label,
      amount: data.amount,
      redirect: '/',
    ),
  );
}
