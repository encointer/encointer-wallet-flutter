import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:translation/translation.dart';

import 'package:encointer_wallet/common/theme.dart';

class Instruction extends StatelessWidget {
  const Instruction({super.key});

  static const String route = '/instruction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.dic.profile.appHints)),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text(context.dic.profile.meetUpNotifications),
            children: <Widget>[
              ListTile(
                title: Text(context.dic.profile.meetUpListTileTitle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '1. ${context.dic.profile.openAppSettings}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, color: zurichLion),
                            recognizer: TapGestureRecognizer()..onTap = openAppSettings,
                          ),
                        ],
                      ),
                    ),
                    Text('2. ${context.dic.profile.enableAutoStart}'),
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
