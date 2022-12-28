import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/store/settings.dart';

const String leuZurich = 'Leu Zurich';
const String bernBaer = 'Bern Bär';
const String buendnerBock = 'Bündner Bock';
const String zul = 'ZUL';
CommunityIdentifier cid = CommunityIdentifier.fromFmtString('gbsuv7YXq9G');
CommunityIdentifier cid2 = CommunityIdentifier.fromFmtString('hbsuv7YXq9G');
CommunityIdentifier cid3 = CommunityIdentifier.fromFmtString('dbsuv7YXq9G');

List<CommunityIdentifier> testCommunityIdentifiers = [
  cid,
  cid2,
  cid3,
];

List<CidName> testCommunities = [
  CidName(cid, leuZurich),
  CidName(cid2, bernBaer),
  CidName(cid3, buendnerBock),
];

Map<int, CommunityReputation> testReputations = {
  1: CommunityReputation(cid, Reputation.VerifiedUnlinked),
};

const Map<String, dynamic> communityMetadata = {
  'name': 'Züri Loi',
  'symbol': 'ZUL',
  'assets': 'ShouldBeValidCidSometime',
  'theme': null,
  'url': null
};

const double demurrage = 1.1267607882072287e-7;

const testTimeStamp = 1592719549549;

const List<String> testMeetupRegistry = [
  '0xb67fe3812b469da5cac180161851120a45b6c6cf13f5be7062874bfa6cec381f',
  '0x1bb4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c',
  '0x1cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c',
];

const Map<CeremonyPhase, int> testPhaseDurations = {
  CeremonyPhase.Registering: 57600000,
  CeremonyPhase.Attesting: 172800000,
  CeremonyPhase.Assigning: 28800000,
};

const CeremonyPhase initialPhase = CeremonyPhase.Registering;

const Map<String, dynamic> testBalanceEntry = {'principal': 23.4, 'lastUpdate': 4};

Location testLocation1 = Location.fromJson({'lat': '18.2341235412345', 'lon': '35.18324513451'});
Location testLocation2 = Location.fromJson({'lat': '18.3341235412345', 'lon': '35.28324513451'});
Location testLocation3 = Location.fromJson({'lat': '18.4341235412345', 'lon': '35.38324513451'});

EndpointData unitTestEndpoint = EndpointData.fromJson({
  'info': 'unit-test-network',
  'ss58': 42,
  'text': 'Unit-Test endpoint data',
  'value': 'Unit-Test network must not connect to a node',
  'overrideConfig': Map<String, dynamic>.of({}),
  'ipfsGateway': 'Unit-Test network must no connect to ipfs'
});
