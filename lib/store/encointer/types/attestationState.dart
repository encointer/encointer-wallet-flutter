
import 'package:mobx/mobx.dart';
import 'package:polka_wallet/common/components/passwordInputDialog.dart';

import 'claimOfAttendance.dart';

@observable
class AttestationState {
  AttestationState(this.pubKey);

  String pubKey;
//  int meetupRegistryIndex;
  bool _attestedOther = false;
  bool _otherAttestedYou = false;
  Attestation _otherAttestation;
  Attestation _yourAttestation;

  @observable
  bool get attestedOther {
    return _attestedOther;
  }

  @observable
  bool get otherAttestedYou {
    return _otherAttestedYou;
  }

  @computed
  bool get complete { return this._attestedOther && this._otherAttestedYou; }

  Attestation get otherAttestation {
    return _otherAttestation;
  }

  set otherAttestation(Attestation attestation) {
    _attestedOther = true;
    otherAttestation= attestation;
  }

  Attestation get yourAttestation {
    return _yourAttestation;
  }

  set yourAttestation(Attestation attestation) {
    _otherAttestedYou = true;
    yourAttestation = attestation;
  }

  @action
  void switchState() {
    _attestedOther = !attestedOther;
    _otherAttestedYou = !otherAttestedYou;
  }

}

class Attestation {
  ClaimOfAttendance claim;
  String signature;
  String publicKey;
}