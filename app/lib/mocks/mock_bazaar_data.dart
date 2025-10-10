import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/bazaar/business_data.dart';
import 'package:encointer_wallet/models/bazaar/business_identifier.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_offering.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';

const String controller1 = '0x1cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';
const String controller2 = '0x2cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';
const String controller3 = '0x3cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';

const String businessIpfsCid1 = '0x1ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String businessIpfsCid2 = '0x2ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String businessIpfsCid3 = '0x3ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';

final CommunityIdentifier cid1 = CommunityIdentifier.fromFmtString('gbsuv7YXq9G');
final CommunityIdentifier cid2 = CommunityIdentifier.fromFmtString('fbsuv7YXq9G');

/// EdisonPaula
final CommunityIdentifier cidEdisonPaula = CommunityIdentifier.fromFmtString('u0qj94fxxJ6');

final BusinessIdentifier bid1 = BusinessIdentifier(cid1, controller1);
final BusinessIdentifier bid2 = BusinessIdentifier(cid1, controller2);
final BusinessIdentifier bid3 = BusinessIdentifier(cid1, controller3);

final List<AccountBusinessTuple> allMockBusinesses = [
  AccountBusinessTuple(controller1, BusinessData(businessIpfsCid1, 1)),
  AccountBusinessTuple(controller2, BusinessData(businessIpfsCid2, 1)),
  AccountBusinessTuple(controller3, BusinessData(businessIpfsCid3, 1)),
];

const String offeringIpfsCid1 = '0x67ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String offeringIpfsCid2 = '0x77ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String offeringIpfsCid3 = '0x87ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String offeringIpfsCid4 = '0x97ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';

final OfferingData offeringData1 = OfferingData(url: offeringIpfsCid1);
final OfferingData offeringData2 = OfferingData(url: offeringIpfsCid2);
final OfferingData offeringData3 = OfferingData(url: offeringIpfsCid3);
final OfferingData offeringData4 = OfferingData(url: offeringIpfsCid4);

final Map<BusinessIdentifier, List<OfferingData>> offeringsForBusiness = {
  bid1: business1MockOfferings,
  bid2: business2MockOfferings,
  bid3: [],
};

final List<OfferingData> business1MockOfferings = [
  offeringData1,
  offeringData2,
];

final List<OfferingData> business2MockOfferings = [
  offeringData3,
  offeringData4,
];

final List<OfferingData> allMockOfferings = [
  offeringData1,
  offeringData2,
  offeringData3,
  offeringData4,
];

final ipfsOffering1 =
    IpfsOffering('Cheesecake', 1, 'I am yummy', 'Бишкек, Ala Too Square', 'assets/images/assets/assets_nav_0.png');
final ipfsOffering2 =
    IpfsOffering('шашлы́к', 1, 'I am yummy', 'Бишкек, Ala Too Square', 'assets/images/assets/assets_nav_0.png');
final ipfsOffering3 = IpfsOffering('Harry Potter Heptalogy', 1, 'I am interesting', 'Zürich, Technoparkstrasse 1',
    'assets/images/assets/assets_nav_0.png');
final ipfsOffering4 = IpfsOffering(
    'Picasso Fake as NFT by C.L.', 1, 'I am beautiful', 'Miami Beach', 'assets/images/assets/assets_nav_0.png');

final mockBusinessData = {
  'name': 'HIGHLIGHTED',
  'description': 'wir offerieren kühles Bier',
  'category': 'food',
  'photo': null,
  'address': 'Technoparkstrasse 1, 8005 Zürich',
  'telephone': null,
  'email': null,
  'longitude': '8.515377938747404',
  'latitude': '47.389401263868514',
  'openingHours': 'Mon-Fri 8h-18h',
  'photos': 'QmaQfq6Zr2yCMkSMe8VjSxoYd89hyzcJjeE8jTUG3uXpBG',
  'logo': 'QmcULG6AN5wwMfuwtpsMcjQmFwwUnSHsvSEUFLrCoWMpWh',
  'status': 'highlight',
  'controller': controller1,
};

final IpfsBusiness businessesMockForSingleBusiness = IpfsBusiness.fromJson(mockBusinessData);
