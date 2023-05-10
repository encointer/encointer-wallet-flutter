import 'dart:convert';

import 'package:encointer_wallet/service/log/log_service.dart';
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

class PreviewPdfAndPrintStore = _PreviewPdfAndPrintStoreBase with _$PreviewPdfAndPrintStore;

abstract class _PreviewPdfAndPrintStoreBase with Store {
  _PreviewPdfAndPrintStoreBase(this._renderObjectKey) {
    _createPdf();
  }

  @observable
  GlobalKey _renderObjectKey;

  @observable
  pw.Document? _doc;

  @computed
  pw.Document? get doc => _doc;

  @observable
  DateTime time = DateTime.now();

  @action
  Future<void> _createPdf() async {
    Log.d('_createPdf', _logTarget);
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
                        'Zahle hier mit Leu',
                        style: pw.TextStyle(
                          fontSize: 56,
                          font: poppinsBlack,
                          color: PdfColor.fromHex(
                            '3295C7',
                          ),
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
                            '1. Öffne die App \n«Encointer Wallet»',
                            style: pw.TextStyle(
                              fontSize: 22,
                              font: poppinsMedium,
                              color: PdfColor.fromHex(
                                '3295C7',
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            '2. Scanne den QR-Code \nauf der linken Seite',
                            style: pw.TextStyle(
                              fontSize: 22,
                              font: poppinsMedium,
                              color: PdfColor.fromHex(
                                '3295C7',
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            '3. Bestätige die Zahlung',
                            style: pw.TextStyle(
                              fontSize: 22,
                              font: poppinsMedium,
                              color: PdfColor.fromHex(
                                '3295C7',
                              ),
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
      final boundary = _renderObjectKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData?.buffer.asUint8List();
      if (pngBytes != null) {
        final bs64 = base64Encode(pngBytes);
        debugPrint(bs64.length.toString());
        return pngBytes;
      }

      return null;
    } catch (_) {
      throw Exception();
    }
  }

  @action
  Future<Uint8List?> _getBgImage() async {
    Log.d('_getBgImage', _logTarget);
    final bgImageData = await rootBundle.load('assets/images/assets/leu_steller_bg.png');
    return bgImageData.buffer.asUint8List();
  }
}
