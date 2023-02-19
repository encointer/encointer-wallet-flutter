import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/extensions/extensions.dart';

class QrCodeImageWithButton extends StatelessWidget {
  const QrCodeImageWithButton({
    super.key,
    required this.onTap,
    required this.qrCode,
    required this.text,
  });

  final VoidCallback onTap;
  final String qrCode;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QrCodeImage(qrCode: qrCode),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: onTap,
          icon: Icon(Icons.share, color: zurichLion.shade500),
          label: Text(
            text,
            style: Theme.of(context).textTheme.displaySmall,
          ),
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
    return SizedBox(
      width: context.isMobile ? MediaQuery.of(context).size.width : 1200,
      height: MediaQuery.of(context).size.width,
      child: PhotoView.customChild(
        maxScale: context.isMobile ? 1.0001 : 1.1,
        minScale: context.isMobile ? 0.2 : 0.4,
        initialScale: context.isMobile ? 0.8 : 0.5,
        backgroundDecoration: BoxDecoration(
          color: zurichLion.shade50,
        ),
        child: QrImage(
          backgroundColor: Theme.of(context).canvasColor,
          data: qrCode,
          errorCorrectionLevel: errorCorrectionLevel,
        ),
      ),
    );
  }
}
