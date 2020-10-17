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
    print("Party A: Showing the claim");
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QrCode(
          store,
          title: 'ClaimA',
          qrCodeData: claimA,
        ),
      ),
    );
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, CurrentAttestationStep.STEP2);
    print('Party A: Updated Attestation Step: ${CurrentAttestationStep.STEP2.toString()}');
  }

  _scanAttAClaimB() async {
    print("Party A: Scanning AttestationA|ClaimB");
    String attAClaimB = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ScanQrCode(),
      ),
    );
    if (attAClaimB != null) {
      // back button pressed
      await onScanAttAClaimB(attAClaimB);
    }
  }

  onScanAttAClaimB(String attestationAClaimB) async {
    var attCla = attestationAClaimB.toString().split(':');
    var attestationAhex = attCla[0];
    var claimBhex = attCla[1];
    print("Party A: Received other claim (ClaimB):" + claimBhex);

    // TODO: compare claimB to own. only sign valid claims. complain in UI and show differences otherwise
    // var claimBjson = await webApi.encointer.parseClaimOfAttendance(claimBhex);
    // print("ClaimB parsed: " + claimBjson.toString());

    // TODO: verify signature and complain in UI if bad
    // var attestationAjson = await webApi.encointer.parseAttestation(attestationAhex);
    // print("attestationA parsed: " + attestationAjson.toString());

    // store AttestationA (my claim, attested by other)
    print("Party A: Store my attestation (AttA): " + attestationAhex);
    store.encointer.addYourAttestation(widget.otherMeetupRegistryIndex, attestationAhex);

    AttestationResult attestationB = await Navigator.of(context).push(
      PageRouteBuilder<AttestationResult>(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => ActivityIndicator(
          title: "Attesting ClaimB",
          future: webApi.encointer.attestClaimOfAttendance(claimBhex, "123qwe"),
        ),
      ),
    );

    print("Party A: Other Attestation (AttB): " + attestationB.attestation.toString());
    // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
    // store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationB['attestation']);
    // print("Attestation: " + attestationB.toString());

    // store AttestationB (other claim, attested by me)
    print("Party A: Store Other AttestationHex (AttB): " + attestationB.attestationHex);
    store.encointer.addOtherAttestation(widget.otherMeetupRegistryIndex, attestationB.attestationHex);
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, CurrentAttestationStep.STEP3);
    print('Party A: Updated Attestation Step: ${CurrentAttestationStep.STEP3.toString()}');
  }

  _showAttestationB() async {
    print("Party A: Showing other Attestation (AttestationB)");
    String attB = store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => QrCode(
          store,
          title: 'AttestationB',
          qrCodeData: attB,
        ),
      ),
    );
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, CurrentAttestationStep.FINISHED);
    print('Party A: Updated Attestation Step: ${CurrentAttestationStep.FINISHED.toString()}');
  }

  _updateAttestationStep(CurrentAttestationStep step) {
    store.encointer.updateAttestationStep(widget.otherMeetupRegistryIndex, step);
    print('Party A: Updated Attestation Step: ${step.toString()}');
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

  String _nextStep(CurrentAttestationStep step) {
    final Map dic = I18n.of(context).encointer;
    switch (step) {
      case CurrentAttestationStep.none:
        {
          return dic['show.your.claim'];
        }
      case CurrentAttestationStep.STEP1:
        {
          return dic['show.your.claim'];
        }
      case CurrentAttestationStep.STEP2:
        {
          return dic['scan.your.attestation.other.claim'];
        }
      case CurrentAttestationStep.STEP3:
        {
          return dic['show.other.attestation'];
        }
      case CurrentAttestationStep.FINISHED:
        {
          return dic['finish'];
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
      case CurrentAttestationStep.STEP1:
        {
          // _updateAttestationStep(CurrentAttestationStep.none);
          Navigator.of(context).pop();
          return;
        }
      case CurrentAttestationStep.STEP2:
        {
          _updateAttestationStep(CurrentAttestationStep.STEP1);
          return;
        }
      case CurrentAttestationStep.STEP3:
        {
          _updateAttestationStep(CurrentAttestationStep.STEP2);
          return;
        }
      case CurrentAttestationStep.FINISHED:
        {
          _updateAttestationStep(CurrentAttestationStep.STEP3);
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
      case CurrentAttestationStep.STEP1:
        {
          return _showClaimA(claim);
        }
      case CurrentAttestationStep.STEP2:
        {
          return _scanAttAClaimB();
        }
      case CurrentAttestationStep.STEP3:
        {
          return _showAttestationB();
        }
      case CurrentAttestationStep.FINISHED:
        {
          Navigator.of(context).pop();
          break;
        }
    }
  }
}
