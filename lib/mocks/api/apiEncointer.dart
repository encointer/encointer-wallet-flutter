import 'package:encointer_wallet/service/substrateApi/encointer/apiEncointer.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/encointer/types/encointerTypes.dart';
import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:encointer_wallet/store/encointer/types/attestation.dart';
import 'package:encointer_wallet/store/encointer/types/claimOfAttendance.dart';

import '../data/mockEncointerData.dart';

class MockApiEncointer extends ApiEncointer {
  MockApiEncointer(Api api) : super(api);

  @override
  Future<CeremonyPhase> getCurrentPhase() async {
    return store.encointer.currentPhase;
  }

  @override
  Future<int> getCurrentCeremonyIndex() async {
    return 1;
  }

  @override
  Future<int> getParticipantIndex() async {
    return 1;
  }

  @override
  Future<int> getMeetupIndex() async {
    return 1;
  }

  @override
  Future<int> getParticipantCount() async {
    return 3;
  }

  @override
  Future<List<String>> getCommunityIdentifiers() async {
    return meetupRegistry;
  }

  @override
  Future<List<String>> getMeetupRegistry() async {
    return communityIdentifiers;
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
  Future<Attestation> createClaimOfAttendance(int _participants) async {
    return Attestation.fromJson(attestation);
  }

  @override
  Future<Location> getMeetupLocation() async {
    return Location.fromJson(claim['location']);
  }

  @override
  Future<DateTime> getMeetupTime() async {
    return DateTime.fromMillisecondsSinceEpoch(claim['timestamp']);
  }
}
