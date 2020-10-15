import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/activityIndicator.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/qrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class StateMachinePartyB extends StatefulWidget {
  StateMachinePartyB(
    this.store, {
    this.otherMeetupRegistryIndex,
  }) : super();

  final AppStore store;
  final int otherMeetupRegistryIndex;

  @override
  _StateMachinePartyBState createState() {
    return _StateMachinePartyBState(store);
  }
}

class _StateMachinePartyBState extends State<StateMachinePartyB> {
  _StateMachinePartyBState(this.store);

  final AppStore store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _scanClaimA() async {
    print("I'm party B. scanning others' claimA now");
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ScanQrCode(
          onScan: _attestClaimA,
        ),
      ),
    );
  }

  _attestClaimA(String claimAhex) async {
    print("Received ClaimA: " + claimAhex.toString());

    // TODO: compare claimA to own. only sign valid claims. complain in UI and show differences otherwise
    // var claimA = await webApi.encointer.parseClaimOfAttendance(claimAhex);
    // print("ClaimA parsed: " + claimA.toString());

    Map attestationA = await Navigator.of(context).push(
      MaterialPageRoute<Map>(
        builder: (BuildContext context) {
          return ActivityIndicator(
            title: "Attesting ClaimA",
            future: webApi.encointer.attestClaimOfAttendance(claimAhex, "123qwe"),
          );
        },
      ),
    );

    print("att: " + attestationA['attestation'].toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    //      store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationA['attestation']);
    // print("Attestation: " + attestationA.toString());

    // store AttestationA (other claim, attested by me)
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, attestationA['attestationHex'].toString());
    _updateAttestationStep(CurrentAttestationStep.B2_showAttAClaimB);
  }

  _showAttAClaimB() async {
    String attA = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QrCode(
          store,
          onPressed: () => _updateAttestationStep(CurrentAttestationStep.B3_scanAttB),
          title: 'AttestationA | claimB',
          qrCodeData: '$attA:${store.encointer.claimHex}',
        ),
      ),
    );
  }

  _scanAttestationB() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ScanQrCode(
          onScan: _onScanAttB,
        ),
      ),
    );
  }

  _onScanAttB(String attB) {
    print("Received AttestastionB: " + attB.toString());

    // TODO: verify signature and complain in UI if bad
    // var attestationB = await webApi.encointer.parseAttestation(attB);
    // print("attestationB parsed: " + attestationB.toString());

    // store AttestationB (my claim, attested by other)
    store.encointer.addYourAttestation(widget.otherMeetupRegistryIndex, attB.toString());
    _updateAttestationStep(CurrentAttestationStep.finished);
  }

  _updateAttestationStep(CurrentAttestationStep step) {
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, step);
    print('Updated Attestation Step: ${step.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    String other = store.encointer.attestations[widget.otherMeetupRegistryIndex].pubKey;
    final Map dic = I18n.of(context).encointer;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("${dic['attestation.performing.with']}: ${Fmt.address(other)}"),
          ButtonBar(
            children: <Widget>[
              RoundedButton(
                text: dic['go.back'],
                onPressed: () => _goBackOneStep(
                    store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep),
              ),
              Observer(
                builder: (_) => RoundedButton(
                  text:
                      "${dic['next.step']}: ${_nextStep(store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep)}",
                  onPressed: () => _getCurrentAttestationStep(
                      store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _nextStep(CurrentAttestationStep step) {
    final Map dic = I18n.of(context).encointer;
    switch (step) {
      case CurrentAttestationStep.none:
        {
          return dic['scan.other.claim'];
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          return dic['scan.other.claim'];
        }
      case CurrentAttestationStep.B2_showAttAClaimB:
        {
          return dic['show.other.attestation.your.claim'];
        }
      case CurrentAttestationStep.B3_scanAttB:
        {
          return dic['scan.your.attestation'];
        }
      case CurrentAttestationStep.finished:
        {
          return dic['finish'];
        }
      case CurrentAttestationStep.A1_showClaimA:
        {
          return dic['scan.other.claim'];
        }
      case CurrentAttestationStep.A2_scanAttAClaimB:
        {
          return dic['scan.other.claim'];
        }
      case CurrentAttestationStep.A3_showAttB:
        {
          return dic['scan.other.claim'];
        }
    }
  }

  void _goBackOneStep(CurrentAttestationStep step) {
    switch (step) {
      case CurrentAttestationStep.none:
        {
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
      case CurrentAttestationStep.B2_showAttAClaimB:
        {
          _updateAttestationStep(CurrentAttestationStep.B1_scanClaimA);
          return;
        }
      case CurrentAttestationStep.B3_scanAttB:
        {
          _updateAttestationStep(CurrentAttestationStep.B2_showAttAClaimB);
          return;
        }
      case CurrentAttestationStep.finished:
        {
          _updateAttestationStep(CurrentAttestationStep.B3_scanAttB);
          return;
        }
      case CurrentAttestationStep.A1_showClaimA:
        {
          _printInvalidStateMsg(step);
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
      case CurrentAttestationStep.A2_scanAttAClaimB:
        {
          _printInvalidStateMsg(step);
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
      case CurrentAttestationStep.A3_showAttB:
        {
          _printInvalidStateMsg(step);
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
    }
  }

  _getCurrentAttestationStep(CurrentAttestationStep step) {
    switch (step) {
      case CurrentAttestationStep.none:
        {
          return _scanClaimA();
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          return _scanClaimA();
        }
      case CurrentAttestationStep.B2_showAttAClaimB:
        {
          return _showAttAClaimB();
        }
      case CurrentAttestationStep.B3_scanAttB:
        {
          return _scanAttestationB();
        }
      case CurrentAttestationStep.finished:
        {
          Navigator.of(context).pop();
          break;
        }
      case CurrentAttestationStep.A1_showClaimA:
        {
          _printInvalidStateMsg(step);
          return _scanClaimA();
        }
      case CurrentAttestationStep.A2_scanAttAClaimB:
        {
          _printInvalidStateMsg(step);
          return _scanClaimA();
        }
      case CurrentAttestationStep.A3_showAttB:
        {
          _printInvalidStateMsg(step);
          return _scanClaimA();
        }
    }
  }

  _printInvalidStateMsg(CurrentAttestationStep invalidStep) {
    print(
        "Have invalid attestationState for party A: $invalidStep. Resetting to ${CurrentAttestationStep.A1_showClaimA}");
  }
}
