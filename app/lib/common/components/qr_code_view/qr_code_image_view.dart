import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:encointer_wallet/page/assets/qr_code_printing/preview_pdf_and_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/extensions/extensions.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class QrCodeImageWithButton extends StatefulWidget {
  const QrCodeImageWithButton({
    super.key,
    required this.onTap,
    required this.qrCode,
    required this.shareText,
    required this.printText,
    required this.previewText,
  });

  final VoidCallback onTap;
  final String qrCode;
  final String shareText;
  final String printText;
  final String previewText;

  @override
  State<QrCodeImageWithButton> createState() => _QrCodeImageWithButtonState();
}

class _QrCodeImageWithButtonState extends State<QrCodeImageWithButton> {
  final GlobalKey _renderObjectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: context.isMobile ? size.width : 1200,
          height: size.width,
          child: PhotoView.customChild(
            maxScale: context.isMobile ? 1.0001 : 1.1,
            minScale: context.isMobile ? 0.2 : 0.4,
            initialScale: context.isMobile ? 0.8 : 0.5,
            backgroundDecoration: BoxDecoration(color: zurichLion.shade50),
            child: Center(
              child: RepaintBoundary(
                key: _renderObjectKey,
                child: PrettyQr(
                  data: widget.qrCode,
                  size: size.height * 0.45,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => _createPreviewForPdf(context),
              icon: Icon(Icons.print, color: zurichLion.shade500),
              label: Text(
                widget.printText,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            TextButton.icon(
              onPressed: widget.onTap,
              icon: Icon(Icons.share, color: zurichLion.shade500),
              label: Text(
                widget.shareText,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<Uint8List?> _getQrCodeImage() async {
    try {
      final boundary = _renderObjectKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

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

  Future<Uint8List?> _getBgImage() async {
    final bgImageData = await rootBundle.load('assets/images/assets/leu_steller_bg.png');
    return bgImageData.buffer.asUint8List();
  }

  Future<void> _createPreviewForPdf(BuildContext context) async {
    final uint8list = await _getQrCodeImage();

    final bgImage = await _getBgImage();
    if (uint8list == null || bgImage == null) {
      throw Exception();
    } else {
      final poppinsBlack = await PdfGoogleFonts.poppinsBlack();
      final poppinsMedium = await PdfGoogleFonts.poppinsMedium();
      final doc = pw.Document();
      // ignore: cascade_invocations
      doc.addPage(
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

      /// open Preview Screen
      await Navigator.push(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => PreviewPdfAndPrint(
            doc: doc,
            title: widget.previewText,
          ),
        ),
      );
    }
  }
}

class QrCodeImage extends StatelessWidget {
  const QrCodeImage({
    super.key,
    required this.qrCode,
    this.errorCorrectionLevel = QrErrorCorrectLevel.L,
  });

  final String qrCode;
  final int errorCorrectionLevel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: context.isMobile ? size.width : 1200,
      height: size.width,
      child: PhotoView.customChild(
          maxScale: context.isMobile ? 1.0001 : 1.1,
          minScale: context.isMobile ? 0.2 : 0.4,
          initialScale: context.isMobile ? 0.8 : 0.5,
          backgroundDecoration: BoxDecoration(color: zurichLion.shade50),
          child: Center(
            child: PrettyQr(
              data: qrCode,
              errorCorrectLevel: errorCorrectionLevel,
              size: size.height * 0.45,
            ),
          )),
    );
  }
}
