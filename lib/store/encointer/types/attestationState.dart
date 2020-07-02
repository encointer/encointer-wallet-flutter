
import 'package:mobx/mobx.dart';
import 'package:polka_wallet/common/components/passwordInputDialog.dart';

import 'attestation.dart';
import 'claimOfAttendance.dart';

@observable
class AttestationState {
  AttestationState(this.pubKey);

  String pubKey;
//  int meetupRegistryIndex;
  bool _attestedOther = false;
  bool _otherAttestedYou = false;
  String _otherAttestation;
  String _yourAttestation;

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

  String get otherAttestation {
    return _otherAttestation;
  }

  set otherAttestation(String attestation) {
    _attestedOther = true;
    otherAttestation= attestation;
  }

  String get yourAttestation {
    return _yourAttestation;
  }

  set yourAttestation(String attestation) {
    _otherAttestedYou = true;
    yourAttestation = attestation;
  }

  @action
  void switchState() {
    _attestedOther = !attestedOther;
    _otherAttestedYou = !otherAttestedYou;
  }

}