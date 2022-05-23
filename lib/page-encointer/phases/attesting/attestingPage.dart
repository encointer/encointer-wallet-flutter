import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/assignmentPanel.dart';
import 'package:encointer_wallet/page-encointer/meetup/startMeetup.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AttestingPage extends StatefulWidget {
  AttestingPage(this.store);

  static const String route = '/encointer/attesting';
  final AppStore store;

  @override
  _AttestingPageState createState() => _AttestingPageState(store);
}

class _AttestingPageState extends State<AttestingPage> {
  _AttestingPageState(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return SafeArea(
      child: Column(children: <Widget>[
        AssignmentPanel(store),
        Observer(
          builder: (_) => ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 16),
              if (store.encointer.communityAccount.isAssigned)
                PrimaryButton(
                  key: Key('start-meetup'),
                  child: Text(dic.encointer.startCeremony),
                  onPressed: () => startMeetup(context, store),
                ),
              SizedBox(height: 16),
              Text(
                dic.encointer.claimsScanned
                    .replaceAll('AMOUNT_PLACEHOLDER', store.encointer.communityAccount.scannedClaimsCount.toString()),
                style: Theme.of(context).textTheme.headline3.copyWith(color: encointerGrey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(dic.encointer.claimsSubmit)],
                ),
                onPressed: () =>
                    store.encointer.communityAccount.scannedClaimsCount > 0 ? submitAttestClaims(context, store) : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(dic.encointer.claimsPurge)],
                ),
                onPressed: () => store.encointer.communityAccount.scannedClaimsCount > 0
                    ? _confirmPurgeClaimsDialog(context, store)
                    : null,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

void _confirmPurgeClaimsDialog(BuildContext context, AppStore store) {
  final dic = I18n.of(context).translationsForLocale();

  showCupertinoDialog(
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text(dic.encointer.claimsPurgeConfirm),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoButton(
            child: Text(dic.home.ok),
            onPressed: () {
              store.encointer.communityAccount.purgeParticipantsClaims();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
