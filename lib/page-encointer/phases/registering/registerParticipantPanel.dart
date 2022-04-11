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
    webApi.encointer.getParticipantIndex();
    super.initState();
  }

  Future<void> _submit() async {
    if (store.settings.cachedPin.isEmpty) {
      await showCupertinoDialog(
        context: context,
        builder: (context) {
          return showPasswordInputDialog(
              context,
              store.account.currentAccount,
              Text(I18n.of(context)
                  .translationsForLocale()
                  .home
                  .unlockAccount
                  .replaceAll('CURRENT_ACCOUNT_NAME', store.account.currentAccount.name.toString())), (password) {
            store.settings.setPin(password);
          });
        },
      );
    }

    submitRegisterParticipant(
      context,
      webApi,
      store.encointer.chosenCid,
      proof: webApi.encointer.getProofOfAttendance(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // only build dropdown after we have fetched the community identifiers
    final Translations dic = I18n.of(context).translationsForLocale();

    return Observer(
      builder: (_) => Column(
        children: <Widget>[
          store.encointer.meetupTime == null
              ? Container()
              : Column(
                  children: <Widget>[
                    Text(dic.encointer.nextCeremonyDateLabel),
                    Text(DateFormat('yyyy-MM-dd')
                        .format(new DateTime.fromMillisecondsSinceEpoch(store.encointer.meetupTime)))
                  ],
                ),
          store.encointer.participantIndex == null
              ? CupertinoActivityIndicator()
              : store.encointer.participantIndex == 0
                  ? store.encointer.reputations != null
                      ? RoundedButton(text: dic.encointer.registerParticipant, onPressed: () => _submit())
                      : RoundedButton(
                          text: dic.encointer.fetchingReputations,
                          onPressed: null,
                          color: Theme.of(context).disabledColor,
                        )
                  : RoundedButton(
                      text: dic.encointer.youAreRegistered, onPressed: null, color: Theme.of(context).disabledColor),
        ],
      ),
    );
  }
}
