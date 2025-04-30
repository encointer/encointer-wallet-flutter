import 'package:encointer_wallet/common/components/submit_button_cupertino.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';

class UpdateProposalButton extends StatefulWidget {
  const UpdateProposalButton({
    super.key,
    required this.proposalId,
    required this.onPressed,
  });

  final BigInt proposalId;
  final void Function() onPressed;

  @override
  State<UpdateProposalButton> createState() => _UpdateProposalButtonState();
}

class _UpdateProposalButtonState extends State<UpdateProposalButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();

    return SubmitButtonSmall(
      onPressed: (context) async {
        await _showSubmitUpdateProposalStateDialog(store, widget.proposalId);
        widget.onPressed();
      },
      child: Text(l10n.proposalClose),
    );
  }

  Future<void> _showSubmitUpdateProposalStateDialog(AppStore store, BigInt proposalId) {
    final l10n = context.l10n;

    return AppAlert.showDialog(
      context,
      title: Text('${l10n.proposal} $proposalId'),
      content: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(l10n.proposalUpdateExplanation),
      ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SubmitButtonCupertino(
                  onPressed: (BuildContext context) async {
                    await _submitUpdateProposalState(store);
                  },
                  child: Text(l10n.proposalUpdateState, style: const TextStyle(color: Colors.green)),
                ),
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _submitUpdateProposalState(AppStore store) async {
    await submitDemocracyUpdateProposalState(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      widget.proposalId,
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onFinish: (_, __) {
        Navigator.of(context).pop();
        setState(() {});
      },
      onError: (dispatchError) {
        final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
        showTxErrorDialog(context, message, false);
      },
    );
  }
}
