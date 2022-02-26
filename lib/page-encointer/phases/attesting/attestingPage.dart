import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/assignmentPanel.dart';
import 'package:encointer_wallet/page-encointer/meetup/startMeetup.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
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
              ((store.encointer.meetupIndex == null) | (store.encointer.meetupIndex == 0))
                  ? Text(dic.encointer.meetupNotAssigned)
                  : PrimaryButton(
                      key: Key('start-meetup'),
                      child: Text(dic.encointer.meetupStart),
                      onPressed: () => startMeetup(context, store),
                    ),
              SizedBox(height: 16),
              Text(
                dic.encointer.claimsScanned
                    .replaceAll('AMOUNT_PLACEHOLDER', store.encointer.scannedClaimsCount.toString()),
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
                onPressed: () => store.encointer.scannedClaimsCount > 0 ? _submit(context) : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(dic.encointer.claimsPurge)],
                ),
                onPressed: () =>
                    store.encointer.scannedClaimsCount > 0 ? _confirmPurgeClaimsDialog(context, store) : null,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final Translations dic = I18n.of(context).translationsForLocale();
    var args = {
      "title": 'attest_claims',
      "txInfo": {
        "module": 'encointerCeremonies',
        "call": 'attestClaims',
        "cid": store.encointer.chosenCid,
      },
      "detail": dic.encointer.claimsSubmitDetail.replaceAll('AMOUNT', store.encointer.scannedClaimsCount.toString()),
      "params": [store.encointer.participantsClaims.values.toList()],
      'onFinish': (BuildContext txPageContext, Map res) {
        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
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
              store.encointer.purgeParticipantsClaims();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
