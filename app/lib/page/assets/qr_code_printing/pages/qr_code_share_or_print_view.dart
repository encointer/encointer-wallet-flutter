import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:encointer_wallet/page/assets/qr_code_printing/widgets/preview_pdf_and_print.dart';
import 'package:encointer_wallet/theme/theme.dart';

class QrCodeShareOrPrintView extends StatefulWidget {
  const QrCodeShareOrPrintView({
    super.key,
    required this.size,
    required this.onTap,
    required this.qrCode,
    required this.shareText,
    required this.printText,
    required this.previewText,
  });

  final double size;
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
    return Column(
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: PhotoView.customChild(
            maxScale: 1.0,
            minScale: 0.2,
            initialScale: 1.0,
            backgroundDecoration: BoxDecoration(color: context.colorScheme.surface),
            child: Center(
              child: RepaintBoundary(
                key: _renderObjectKey,
                child: SizedBox(
                  width: widget.size,
                  child: PrettyQrView.data(data: widget.qrCode),
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
                onPressed: () => _previewPdfAndPrint(context),
                icon: Icon(Icons.print, color: context.colorScheme.secondary),
                label: Text(widget.printText, style: context.bodyMedium.copyWith(color: context.colorScheme.primary))),
            TextButton.icon(
              onPressed: widget.onTap,
              icon: Icon(Icons.share, color: context.colorScheme.secondary),
              label: Text(widget.shareText, style: context.bodyMedium.copyWith(color: context.colorScheme.primary)),
            ),
          ],
        ),
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
