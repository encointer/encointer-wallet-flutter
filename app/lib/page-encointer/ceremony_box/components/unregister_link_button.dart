import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';

class UnregisteredLinkButton extends StatelessWidget {
  const UnregisteredLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      key: const Key('unregister-button'),
      onTap: () async {
        final shouldUnregister = await AppAlert.showConfirmDialog<bool>(
          context: context,
          onCancel: () => Navigator.pop(context, false),
          title: Text(l10n.unregisterDialogTitle, key: const Key('unregister-dialog')),
          onOK: () => Navigator.pop(context, true),
        );
        if (shouldUnregister ?? false) {
          AppAlert.showLoadingDialog(context, l10n.loading);
          await submitUnRegisterParticipant(context, context.read<AppStore>(), webApi);
          Navigator.pop(context);
        }
      },
      child: Text(
        l10n.unregister,
        style: context.bodyMedium.copyWith(color: AppColors.encointerGrey, decoration: TextDecoration.underline),
      ),
    );
  }
}
