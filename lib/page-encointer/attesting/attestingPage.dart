import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/infoItem.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
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

  String _tab = 'DOT';

  @override
  void initState() {
    webApi.encointer.fetchParticipantIndex();
    webApi.encointer.fetchParticipantCount();
    super.initState();
  }

  Widget _startMeetup(BuildContext context) {
    Navigator.of(context).pushNamed(MeetupPage.route);
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


