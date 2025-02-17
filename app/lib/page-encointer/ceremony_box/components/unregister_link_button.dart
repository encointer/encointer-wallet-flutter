import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/models/index.dart';

class UnregisteredLinkButton extends StatefulWidget {
  const UnregisteredLinkButton({super.key});

  @override
  State<UnregisteredLinkButton> createState() => _UnregisteredLinkButtonState();
}

class _UnregisteredLinkButtonState extends State<UnregisteredLinkButton> {
  bool _submitting = false;

  Future<void> _onPressed() async {
    setState(() {
      _submitting = true;
    });

    final store = context.read<AppStore>();

    final lastProofOfAttendance = store.encointer.communityAccount?.participantType?.isReputable ?? false
        ? store.encointer.account
            ?.lastProofOfAttendance // can still be null if the participant did not register on the same phone.
        : null;

    await submitUnRegisterParticipant(context, store, webApi,
        store.account.getKeyringAccount(store.account.currentAccountPubKey!), store.encointer.chosenCid!,
        lastProofOfAttendance: lastProofOfAttendance,
        txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid), onError: (dispatchError) {
      final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
      showTxErrorDialog(context, message);
    });

    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return InkWell(
      key: const Key(EWTestKeys.unregisterButton),
      onTap: () async {
        final shouldUnregister = await AppAlert.showConfirmDialog<bool>(
          context: context,
          onCancel: () => Navigator.pop(context, false),
          title: Text(l10n.unregisterDialogTitle, key: const Key(EWTestKeys.unregisterDialog)),
          onOK: () => Navigator.pop(context, true),
        );
        if (shouldUnregister ?? false) {
          await _onPressed();
        }
      },
      child: !_submitting
          ? Text(
              l10n.unregister,
              style: context.bodyMedium.copyWith(color: AppColors.encointerGrey, decoration: TextDecoration.underline),
            )
          : const CupertinoActivityIndicator(),
    );
  }
}
