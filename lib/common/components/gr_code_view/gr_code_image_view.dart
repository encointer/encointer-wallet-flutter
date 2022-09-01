import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

class QrCodeImage extends StatelessWidget {
  const QrCodeImage({
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
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: PhotoView.customChild(
            maxScale: 1.0001,
            minScale: 0.2,
            initialScale: 0.8,
            backgroundDecoration: BoxDecoration(
              color: ZurichLion.shade50,
            ),
            child: QrImage(
              backgroundColor: Theme.of(context).canvasColor,
              data: qrCode,
            ),
          ),
        ),
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
