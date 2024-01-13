import 'package:encointer_wallet/store/account/services/legacy_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:ew_storage/ew_storage.dart' show SecureStorageMock;

import '../mock/mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AccountStore test', () {
    final root = AppStore(MockLocalStorage(), SecureStorageMock(), LegacyLocalStorageMock());

    test('account store test', () async {
      await root.init('_en');
      final store = root.account;

      /// add account
      const testPass = 'a111111';
      await store.addAccount(testAccount1, testPass, name: testAccount1['name'] as String);
      expect(store.accountList.length, 1);
      await store.setCurrentAccount(testAccount1['pubKey'] as String);
      expect(store.currentAccountPubKey, testAccount1['pubKey']);
      expect(store.currentAccount.name, testAccount1['name'] as String);
      expect(store.currentAccount.pubKey, testAccount1['pubKey']);
      expect(store.currentAccount.address, testAccount1['address']);

      await store.addAccount(testAccount2, testPass, name: testAccount2['name'] as String);
      expect(store.accountList.length, 2);
      await store.setCurrentAccount(testAccount2['pubKey'] as String);
      expect(store.currentAccountPubKey, testAccount2['pubKey']);
      expect(store.currentAccount.name, testAccount2['name'] as String);
      expect(store.currentAccount.pubKey, testAccount2['pubKey']);
      expect(store.currentAccount.address, testAccount2['address']);

      expect(store.optionalAccounts.length, 1);
      expect(store.optionalAccounts[0].pubKey, testAccount1['pubKey']);
      expect(store.optionalAccounts[0].name, testAccount1['name']);
      expect(store.optionalAccounts[0].pubKey, testAccount1['pubKey']);
      expect(store.optionalAccounts[0].address, testAccount1['address']);

      /// update account
      await store.updateAccountName(store.currentAccount, 'test-change');
      expect(store.currentAccount.name, 'test-change');
      expect(store.currentAccount.pubKey, testAccount2['pubKey']);
      expect(store.currentAccount.address, testAccount2['address']);

      /// update works after reload
      await store.loadAccount();
      expect(store.currentAccount.name, 'test-change');
      expect(store.currentAccount.pubKey, testAccount2['pubKey']);
      expect(store.currentAccount.address, testAccount2['address']);

      /// change account
      await store.setCurrentAccount(testAccount1['pubKey'] as String);
      expect(store.currentAccountPubKey, testAccount1['pubKey']);
      expect(store.currentAccount.name, testAccount1['name']);
      expect(store.currentAccount.pubKey, testAccount1['pubKey']);
      expect(store.currentAccount.address, testAccount1['address']);
      expect(store.optionalAccounts[0].pubKey, testAccount2['pubKey']);
      expect(store.optionalAccounts[0].name, 'test-change');
      expect(store.optionalAccounts[0].pubKey, testAccount2['pubKey']);
      expect(store.optionalAccounts[0].address, testAccount2['address']);

      await store.setCurrentAccount(testAccount2['pubKey'] as String);
      expect(store.currentAccountPubKey, testAccount2['pubKey']);
      expect(store.currentAccount.name, 'test-change');
      expect(store.currentAccount.pubKey, testAccount2['pubKey']);
      expect(store.currentAccount.address, testAccount2['address']);

      /// remove account
      await store.removeAccount(store.currentAccount);
      expect(store.accountList.length, 1);
      expect(store.currentAccountPubKey, testAccount1['pubKey']);
      expect(store.currentAccount.name, testAccount1['name']);
      expect(store.currentAccount.pubKey, testAccount1['pubKey']);
      expect(store.currentAccount.address, testAccount1['address']);
      expect(store.optionalAccounts.length, 0);

      /// add observation account
      final contact = <String, dynamic>{
        'name': 'gav',
        'address': 'FcxNWVy5RESDsErjwyZmPCW6Z8Y3fbfLzmou34YZTrbcraL',
        'pubKey': '0x86b7409a11700afb027924cb40fa43889d98709ea35319d48fea85dd35004e64',
        'observation': true,
      };
      await root.settings.addContact(contact);
      expect(store.accountListAll.length, 2);
      expect(store.optionalAccounts.length, 1);

      /// change to observation account
      await store.setCurrentAccount(contact['pubKey'] as String);
      expect(store.currentAccountPubKey, contact['pubKey']);
      expect(store.currentAccount.name, contact['name']);
      expect(store.currentAccount.pubKey, contact['pubKey']);
      expect(store.currentAccount.address, contact['address']);
      expect(store.optionalAccounts[0].pubKey, testAccount1['pubKey']);
      expect(store.optionalAccounts[0].name, testAccount1['name']);
      expect(store.optionalAccounts[0].pubKey, testAccount1['pubKey']);
      expect(store.optionalAccounts[0].address, testAccount1['address']);

      /// update observation account
      final contactNew = Map<String, dynamic>.of(contact);
      contactNew['name'] = 'changed-observation';
      await root.settings.updateContact(contactNew);
      expect(store.currentAccount.name, 'changed-observation');
    });
  });
}
