import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/activityIndicator.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/qrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';

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

  Widget _scanClaimA() {
    print("I'm party B. scanning others' claimA now");
    return ScanQrCode(
      onScan: _attestClaimA,
    );
  }

  _attestClaimA(String claimAhex) async {
    print("Received ClaimA: " + claimAhex.toString());

    // TODO: compare claimA to own. only sign valid claims. complain in UI and show differences otherwise
    // var claimA = await webApi.encointer.parseClaimOfAttendance(claimAhex);
    // print("ClaimA parsed: " + claimA.toString());

    Map attestationA = await Navigator.of(context).push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ActivityIndicator(
          title: "Attesting ClaimA", future: webApi.encointer.attestClaimOfAttendance(claimAhex, "123qwe"));
    }));

    print("att: " + attestationA['attestation'].toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    //      store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationA['attestation']);
    // print("Attestation: " + attestationA.toString());

    // store AttestationA (other claim, attested by me)
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, attestationA['attestationHex'].toString());
    _updateAttestationStep(CurrentAttestationStep.showingAttAClaimB);
  }

  Widget _showAttAClaimB() {
    String attA = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    return QrCode(
      store,
      onPressed: _updateAttestationStep(CurrentAttestationStep.scanningAttB),
      title: 'AttestationA | claimB',
      qrCodeData: '$attA:${store.encointer.claimHex}',
    );
  }

  Widget _scanAttestationB() {
    return ScanQrCode(
      onScan: _onScanAttB,
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
    return Scaffold(
      body: Observer(
        builder: (_) => _getCurrentAttestationStep(
            store.encointer.attestations[widget.otherMeetupRegistryIndex].currentAttestationStep),
      ),
    );
  }

  Widget _getCurrentAttestationStep(CurrentAttestationStep step) {
    switch (step) {
      case CurrentAttestationStep.none:
        {
          return _scanClaimA();
        }
      case CurrentAttestationStep.scanningClaimA:
        {
          return _scanClaimA();
        }
      case CurrentAttestationStep.showingAttAClaimB:
        {
          return _showAttAClaimB();
        }
      case CurrentAttestationStep.scanningAttB:
        {
          return _scanAttestationB();
        }
      case CurrentAttestationStep.finished:
        {
          Navigator.of(context).pop();
          break;
        }
      case CurrentAttestationStep.showingClaimA:
        {
          _printInvalidStateMsg(step);
          return _scanClaimA();
        }
      case CurrentAttestationStep.scanningAttAClaimB:
        {
          _printInvalidStateMsg(step);
          return _scanClaimA();
        }
      case CurrentAttestationStep.showAttB:
        {
          _printInvalidStateMsg(step);
          return _scanClaimA();
        }
    }
  }

  _printInvalidStateMsg(CurrentAttestationStep invalidStep) {
    print(
        "Have invalid attestationState for party A: $invalidStep. Resetting to ${CurrentAttestationStep.showingClaimA}");
  }
}
