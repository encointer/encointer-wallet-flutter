import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:encointer_wallet/common/theme.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key}) : super(key: key);

  static const String route = '/instruction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instruction')),
      body: ListView(
        children: [
          ExpansionTile(
            title: const Text('Push notification about meetup'),
            children: <Widget>[
              ListTile(
                title: const Text('If your device Xiaomi or Honor: Please give permission for meetup notification'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '\nClick', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)),
                          TextSpan(
                            text: ' Open App Settings',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, color: ZurichLion),
                            recognizer: TapGestureRecognizer()..onTap = () => openAppSettings(),
                          ),
                        ],
                      ),
                    ),
                    const Text('Tap on Autostart\nAllow/Deny an App to autostart'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
