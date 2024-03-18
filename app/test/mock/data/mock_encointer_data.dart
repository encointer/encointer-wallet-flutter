import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:encointer_wallet/models/communities/cid_name.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/store/settings.dart';

const String leuZurich = 'Leu Zurich';
const String bernBaer = 'Bern Bär';
const String buendnerBock = 'Bündner Bock';

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

Map<int, CommunityReputationV1> testReputations = {
  1: CommunityReputationV1(cid, Reputation.VerifiedUnlinked),
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

final List<OfferingData> offeringDataMockList = [OfferingData(url: 'url')];

const itemOfferedMock = {
  'itemOffered': 'QmZ1f6v39DZXdmhLgaGD2i2XY8sucNaMGKJuoSHduqHp15',
  'price': '0',
};

const ipfsProductMock = {
  'name': 'Bier',
  'description': 'Kühles Bier',
  'category': 'food',
  'image': 'Qmeh8yNeDn7WjoMLuRZYAtiE5D5tafTqBaB1RPwyU1pyKK',
  'itemCondition': 'new'
};

final businessesMock = {
  'name': 'Kueche Edison',
  'description': 'bei uns gibt es köstlichen Kaffe',
  'category': 'food',
  'address': 'Technoparkstrasse 1, 8005 Zürich',
  'telephone': null,
  'email': null,
  'longitude': '8.515962660312653',
  'latitude': '47.390349148891545',
  'openingHours': 'Mon-Fri 8h-18h',
  'logo': 'QmUH7W2eAWTfHRYYV1YitZaz54sTjEwv6udjZjh7Tg47Xv',
  'photos': ''
};
