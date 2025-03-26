import 'package:encointer_wallet/config/consts.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class SendToTrelloListTile extends StatelessWidget {
  const SendToTrelloListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        context.l10n.contactUs,
        style: context.titleLarge.copyWith(color: AppColors.encointerGrey, fontSize: 19),
      ),
      onTap: () async => AppLaunch.sendEmail(
        bugReportMail,
        snackBarText: context.l10n.checkEmailApp,
        context: context,
      ),
    );
  }
}
