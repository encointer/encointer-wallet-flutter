import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key}) : super(key: key);

  static const String route = '/instruction';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().profile;

    return Scaffold(
      appBar: AppBar(title: Text(dic.appHints)),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text(dic.meetUpNotification),
            children: <Widget>[
              ListTile(
                title: Text(dic.meetUpListTileTitle),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\n${dic.click}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
                          ),
                          TextSpan(
                            text: ' ${dic.openAppSettings}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14, color: ZurichLion),
                            recognizer: TapGestureRecognizer()..onTap = () => openAppSettings(),
                          ),
                        ],
                      ),
                    ),
                    Text(dic.enableAutoStart),
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
