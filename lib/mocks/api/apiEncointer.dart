import 'package:encointer_wallet/mocks/data/mockEncointerData.dart';
import 'package:encointer_wallet/service/substrateApi/encointer/apiEncointer.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/store/encointer/types/encointerTypes.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/store/encointer/types/attestation.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';
import 'package:encointer_wallet/store/encointer/types/proofOfAttendance.dart';

class MockApiEncointer extends ApiEncointer {
  MockApiEncointer(Api api) : super(api);

  void _log(String msg) {
    print("[mockApiAssets] $msg");
  }

  @override
  Future<void> startSubscriptions() async {
    _log("startSubscriptions stub");

    // put some initial values in the store that never update
    getCurrentPhase();
    getCommunityIdentifiers();
    getEncointerBalance();
  }

  @override
  Future<void> stopSubscriptions() async {
    _log("empty stopSubscriptions stub");
  }

  @override
  Future<CeremonyPhase> getCurrentPhase() async {
    if (store.encointer.currentPhase == null) {
      store.encointer.setCurrentPhase(initialPhase);
    }

    return store.encointer.currentPhase;
  }

  @override
  Future<int> getCurrentCeremonyIndex() async {
    if (store.encointer.currentCeremonyIndex == null) {
      store.encointer.setCurrentCeremonyIndex(1);
    }
    return store.encointer.currentCeremonyIndex;
  }

  @override
  Future<void> getEncointerBalance() async {
    store.encointer.addBalanceEntry(cid, BalanceEntry.fromJson(balanceEntry));
  }

  @override
  Future<int> getParticipantIndex() async {
    if (store.encointer.participantIndex == null) {
      store.encointer.setMeetupIndex(1);
    }
    return store.encointer.participantIndex;
  }

  @override
  Future<int> getMeetupIndex() async {
    if (store.encointer.meetupIndex == null) {
      store.encointer.setParticipantIndex(1);
    }
    return store.encointer.meetupIndex;
  }

  @override
  Future<int> getParticipantCount() async {
    return 3;
  }

  @override
  Future<List<String>> getCommunityIdentifiers() async {
    store.encointer.setCommunityIdentifiers(communityIdentifiers);
    return communityIdentifiers;
  }

  @override
  Future<List<String>> getMeetupRegistry() async {
    if (store.encointer.meetupRegistry == null) {
      store.encointer.setMeetupRegistry(meetupRegistry);
    }
    return store.encointer.meetupRegistry;
  }

  @override
  Future<AttestationResult> attestClaimOfAttendance(String _claimHex, String _password) async {
    return AttestationResult.fromJson(attestationMap);
  }

  @override
  Future<ClaimOfAttendance> parseClaimOfAttendance(String _claimHex) async {
    return Future.value(ClaimOfAttendance.fromJson(claim));
  }

  @override
  Future<Attestation> parseAttestation(String _attestationHex) async {
    return Attestation.fromJson(attestation);
  }

  @override
  void createClaimOfAttendance(int _participants) {
    if (store.encointer.myClaim == null) {
      store.encointer.setMyClaim(ClaimOfAttendance.fromJson(claim));
    }
  }

  @override
  Future<void> getMeetupLocation() async {
    if (store.encointer.meetupLocation == null) {
      store.encointer.setMeetupLocation(Location.fromJson(claim['location']));
    }
  }

  @override getShopRegistry() async {
    _log("warn: getShopRegistry mock is unimplemented");
  }

  @override
  Future<DateTime> getMeetupTime() async {
    if (store.encointer.meetupTime == null) {
      store.encointer.setMeetupTime(claim['timestamp']);
    }

    return DateTime.fromMillisecondsSinceEpoch(claim['timestamp']);
  }
}
