import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class SendToTrelloListTile extends StatelessWidget {
  const SendToTrelloListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().profile;
    final h3Grey = Theme.of(context).textTheme.displaySmall!.copyWith(color: encointerGrey);
    return ListTile(
      title: Text(dic.contactUs, style: h3Grey),
      onTap: () async => AppLaunch.sendEmail(
        'bugreports@mail.encointer.org',
        snackBarText: dic.checkEmailApp,
        context: context,
      ),
    );
  }
}
