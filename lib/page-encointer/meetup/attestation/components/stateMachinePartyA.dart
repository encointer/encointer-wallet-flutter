import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:polka_wallet/common/components/activityIndicator.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/qrCode.dart';
import 'package:polka_wallet/page-encointer/meetup/attestation/components/scanQrCode.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestationState.dart';

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

  Widget _showClaimA(String claimA) {
    print("I'm party A. showing my claim now");
    return QrCode(
      store,
      onPressed: _updateAttestationStep(CurrentAttestationStep.scanningAttAClaimB),
      title: 'ClaimA',
      qrCodeData: claimA,
    );
  }

  Widget _scanAttAClaimB() {
    return ScanQrCode(
      onScan: _onScanAttAClaimB,
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

    Map attestationB = await Navigator.of(context).push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ActivityIndicator(
          title: "Attesting ClaimB", future: webApi.encointer.attestClaimOfAttendance(claimBhex, "123qwe"));
    }));

    print("att: " + attestationB['attestation'].toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    // store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationB['attestation']);
    // print("Attestation: " + attestationB.toString());

    // store AttestationB (other claim, attested by me)
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, attestationB['attestationHex'].toString());
    _updateAttestationStep(CurrentAttestationStep.showAttB);
  }

  Widget _showAttestationB() {
    String attB = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    return QrCode(
      store,
      onPressed: _updateAttestationStep(CurrentAttestationStep.finished),
      title: 'AttestationB',
      qrCodeData: attB,
    );
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
    final String claim = store.encointer.claimHex;
    switch (step) {
      case CurrentAttestationStep.none:
        {
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.showingClaimA:
        {
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.scanningAttAClaimB:
        {
          return _scanAttAClaimB();
        }
      case CurrentAttestationStep.showAttB:
        {
          return _showAttestationB();
        }
      case CurrentAttestationStep.finished:
        {
          Navigator.of(context).pop();
          break;
        }
      case CurrentAttestationStep.scanningClaimA:
        {
          _printInvalidStateMsg(step);
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.showingAttAClaimB:
        {
          _printInvalidStateMsg(step);
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.scanningAttB:
        {
          _printInvalidStateMsg(step);
          return _showClaimA(claim);
        }
    }
  }

  _printInvalidStateMsg(CurrentAttestationStep invalidStep) {
    print(
        "Have invalid attestationState for party A: $invalidStep. Resetting to ${CurrentAttestationStep.showingClaimA}");
  }
}
