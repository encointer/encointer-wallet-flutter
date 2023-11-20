import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:encointer_wallet/theme/theme.dart';

class QrCodeImage extends StatelessWidget {
  const QrCodeImage({
    super.key,
    required this.qrCode,
    required this.size,
    this.errorCorrectionLevel = QrErrorCorrectLevel.L,
  });

  final String qrCode;
  final double size;
  final int errorCorrectionLevel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: PhotoView.customChild(
        maxScale: 1.0,
        minScale: 0.2,
        backgroundDecoration: BoxDecoration(color: context.colorScheme.background),
        child: PrettyQrView.data(
          data: qrCode,
          errorCorrectLevel: errorCorrectionLevel,
        ),
      ),
    );
  }
}
