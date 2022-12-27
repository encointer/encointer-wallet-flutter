import 'package:flutter/material.dart';

class MockQRScanPage extends StatelessWidget {
  const MockQRScanPage(this.background, {super.key});

  // image that emulates camera
  final ImageProvider background;

  static const String route = '/account/mockScan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: background,
                fit: BoxFit.cover,
              ),
            ),
            child: Container()),
        SafeArea(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).cardColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        //overlays a semi-transparent rounded square border that is 90% of screen width
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white38, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                ),
              ),
              const Text(
                'Scan Qr Code',
                style: TextStyle(color: Colors.white38),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
