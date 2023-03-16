import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: dic.home.unRegisterDescriptoin,
            style: textTheme.headlineMedium!.copyWith(color: encointerGrey),
          ),
          TextSpan(
            text: dic.home.unRegister,
            style: textTheme.headlineMedium!.copyWith(color: encointerGrey, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final value = await AppAlert.showConfirmDialog<bool>(
                  context: context,
                  cancelValue: false,
                  title: Text(dic.home.unRegisterDialogTitle),
                  onOK: () => Navigator.pop(context, true),
                );
                if (value ?? false) {
                  AppAlert.showLoadingDialog(context, dic.home.loading);
                  await submitUnRegisterParticipant(context, context.read<AppStore>(), webApi);
                  Navigator.pop(context);
                }
              },
          ),
        ],
      ),
    );
  }
}
