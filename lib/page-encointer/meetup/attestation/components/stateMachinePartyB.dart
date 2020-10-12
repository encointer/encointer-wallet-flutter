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
    // var claimAhex = await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: {'onScan': _attestClaimA});
    // print("Received ClaimA: " + claimAhex.toString());

    return ScanQrCode(
      onScan: _attestClaimA,
    );

    // var claimA = await webApi.encointer.parseClaimOfAttendance(claimAhex);
    // print("ClaimA parsed: " + claimA.toString());
    // TODO: compare claimA to own. only sign valid claims. complain in UI and show differences otherwise
  }

  _attestClaimA(String claimAhex) async {
    print("Received ClaimA: " + claimAhex.toString());

    Map res = await Navigator.of(context).push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      return ActivityIndicator(
          title: "Attesting ClaimA", future: webApi.encointer.attestClaimOfAttendance(claimAhex, "123qwe"));
    }));

    print("att: " + res['attestation'].toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    //      store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(res['attestation']);
    print("Attestation: " + res.toString());

    //other claim, attested by me
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, res['attestationHex'].toString());
    _updateAttestationStep(CurrentAttestationStep.showingAttAClaimB);
  }

  Widget _showAttAClaimB() {
    // var args = {
    //   "title": 'AttestationA | claimB',
    //   'qrCodeData': attestationAHex + ":" + widget.claim,
    // };
    // await Navigator.of(context).pushNamed(QrCode.route, arguments: args);
    String attA = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    return QrCode(
      store,
      onPressed: _updateAttestationStep(CurrentAttestationStep.scanningAttB),
      title: 'AttestationA | claimB',
      qrCodeData: '$attA:${store.encointer.claimHex}',
    );
  }

  Widget _scanAttestationB() {
    // var attB = await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: {'onScan': onScan});
    // print("Received AttestastionB: " + attB.toString());

    return ScanQrCode(
      onScan: _onScanAttB,
    );
    //
    // var attestationB = await webApi.encointer.parseAttestation(attB);
    // print("attestationB parsed: " + attestationB.toString());
    // TODO: verify signature and complain in UI if bad

    // store AttestationB (my claim, attested by other)
    // store.encointer.addYourAttestation(widget.otherMeetupRegistryIndex, attB.toString());
  }

  _onScanAttB(String attB) {
    print("Received AttestastionB: " + attB.toString());
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
      default:
        {
          return _scanClaimA();
        }
    }
  }
}
