import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/extras/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';

import 'package:encointer_wallet/service/tx/lib/tx.dart';

class UnregisteredLinkButton extends StatelessWidget {
  const UnregisteredLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dic = I18n.of(context)!.translationsForLocale();
    return InkWell(
      key: const Key('unregister-button'),
      onTap: () async {
        final shouldUnregister = await AppAlert.showConfirmDialog<bool>(
          context: context,
          onCancel: () => Navigator.pop(context, false),
          title: Text(dic.home.unregisterDialogTitle, key: const Key('unregister-dialog')),
          onOK: () => Navigator.pop(context, true),
        );
        if (shouldUnregister ?? false) {
          AppAlert.showLoadingDialog(context, dic.home.loading);
          await submitUnRegisterParticipant(context, sl<AppStore>(), webApi);
          Navigator.pop(context);
        }
      },
      child: Text(
        dic.home.unregister,
        style: textTheme.headlineMedium!.copyWith(color: encointerGrey, decoration: TextDecoration.underline),
      ),
    );
  }
}
