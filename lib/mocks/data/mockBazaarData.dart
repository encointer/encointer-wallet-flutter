import 'package:encointer_wallet/store/encointer/types/bazaar.dart';


const String controller1 = '0x1cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';
const String controller2 = '0x2cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';
const String controller3 = '0x3cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';
const String controller4 = '0x4cc4e46bbd2bb547d93d952c5de12ea7e3a3f3b638551a8eaf35ad086700c00c';

const String business_ipfs_cid1 = '0x1ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String business_ipfs_cid2 = '0x2ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String business_ipfs_cid3 = '0x3ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String business_ipfs_cid4 = '0x4ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';

const String cid1 = '0x5ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';
const String cid2 = '0x6ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989';

final List<AccountBusinessTuple> allMockBusinesses = [
  AccountBusinessTuple(controller1, BusinessData(business_ipfs_cid1, 1)),
  AccountBusinessTuple(controller2, BusinessData(business_ipfs_cid2, 1)),
  AccountBusinessTuple(controller3, BusinessData(business_ipfs_cid3, 1)),
  AccountBusinessTuple(controller4, BusinessData(business_ipfs_cid4, 1)),
];

final OfferingData offeringData1 = OfferingData('0x67ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989');
final OfferingData offeringData2 = OfferingData('0x77ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989');
final OfferingData offeringData3 = OfferingData('0x87ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989');
final OfferingData offeringData4 = OfferingData('0x97ebf164a5bb618ec6caad31488161b237e24d75efa3040286767b620d9183989');

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