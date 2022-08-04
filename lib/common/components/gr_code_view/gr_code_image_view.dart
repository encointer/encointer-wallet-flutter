import 'package:flutter/material.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

import '../../theme.dart';

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
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: ZurichLion.shade500),
                  SizedBox(width: 8),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              scaleFactor: 800,
              minScale: 0.1,
              maxScale: 2.0,
              child: QrImage(
                backgroundColor: Theme.of(context).canvasColor,
                data: qrCode,
                size: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
