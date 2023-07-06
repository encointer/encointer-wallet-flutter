import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class SendToTrelloListTile extends StatelessWidget {
  const SendToTrelloListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final h3Grey = context.headlineSmall.copyWith(color: AppColors.encointerGrey);
    return ListTile(
      title: Text(context.l10n.contactUs, style: h3Grey),
      onTap: () async => AppLaunch.sendEmail(
        'bugreports@mail.encointer.org',
        snackBarText: context.l10n.checkEmailApp,
        context: context,
      ),
    );
  }
}
