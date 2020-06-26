import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:polka_wallet/common/components/infoItem.dart';
import 'package:polka_wallet/common/components/passwordInputDialog.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/page-encointer/attesting/qrCode.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';
import 'package:polka_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:polka_wallet/utils/i18n/index.dart';
import 'package:polka_wallet/page-encointer/attesting/meetupPage.dart';
import 'package:polka_wallet/page-encointer/common/CeremonyOverviewPanel.dart';
import 'package:polka_wallet/page-encointer/attesting/confirmAttendeesDialog.dart';

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

  @observable
  var _amountAttendees;

  @action
  setAmountAttendees(amount) {
    _amountAttendees = amount;
  }

  String _tab = 'DOT';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startMeetup(BuildContext context) async {
    var amount = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ConfirmAttendeesDialog()));
    setAmountAttendees(amount);
    var claimHex = await webApi.encointer.getClaimOfAttendance(
        _amountAttendees);
    print("Claim: " + claimHex);

//    var meetupRegistry = await webApi.encointer.fetchMeetupRegistry();
    var meetupRegistry = List.filled(amount, '0x44495e0e8733d0b65ea1333c8bf7f4c54dc9f580b38aaadc3d771c771fb70260');
    meetupRegistry[0] = '0x11195e0e8733d0b65ea1333c8bf7f4c54dc9f580b38aaadc3d771c771fb70260';
    meetupRegistry[1] = store.account.currentAccountPubKey;
    meetupRegistry[2] = '0x22295e0e8733d0b65ea1333c8bf7f4c54dc9f580b38aaadc3d771c771fb70260';
    meetupRegistry[3] = '0x33395e0e8733d0b65ea1333c8bf7f4c54dc9f580b38aaadc3d771c771fb70260';
    meetupRegistry[4] = '0x44495e0e8733d0b65ea1333c8bf7f4c54dc9f580b38aaadc3d771c771fb70260';
    store.encointer.attestations = _buildAttestationStateMap(meetupRegistry);

    var args = {
      'claim': claimHex,
      'confirmedParticipants': amount
    };

//    _showPasswordDialog(context, claimHex);
    Navigator.pushNamed(context, MeetupPage.route, arguments: args);
  }

  Map<int, AttestationState> _buildAttestationStateMap(List<String> pubKeys) {
    final map = Map<int, AttestationState>();
    pubKeys.asMap().forEach(
        (i, key) => !(key == store.account.currentAccountPubKey)
            ? map.putIfAbsent(i, () => AttestationState(key))
            : store.encointer.myMeetupRegistryIndex = i // track our index as it defines if we must show our qr-code first
        );

    print(store.encointer.myMeetupRegistryIndex);
    return map;
  }

  Future<void> _submitClaim(BuildContext context, String claimHex, String password) async {
    var att = await webApi.encointer.attestClaimOfAttendance(claimHex, password);
    print("att: " + att.toString());

//    var args = {
//      "title": 'register_attestations',
//      "txInfo": {
//        "module": 'encointerCeremonies',
//        "call": 'registerAttestations',
//      },
//      "detail": jsonEncode({
//        "attestations": [att],
//      }),
//      "params": [
//        [att], // we usually supply a list of attestations
//      ],
//      'onFinish': (BuildContext txPageContext, Map res) {
//        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
//      }
//    };
//    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }

  Future<void> _showPasswordDialog(BuildContext context, String claimHex) async {
    showCupertinoDialog(
      context: context,
      builder: (_) {
        return PasswordInputDialog(
          title: Text(I18n.of(context).home['unlock']),
          onOk: (password) => _submitClaim(context, claimHex, password),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
    final int decimals = encointer_token_decimals;
    return SafeArea(
      child: Column(
          children: <Widget>[
            CeremonyOverviewPanel(store),
            RoundedButton(
                text: "start meetup",
                onPressed: () => _startMeetup(context) // for testing always allow sending
            ),
          ]
      ),
    );
  }
}


