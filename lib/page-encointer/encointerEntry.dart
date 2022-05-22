import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/page-encointer/phases/assigning/assigningPage.dart';
import 'package:encointer_wallet/page-encointer/phases/attesting/attestingPage.dart';
import 'package:encointer_wallet/page-encointer/phases/registering/registeringPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:focus_detector/focus_detector.dart';

import '../models/index.dart';

/// ceremonies, ceremony
class EncointerEntry extends StatelessWidget {
  EncointerEntry(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    return FocusDetector(
        onFocusLost: () {
          print('[encointerCeremonyPage:FocusDetector] Focus Lost.');
        },
        onFocusGained: () {
          print('[encointerCeremonyPage:FocusDetector] Focus Gained.');
          webApi.encointer.getCommunityMetadata().then((v) => webApi.encointer.getAllMeetupLocations().then((v) =>
              webApi.encointer.getDemurrage().then((v) => webApi.encointer.getBootstrappers().then((v) => webApi
                  .encointer
                  .getReputations()
                  .then((v) => webApi.encointer.getMeetupTime().then((v) => webApi.encointer
                          .getAggregatedAccountData(store.encointer.chosenCid, store.account.currentAddress)
                          .then((v) {
                        print("[encointerCeremonyPage] state is current");
                      })))))));
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dic.encointer.encointer,
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                PhaseAwareBox(store),
                // TODO with observer: indicate when refreshing state
              ],
            ),
          ),
        ));
  }
}

class PhaseAwareBox extends StatefulWidget {
  PhaseAwareBox(this.store);

  static final String route = '/encointer/phaseawarebox';

  final AppStore store;

  @override
  _PhaseAwareBoxState createState() => _PhaseAwareBoxState(store);
}

class _PhaseAwareBoxState extends State<PhaseAwareBox> with SingleTickerProviderStateMixin {
  _PhaseAwareBoxState(this.store);

  final AppStore store;
  bool appConnected = false;

  @override
  void initState() {
    _checkConnectionState();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _checkConnectionState() async {
    appConnected = await webApi.isConnected();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            (store.encointer.currentPhase != null)
                ? Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    CommunityChooserPanel(store),
                    //CeremonyOverviewPanel(store),
                    SizedBox(
                      height: 16,
                    ),
                    appConnected
                        ? Observer(builder: (_) => _getPhaseView(store.encointer.currentPhase))
                        : _getPhaseViewOffline(),
                  ])
                : CupertinoActivityIndicator()
          ],
        ),
      ),
    );
  }

  Widget _getPhaseView(CeremonyPhase phase) {
    //return RegisteringPage(store);
    //return AssigningPage(store);
    //return AttestingPage(store);
    switch (phase) {
      case CeremonyPhase.Registering:
        return RegisteringPage(store);
      case CeremonyPhase.Assigning:
        return AssigningPage(store);
      case CeremonyPhase.Attesting:
        return AttestingPage(store);
      default:
        return Container();
    }
  }

  Widget _getPhaseViewOffline() {
    if (!store.encointer.communityAccount.isRegistered) {
      // no point in showing something here while loading or offline
      return Container();
    } else {
      Duration timeToMeetup = store.encointer.getTimeToMeetup() ?? Duration(hours: 1);
      if (!timeToMeetup.isNegative && timeToMeetup.inMinutes < 10) {
        return AssigningPage(store);
      } else {
        return AttestingPage(store);
      }
    }
  }
}
