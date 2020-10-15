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

class StateMachinePartyA extends StatefulWidget {
  StateMachinePartyA(
    this.store, {
    this.otherMeetupRegistryIndex,
  }) : super();

  final AppStore store;
  final int otherMeetupRegistryIndex;

  @override
  _StateMachinePartyAState createState() {
    return _StateMachinePartyAState(store);
  }
}

class _StateMachinePartyAState extends State<StateMachinePartyA> {
  _StateMachinePartyAState(this.store);

  final AppStore store;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _showClaimA(String claimA) async {
    print("I'm party A. showing my claim now");

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QrCode(
          store,
          onPressed: () => _updateAttestationStep(CurrentAttestationStep.A2_scanAttAClaimB),
          title: 'ClaimA',
          qrCodeData: claimA,
        ),
      ),
    );
  }

  _scanAttAClaimB() async {
    print("Party A is Scanning AttestationA|ClaimB");
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ScanQrCode(
          onScan: _onScanAttAClaimB,
        ),
      ),
    );
  }

  _onScanAttAClaimB(String attestationAClaimB) async {
    var attCla = attestationAClaimB.toString().split(':');
    var attestationAhex = attCla[0];
    var claimBhex = attCla[1];
    print("Attestation received by QR code: " + attestationAhex);
    print("Claim received by qrCode:" + claimBhex);

    // TODO: compare claimB to own. only sign valid claims. complain in UI and show differences otherwise
    // var claimBjson = await webApi.encointer.parseClaimOfAttendance(claimBhex);
    // print("ClaimB parsed: " + claimBjson.toString());

    // TODO: verify signature and complain in UI if bad
    // var attestationAjson = await webApi.encointer.parseAttestation(attestationAhex);
    // print("attestationA parsed: " + attestationAjson.toString());

    // store AttestationA (my claim, attested by other)
    store.encointer.addYourAttestation(widget.otherMeetupRegistryIndex, attestationAhex);

    Map attestationB = await Navigator.of(context).push(
      MaterialPageRoute<Map>(
        builder: (BuildContext context) => ActivityIndicator(
          title: "Attesting ClaimB",
          future: webApi.encointer.attestClaimOfAttendance(claimBhex, "123qwe"),
        ),
      ),
    );

    print("att: " + attestationB['attestation'].toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    // store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationB['attestation']);
    // print("Attestation: " + attestationB.toString());

    // store AttestationB (other claim, attested by me)
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, attestationB['attestationHex'].toString());
    _updateAttestationStep(CurrentAttestationStep.A3_showAttB);
  }

  _showAttestationB() async {
    print("Showing other Attestation (AttestationB)");
    String attB = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QrCode(
          store,
          onPressed: () => _updateAttestationStep(CurrentAttestationStep.finished),
          title: 'AttestationB',
          qrCodeData: attB,
        ),
      ),
    );
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
          return dic['show.your.claim'];
        }
      case CurrentAttestationStep.A1_showClaimA:
        {
          return dic['show.your.claim'];
        }
      case CurrentAttestationStep.A2_scanAttAClaimB:
        {
          return dic['scan.your.attestation.other.claim'];
        }
      case CurrentAttestationStep.A3_showAttB:
        {
          return dic['show.other.attestation'];
        }
      case CurrentAttestationStep.finished:
        {
          return dic['finish'];
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          return dic['show.your.claim'];
        }
      case CurrentAttestationStep.B2_showAttAClaimB:
        {
          return dic['show.your.claim'];
        }
      case CurrentAttestationStep.B3_scanAttB:
        {
          return dic['show.your.claim'];
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
      case CurrentAttestationStep.A1_showClaimA:
        {
          _updateAttestationStep(CurrentAttestationStep.A1_showClaimA);
          return;
        }
      case CurrentAttestationStep.A2_scanAttAClaimB:
        {
          _updateAttestationStep(CurrentAttestationStep.A1_showClaimA);
          return;
        }
      case CurrentAttestationStep.A3_showAttB:
        {
          _updateAttestationStep(CurrentAttestationStep.A2_scanAttAClaimB);
          return;
        }
      case CurrentAttestationStep.finished:
        {
          _updateAttestationStep(CurrentAttestationStep.A3_showAttB);
          return;
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          _printInvalidStateMsg(step);
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
      case CurrentAttestationStep.B2_showAttAClaimB:
        {
          _printInvalidStateMsg(step);
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
      case CurrentAttestationStep.B3_scanAttB:
        {
          _printInvalidStateMsg(step);
          _updateAttestationStep(CurrentAttestationStep.none);
          return;
        }
    }
  }

  _getCurrentAttestationStep(CurrentAttestationStep step) {
    final String claim = store.encointer.claimHex;
    switch (step) {
      case CurrentAttestationStep.none:
        {
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.A1_showClaimA:
        {
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.A2_scanAttAClaimB:
        {
          return _scanAttAClaimB();
        }
      case CurrentAttestationStep.A3_showAttB:
        {
          return _showAttestationB();
        }
      case CurrentAttestationStep.finished:
        {
          Navigator.of(context).pop();
          break;
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          _printInvalidStateMsg(step);
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.B2_showAttAClaimB:
        {
          _printInvalidStateMsg(step);
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.B3_scanAttB:
        {
          _printInvalidStateMsg(step);
          return _showClaimA(claim);
        }
    }
  }

  _printInvalidStateMsg(CurrentAttestationStep invalidStep) {
    print(
        "Have invalid attestationState for party A: $invalidStep. Resetting to ${CurrentAttestationStep.A1_showClaimA}");
  }
}
