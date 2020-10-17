import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/activityIndicator.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/qrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/stateMachineWidget.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestation.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class StateMachinePartyB extends StatefulWidget {
  StateMachinePartyB(
    this.store, {
    this.otherMeetupRegistryIndex,
    this.initialAttestationStep,
  }) : super();

  final AppStore store;
  final int otherMeetupRegistryIndex;
  final CurrentAttestationStep initialAttestationStep;

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
    print("Party B: Scanning others' claimA now");
    String claimA = await Navigator.of(context).push(
      MaterialPageRoute<String>(
        builder: (BuildContext context) => ScanQrCode(),
      ),
    );
    if (claimA != null) {
      // back button pressed
      await _attestClaimA(claimA);
    }
  }

  _attestClaimA(String claimAhex) async {
    print("Party B: Received other claim (ClaimA): " + claimAhex.toString());

    // TODO: compare claimA to own. only sign valid claims. complain in UI and show differences otherwise
    // var claimA = await webApi.encointer.parseClaimOfAttendance(claimAhex);
    // print("ClaimA parsed: " + claimA.toString());
    //
    AttestationResult attestationA = await Navigator.of(context).push(
      PageRouteBuilder<AttestationResult>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return ActivityIndicator(
            title: "Attesting ClaimA",
            future: webApi.encointer.attestClaimOfAttendance(claimAhex, "123qwe"),
          );
        },
      ),
    );

    print("Party B: Other attestation (AttA): " + attestationA.attestation.toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    //      store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationA['attestation']);
    // print("Attestation: " + attestationA.toString());

    // store AttestationA (other claim, attested by me)
    print("Party B: Other attestationHex (AttA): " + attestationA.attestationHex);
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, attestationA.attestationHex);
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, CurrentAttestationStep.B2_showAttAClaimB);
    print('Updated Attestation Step: ${CurrentAttestationStep.B2_showAttAClaimB.toString()}');
  }

  _showAttAClaimB() async {
    String attA = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QrCode(
          store,
          title: 'AttestationA | claimB',
          qrCodeData: '$attA:${store.encointer.claimHex}',
        ),
      ),
    );
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, CurrentAttestationStep.B3_scanAttB);
    print('Updated Attestation Step: ${CurrentAttestationStep.B3_scanAttB.toString()}');
  }

  _scanAttestationB() async {
    String attB = await Navigator.of(context).push(
      MaterialPageRoute<String>(
        builder: (BuildContext context) => ScanQrCode(),
      ),
    );
    if (attB != null) {
      // back button was pressed
      await _onScanAttB(attB);
    }
  }

  _onScanAttB(String attB) {
    print("Received AttestastionB: " + attB.toString());

    // TODO: verify signature and complain in UI if bad
    // var attestationB = await webApi.encointer.parseAttestation(attB);
    // print("attestationB parsed: " + attestationB.toString());

    // store AttestationB (my claim, attested by other)
    store.encointer.addYourAttestation(widget.otherMeetupRegistryIndex, attB.toString());
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, CurrentAttestationStep.finished);
    print('Updated Attestation Step: ${CurrentAttestationStep.finished.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    String other = store.encointer.attestations[widget.otherMeetupRegistryIndex].pubKey;

    return Observer(
      builder: (BuildContext context) => StateMachineWidget(
        otherParty: other,
        otherMeetupRegistryIndex: widget.otherMeetupRegistryIndex,
        onBackward: () =>
            _goBackOneStep(store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep),
        onForward: () => _getCurrentAttestationStep(
            store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep),
        onForwardText: _nextStep(store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep),
      ),
    );
  }

  _updateAttestationStep(CurrentAttestationStep step) {
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, step);
    print('Updated Attestation Step: ${step.toString()}');
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
          Navigator.of(context).pop();
          return;
        }
      case CurrentAttestationStep.B1_scanClaimA:
        {
          // _updateAttestationStep(CurrentAttestationStep.none);
          Navigator.of(context).pop();
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
