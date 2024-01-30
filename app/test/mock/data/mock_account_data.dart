List<Map<String, dynamic>> accList = [];

Map<String, dynamic> testAccount1 = {
  'name': 'Test Account 1',
  'address': '5ERRTmjGuHWjxCJL9aMY7FLLRHGGuen9RJvRy1F7HpCs49So',
  'pubKey': '0x68456e40d8b8d93509699b32f3b1c80fe15475ceb9b46079d71262c1d1f8f02d',
  'meta': {'whenCreated': 1590987392804, 'whenEdited': 1590987392804, 'name': 'Test Account 2'},
  'mnemonic': 'adjust ability hockey august machine empty cargo monster charge plastic snap gather',
  'memo': null,
  'observation': null
};

Map<String, dynamic> testAccount2 = {
  'name': 'Test Account 2',
  'address': '5HKczFYLWA3LDZrKN4kK8wmH6pBv6pxiwbYhmhjiN3KHiQHz',
  'pubKey': '0xe88d74f9690f7155c6216246aa061151842641629ca216df71182b8cb3ab0831',
  'meta': {'genesisHash': '', 'name': 'Test Account 2', 'whenCreated': 1616850683478},
  'mnemonic': 'clap mechanic diary rose vital current eyebrow mean limb pulse portion plate',
  'memo': null,
  'observation': null
};

String defaultPin = '1234';

String currentAccountPubKey = '';

List<dynamic> pubKeys = accList.map((e) => e['pubKey']).toList();

List<Map<String, dynamic>> contactList = [testAccount2];

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
