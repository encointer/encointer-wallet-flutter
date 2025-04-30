import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:ew_keyring/ew_keyring.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';

class Remarks extends StatelessWidget {
  const Remarks(
    this.store, {
    required this.userAddress,
    super.key,
  });

  final AppStore store;

  final Address userAddress;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titleLarge = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);

    return Column(
      children: [
        Text(l10n.remarks, style: titleLarge, textAlign: TextAlign.left),
        Text(
          l10n.remarksExplain,
          textAlign: TextAlign.left,
        ),
        ElevatedButton(
          onPressed: () => _showRemarkDialog(context),
          child: Text(l10n.remarksButton),
        ),
      ],
    );
  }

  void _showRemarkDialog(BuildContext context) {
    final remarkController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.l10n.remarksSubmit),
          content: TextField(
            controller: remarkController,
            decoration: InputDecoration(hintText: context.l10n.remarksNote),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(context.l10n.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(context.l10n.remarksSubmit),
              onPressed: () async {
                final remark = remarkController.text;
                if (remark.isNotEmpty) {
                  await _submitRemarkTx(context, remark);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitRemarkTx(BuildContext context, String remark) async {
    return submitRemark(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      remark,
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onError: (dispatchError) {
        final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
        showTxErrorDialog(context, message, false);
      },
    );
  }
}
