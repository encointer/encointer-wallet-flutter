import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:encointer_wallet/page/assets/qr_code_printing/widgets/preview_pdf_and_print.dart';
import 'package:encointer_wallet/utils/extensions/extensions.dart';
import 'package:encointer_wallet/theme/theme.dart';

class QrCodeShareOrPrintView extends StatefulWidget {
  const QrCodeShareOrPrintView({
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
  State<QrCodeShareOrPrintView> createState() => _QrCodeShareOrPrintViewState();
}

class _QrCodeShareOrPrintViewState extends State<QrCodeShareOrPrintView> {
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
            backgroundDecoration: BoxDecoration(color: context.colorScheme.background),
            child: Center(
              child: RepaintBoundary(
                key: _renderObjectKey,
                child: PrettyQr(data: widget.qrCode, size: size.height * 0.45),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => _previewPdfAndPrint(context),
              icon: Icon(Icons.print, color: context.colorScheme.secondary),
              label: Text(widget.printText, style: context.displaySmall),
            ),
            TextButton.icon(
              onPressed: widget.onTap,
              icon: Icon(Icons.share, color: context.colorScheme.secondary),
              label: Text(widget.shareText, style: context.displaySmall),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _previewPdfAndPrint(BuildContext context) async {
    await Navigator.pushNamed(
      context,
      PreviewPdfAndPrint.route,
      arguments: PreviewPdfAndPrintArgs(
        title: widget.previewText,
        renderObjectKey: _renderObjectKey,
      ),
    );
  }
}
