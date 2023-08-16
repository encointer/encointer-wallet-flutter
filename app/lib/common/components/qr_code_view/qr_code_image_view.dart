import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:encointer_wallet/theme/theme.dart';

class QrCodeImageWithButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        QrCodeImage(qrCode: qrCode),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.share),
          label: Text(shareText, style: context.displaySmall),
        ),
        const SizedBox(height: 20),
      ],
    );
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
    return PhotoView.customChild(
      maxScale: 1.0,
      minScale: 0.2,
      backgroundDecoration: BoxDecoration(color: context.colorScheme.background),
      child: PrettyQr(
        data: qrCode,
        errorCorrectLevel: errorCorrectionLevel,
      ),
    );
  }
}
