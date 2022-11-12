import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/extensions/extensions.dart';

class QrCodeImageWithButton extends StatelessWidget {
  const QrCodeImageWithButton({
    Key? key,
    required this.onTap,
    required this.qrCode,
    required this.text,
  }) : super(key: key);

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
          icon: Icon(Icons.share, color: ZurichLion.shade500),
          label: Text(
            text,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class QrCodeImage extends StatelessWidget {
  const QrCodeImage({
    Key? key,
    required this.qrCode,
    this.errorCorrectionLevel = QrErrorCorrectLevel.L,
  }) : super(key: key);

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
          color: ZurichLion.shade50,
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
