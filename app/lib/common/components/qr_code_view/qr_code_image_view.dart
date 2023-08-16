import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'package:encointer_wallet/theme/theme.dart';

class QrCodeImage extends StatelessWidget {
  const QrCodeImage({
    super.key,
    required this.qrCode,
    this.errorCorrectionLevel = QrErrorCorrectLevel.L,
    this.size,
  });

  final String qrCode;
  final int errorCorrectionLevel;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final s = size ?? MediaQuery.of(context).size.width;
    return SizedBox(
      width: s,
      height: s,
      child: PhotoView.customChild(
        maxScale: 1.0,
        minScale: 0.2,
        backgroundDecoration: BoxDecoration(color: context.colorScheme.background),
        child: PrettyQr(
          data: qrCode,
          errorCorrectLevel: errorCorrectionLevel,
          size: s
        ),
      ),
    );
  }
}
