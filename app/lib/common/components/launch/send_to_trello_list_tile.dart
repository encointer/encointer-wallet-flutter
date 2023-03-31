import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class SendToTrelloListTile extends StatelessWidget {
  const SendToTrelloListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().profile;
    final h3Grey = Theme.of(context).textTheme.displaySmall!.copyWith(color: encointerGrey);
    return ListTile(
      title: Text(dic.contactUs, style: h3Grey),
      onTap: () async => AppLaunch.sendEmail(
        'malikelbay1+np8u5ozogws6ijqbldun@boards.trello.com',
        snackBarText: dic.checkEmailApp,
        context: context,
      ),
    );
  }
}
