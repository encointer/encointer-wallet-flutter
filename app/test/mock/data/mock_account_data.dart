List<Map<String, dynamic>> accList = [];

Map<String, dynamic> endoEncointer = {
  'name': 'Endo Encointer',
  'address': '5ERRTmjGuHWjxCJL9aMY7FLLRHGGuen9RJvRy1F7HpCs49So',
  'pubKey': '0x68456e40d8b8d93509699b32f3b1c80fe15475ceb9b46079d71262c1d1f8f02d',
  'meta': {'whenCreated': 1590987392804, 'whenEdited': 1590987392804, 'name': 'Endo Encointer'},
  'mnemonic': 'adjust ability hockey august machine empty cargo monster charge plastic snap gather',
  'memo': null,
  'observation': null
};

Map<String, dynamic> endorphineCointer = {
  'name': 'Endorphine Cointer',
  'address': '5HKczFYLWA3LDZrKN4kK8wmH6pBv6pxiwbYhmhjiN3KHiQHz',
  'pubKey': '0xe88d74f9690f7155c6216246aa061151842641629ca216df71182b8cb3ab0831',
  'meta': {'genesisHash': '', 'name': 'Endorphine Cointer', 'whenCreated': 1616850683478},
  'mnemonic': 'clap mechanic diary rose vital current eyebrow mean limb pulse portion plate',
  'memo': null,
  'observation': null
};

String defaultPin = '1234';

Map<String, dynamic> testAcc = {
  'name': 'test-ttt',
  'address': '158Hhwd6wG84JPTHkX4QuxyZwz7XfMxLa4BRF3c4Ks5giuxs',
  'encoded':
      '0xb49be6cf02d4b199c2d6716b6e9edf819b81f692e09f02ed5cf46f91ba0daf281d01215595f95424a37d52904ff29e9f51ba20c6a554d1ba45f78698b346232c5db86bef04e9c83432df4ee75e62e230ec2071c1a7104b826ceae82d1dfd2f182f16fd906981d3f9da37ae7bb77841532fc65f40ada6cbab6a9ff6470005db88eddcd71ca1aca9f95e9aa20a784616d99c75d8a0b4e444a637b15e2aa2',
  'pubKey': '0xb67fe3812b469da5cac180161851120a45b6c6cf13f5be7062874bfa6cec381f',
  'encoding': {
    'content': ['pkcs8', 'sr25519'],
    'type': 'xsalsa20-poly1305',
    'version': '2'
  },
  'meta': {'whenCreated': 1590987506708, 'whenEdited': 1590987506708, 'name': 'ttt2'},
  'mnemonic': 'new ability hockey august machine empty cargo monster charge plastic snap gather',
  'rawSeed': 'test_seed_new',
  'memo': null,
  'observation': null
};

String currentAccountPubKey = '';

List<dynamic> pubKeys = accList.map((e) => e['pubKey']).toList();

List<Map<String, dynamic>> contactList = [endorphineCointer];

Map<String, dynamic> balancesInfo = {
  'freeBalance': '0x00000000000000000001000000000000',
  'frozenFee': '0x00000000000000000000000000000000',
  'frozenMisc': '0x00000000000000000000000000000000',
  'reservedBalance': '0x00000000000000000000000000000000',
  'votingBalance': '0x00000000000000000000000000000000',
  'availableBalance': '0x00000000000000000000000000000000',
  'lockedBalance': '0x00000000000000000000000000000000',
  'lockedBreakdown': <dynamic>[],
  'vestingLocked': '0x00000000000000000000000000000000',
  'isVesting': false,
  'vestedBalance': '0x00000000000000000000000000000000',
  'vestedClaimable': '0x00000000000000000000000000000000',
  'vestingEndBlock': '0x00000000',
  'vestingPerBlock': '0x00000000000000000000000000000000',
  'vestingTotal': '0x00000000000000000000000000000000',
};

Map<String, dynamic> storage = <String, dynamic>{};
