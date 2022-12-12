import 'package:encointer_wallet/config.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/store/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AccountStore test', () {
    final root = AppStore(
      MockLocalStorage(),
      config: const AppConfig(isTest: true, mockSubstrateApi: true),
    );

    test('account store test', () async {
      accList = [testAcc];
      currentAccountPubKey = accList[0]['pubKey'] as String;

      await root.init('_en');
      final store = root.account;

      /// accounts load
      expect(store.accountList.length, 1);
      expect(store.currentAccountPubKey, accList[0]['pubKey']);
      expect(store.currentAccount.name, accList[0]['name']);
      expect(store.currentAccount.pubKey, accList[0]['pubKey']);
      expect(store.currentAccount.address, accList[0]['address']);

      /// create new account
      store.setNewAccountName('test');
      store.setNewAccountPin('a111111');
      expect(store.newAccount.name, 'test');
      expect(store.newAccount.password, 'a111111');
      store.setNewAccountKey('new_key');
      expect(store.newAccount.key, 'new_key');

      /// add account
      const testPass = 'a111111';
      await store.addAccount(endoEncointer, testPass);
      expect(store.accountList.length, 2);
      store.setCurrentAccount(endoEncointer['pubKey'] as String);
      expect(store.currentAccountPubKey, endoEncointer['pubKey']);
      expect(store.currentAccount.name, 'test');
      expect(store.currentAccount.pubKey, endoEncointer['pubKey']);
      expect(store.currentAccount.address, endoEncointer['address']);
      expect(store.optionalAccounts.length, 1);
      expect(store.optionalAccounts[0].pubKey, accList[0]['pubKey']);
      expect(store.optionalAccounts[0].name, accList[0]['name']);
      expect(store.optionalAccounts[0].pubKey, accList[0]['pubKey']);
      expect(store.optionalAccounts[0].address, accList[0]['address']);

      /// update account
      await store.updateAccountName(store.currentAccount, 'test-change');
      expect(store.currentAccount.name, 'test-change');
      expect(store.currentAccount.pubKey, endoEncointer['pubKey']);
      expect(store.currentAccount.address, endoEncointer['address']);

      /// update works after reload
      await store.loadAccount();
      expect(store.currentAccount.name, 'test-change');
      expect(store.currentAccount.pubKey, endoEncointer['pubKey']);
      expect(store.currentAccount.address, endoEncointer['address']);

      /// change account
      store.setCurrentAccount(accList[0]['pubKey'] as String);
      expect(store.currentAccountPubKey, accList[0]['pubKey']);
      expect(store.currentAccount.name, accList[0]['name']);
      expect(store.currentAccount.pubKey, accList[0]['pubKey']);
      expect(store.currentAccount.address, accList[0]['address']);
      expect(store.optionalAccounts[0].pubKey, endoEncointer['pubKey']);
      expect(store.optionalAccounts[0].name, 'test-change');
      expect(store.optionalAccounts[0].pubKey, endoEncointer['pubKey']);
      expect(store.optionalAccounts[0].address, endoEncointer['address']);

      store.setCurrentAccount(endoEncointer['pubKey'] as String);
      expect(store.currentAccountPubKey, endoEncointer['pubKey']);
      expect(store.currentAccount.name, 'test-change');
      expect(store.currentAccount.pubKey, endoEncointer['pubKey']);
      expect(store.currentAccount.address, endoEncointer['address']);

      /// remove account
      await store.removeAccount(store.currentAccount);
      expect(store.accountList.length, 1);
      expect(store.currentAccountPubKey, accList[0]['pubKey']);
      expect(store.currentAccount.name, accList[0]['name']);
      expect(store.currentAccount.pubKey, accList[0]['pubKey']);
      expect(store.currentAccount.address, accList[0]['address']);
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
      store.setCurrentAccount(contact['pubKey'] as String);
      expect(store.currentAccountPubKey, contact['pubKey']);
      expect(store.currentAccount.name, contact['name']);
      expect(store.currentAccount.pubKey, contact['pubKey']);
      expect(store.currentAccount.address, contact['address']);
      expect(store.optionalAccounts[0].pubKey, accList[0]['pubKey']);
      expect(store.optionalAccounts[0].name, accList[0]['name']);
      expect(store.optionalAccounts[0].pubKey, accList[0]['pubKey']);
      expect(store.optionalAccounts[0].address, accList[0]['address']);

      /// update observation account
      final contactNew = Map<String, dynamic>.of(contact);
      contactNew['name'] = 'changed-observation';
      await root.settings.updateContact(contactNew);
      expect(store.currentAccount.name, 'changed-observation');
    });
  });
}
