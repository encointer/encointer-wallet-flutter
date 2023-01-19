import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:translation/translation.dart';

class SendToTrelloListTile extends StatelessWidget {
  const SendToTrelloListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final h3Grey = Theme.of(context).textTheme.headline3!.copyWith(color: encointerGrey);
    return ListTile(
      title: Text(context.dic.profile.contactUs, style: h3Grey),
      onTap: () async => AppLaunch.sendEmail(
        'malikelbay1+np8u5ozogws6ijqbldun@boards.trello.com',
        snackBarText: context.dic.profile.checkEmailApp,
        context: context,
      ),
    );
  }
}
