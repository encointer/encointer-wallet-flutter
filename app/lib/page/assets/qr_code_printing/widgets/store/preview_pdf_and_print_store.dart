import 'dart:convert';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:pdf/pdf.dart';
import 'dart:ui' as ui;
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

part 'preview_pdf_and_print_store.g.dart';

const _logTarget = 'preview_pdf_and_print_store';

// ignore: library_private_types_in_public_api
class PreviewPdfAndPrintStore = _PreviewPdfAndPrintStoreBase with _$PreviewPdfAndPrintStore;

abstract class _PreviewPdfAndPrintStoreBase with Store {
  @observable
  GlobalKey? renderObjectKey;

  @observable
  pw.Document? _doc;

  @computed
  pw.Document? get doc => _doc;

  @observable
  DateTime time = DateTime.now();

  @action
  Future<void> createPdf({
    required GlobalKey key,
    required AppLocalizations translations,
  }) async {
    Log.d('createPdf: key = $key, translations = $translations', _logTarget);
    renderObjectKey = key;

    final uint8list = await _getQrCodeImage();

    final bgImage = await _getBgImage();
    if (uint8list == null || bgImage == null) {
      throw Exception();
    } else {
      final poppinsBlack = await PdfGoogleFonts.poppinsBlack();
      final poppinsMedium = await PdfGoogleFonts.poppinsMedium();
      _doc = pw.Document();
      // ignore: cascade_invocations
      _doc!.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(0),
          build: (context) {
            return pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 46),
              decoration: pw.BoxDecoration(
                image: pw.DecorationImage(
                  image: pw.MemoryImage(
                    bgImage,
                  ),
                ),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 50),
                    child: pw.FittedBox(
                      child: pw.Text(
                        translations.payHereWithLeu,
                        style: pw.TextStyle(
                          fontSize: 56,
                          font: poppinsBlack,
                          color: PdfColor.fromHex('3295C7'),
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Row(
                    children: [
                      pw.SizedBox(
                        height: 180,
                        width: 180,
                        child: pw.Image(
                          pw.MemoryImage(uint8list),
                        ),
                      ),
                      pw.SizedBox(width: 40),
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            translations.openTheEncointerApp,
                            style: pw.TextStyle(
                              fontSize: 22,
                              font: poppinsMedium,
                              color: PdfColor.fromHex('3295C7'),
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            translations.scanQrCodeOnTheLeft,
                            style: pw.TextStyle(
                              fontSize: 22,
                              font: poppinsMedium,
                              color: PdfColor.fromHex('3295C7'),
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            translations.confirmThePayment,
                            style: pw.TextStyle(
                              fontSize: 22,
                              font: poppinsMedium,
                              color: PdfColor.fromHex('3295C7'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @action
  Future<Uint8List?> _getQrCodeImage() async {
    Log.d('_getQrCodeImage', _logTarget);
    try {
      final boundary = renderObjectKey?.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      if (boundary != null) {
        final image = await boundary.toImage(pixelRatio: 3);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        final pngBytes = byteData?.buffer.asUint8List();
        if (pngBytes != null) {
          final bs64 = base64Encode(pngBytes);
          debugPrint(bs64.length.toString());
          return pngBytes;
        }
      }
      return null;
    } catch (_) {
      throw Exception();
    }
  }

  @action
  Future<Uint8List?> _getBgImage() async {
    Log.d('_getBgImage', _logTarget);
    final bgImageData = await rootBundle.load(Assets.images.assets.leuStellerBg.path);
    return bgImageData.buffer.asUint8List();
  }
}
