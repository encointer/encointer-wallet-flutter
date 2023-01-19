import 'package:ew_translation/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

class SendToTrelloListTile extends StatelessWidget {
  const SendToTrelloListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    final h3Grey = Theme.of(context).textTheme.headline3!.copyWith(color: encointerGrey);
    return ListTile(
      title: Text(dic.profile.contactUs, style: h3Grey),
      onTap: () async => AppLaunch.sendEmail(
        'malikelbay1+np8u5ozogws6ijqbldun@boards.trello.com',
        snackBarText: dic.profile.checkEmailApp,
        context: context,
      ),
    );
  }
}
