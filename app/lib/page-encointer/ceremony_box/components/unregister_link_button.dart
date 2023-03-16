import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';

class UnregisteredLinkButton extends StatelessWidget {
  const UnregisteredLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dic = I18n.of(context)!.translationsForLocale();
    return SizedBox(
      height: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              dic.home.unRegisterDescriptoin,
              maxLines: 2,
              style: textTheme.headlineMedium!.copyWith(color: encointerGrey),
            ),
          ),
          InkWell(
            key: const Key('unregister-button'),
            onTap: () async {
              final value = await AppAlert.showConfirmDialog<bool>(
                context: context,
                cancelValue: false,
                title: Text(dic.home.unRegisterDialogTitle, key: const Key('unregister-dialog')),
                onOK: () => Navigator.pop(context, true),
              );
              if (value ?? false) {
                AppAlert.showLoadingDialog(context, dic.home.loading);
                await submitUnRegisterParticipant(context, context.read<AppStore>(), webApi);
                Navigator.pop(context);
              }
            },
            child: Text(
              dic.home.unRegister,
              style: textTheme.headlineMedium!.copyWith(color: encointerGrey, decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
