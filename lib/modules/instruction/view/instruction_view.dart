import 'package:ew_translation/translation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:encointer_wallet/common/theme.dart';

class Instruction extends StatelessWidget {
  const Instruction({super.key});

  static const String route = '/instruction';

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Scaffold(
      appBar: AppBar(title: Text(dic.profile.appHints)),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text(dic.profile.meetUpNotifications),
            children: <Widget>[
              ListTile(
                title: Text(dic.profile.meetUpListTileTitle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '1. ${dic.profile.openAppSettings}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, color: zurichLion),
                            recognizer: TapGestureRecognizer()..onTap = openAppSettings,
                          ),
                        ],
                      ),
                    ),
                    Text('2. ${dic.profile.enableAutoStart}'),
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
