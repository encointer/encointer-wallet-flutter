import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class RegisterParticipantPanel extends StatefulWidget {
  RegisterParticipantPanel(this.store);

  static const String route = '/encointer/registerParticipantPanel';
  final AppStore store;

  @override
  _RegisterParticipantPanel createState() => _RegisterParticipantPanel(store);
}

class _RegisterParticipantPanel extends State<RegisterParticipantPanel> {
  _RegisterParticipantPanel(this.store);

  final AppStore store;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submit() async {
    // this is called inside submitTx too, but we need to unlock the key for the proof of attendance.
    if (store.settings.cachedPin.isEmpty) {
      var unlockText = I18n.of(context).translationsForLocale().home.unlockAccount;
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(unlockText.replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name)),
            (password) => store.settings.setPin(password),
          );
        },
      );
    }

    submitTx(
      context,
      store,
      webApi,
      registerParticipantParams(store.encointer.chosenCid, proof: await webApi.encointer.getProofOfAttendance()),
      onFinish: (BuildContext txPageContext, Map res) {
        webApi.encointer.getAggregatedAccountData(store.encointer.chosenCid, store.account.currentAddress);
        Navigator.popUntil(
          txPageContext,
          ModalRoute.withName('/'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // only build dropdown after we have fetched the community identifiers
    final Translations dic = I18n.of(context).translationsForLocale();

    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          store.encointer.communityAccount?.meetup?.time == null
              ? Container()
              : Column(
                  children: <Widget>[
                    Text(dic.encointer.nextCeremonyDateLabel),
                    Text(DateFormat('yyyy-MM-dd')
                        .format(new DateTime.fromMillisecondsSinceEpoch(store.encointer.communityAccount.meetup.time)))
                  ],
                ),
          store.encointer.communityAccount.isRegistered
              ? Column(children: <Widget>[
                  RoundedButton(
                      text: dic.encointer.youAreRegistered, onPressed: null, color: Theme.of(context).disabledColor),
                  Text("as " + store.encointer.communityAccount.participantType.toString().split('.').last)
                ])
              : store.encointer.account.reputations != null
                  ? Column(children: <Widget>[
                      RoundedButton(
                          text: dic.encointer.registerParticipant + ": " + store.account.currentAccount.name.toString(),
                          onPressed: () => _submit()),
                      // skipping dic here because it's throwaway code anyway
                      Text("reputation: " + store.encointer.account.reputations.length.toString())
                    ])
                  : RoundedButton(
                      text: dic.encointer.fetchingReputations,
                      onPressed: null,
                      color: Theme.of(context).disabledColor,
                    )
        ],
      ),
    );
  }
}
