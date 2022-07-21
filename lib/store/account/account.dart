import 'dart:async';

import 'package:aes_ecb_pkcs5_flutter/aes_ecb_pkcs5_flutter.dart';
import 'package:encointer_wallet/page/profile/settings/ss58PrefixListPage.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/account/types/txStatus.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:mobx/mobx.dart';

part 'account.g.dart';

/// Mobx-store containing account related data.
///
/// Todo: This store has been inherited from upstream, and I think it would need a refactoring:
/// * https://github.com/encointer/encointer-wallet-flutter/issues/574
/// * https://github.com/encointer/encointer-wallet-flutter/issues/487

class AccountStore extends _AccountStore with _$AccountStore {
  AccountStore(AppStore appStore) : super(appStore);

  static const String seedTypeMnemonic = 'mnemonic';
  static const String seedTypeRawSeed = 'rawSeed';
  static const String seedTypeKeystore = 'keystore';
}

abstract class _AccountStore with Store {
  _AccountStore(this.rootStore);

  final AppStore rootStore;

  Map<String, dynamic> _formatMetaData(Map<String, dynamic> acc) {
    acc['name'] = newAccount.name.isEmpty ? acc['meta']['name'] : newAccount.name;
    if (acc['meta']['whenCreated'] == null) {
      acc['meta']['whenCreated'] = DateTime.now().millisecondsSinceEpoch;
    }
    acc['meta']['whenEdited'] = DateTime.now().millisecondsSinceEpoch;
    return acc;
  }

  @observable
  bool loading = true;

  @observable
  TxStatus? txStatus;

  @observable
  AccountCreate newAccount = AccountCreate();

  @observable
  String? currentAccountPubKey = '';

  @observable
  ObservableList<AccountData> accountList = ObservableList<AccountData>();

  @observable
  ObservableMap<String?, Map> addressIndexMap = ObservableMap<String?, Map>();

  @observable
  Map<String?, Map> accountIndexMap = Map<String, Map>();

  @observable
  ObservableMap<int, Map<String, String>> pubKeyAddressMap = ObservableMap<int, Map<String, String>>();

  @observable
  ObservableMap<String?, String?> pubKeyIconsMap = ObservableMap<String?, String?>();

  @observable
  ObservableMap<String?, String?> addressIconsMap = ObservableMap<String?, String?>();

  @observable
  List<Map<String, dynamic>> queuedTxs = ObservableList<Map<String, dynamic>>();

  @computed
  AccountData get currentAccount {
    return getAccountData(currentAccountPubKey);
  }

  AccountData getAccountData(String? requestedPubKey) {
    int i = accountListAll.indexWhere((i) => i.pubKey == requestedPubKey);
    if (i < 0) {
      if (accountListAll.isNotEmpty) {
        return accountListAll[0];
      } else {
        return AccountData();
      }
    }
    return accountListAll[i];
  }

  @computed
  List<AccountData> get optionalAccounts {
    return accountListAll.where((i) => i.pubKey != currentAccountPubKey).toList();
  }

  /// accountList with observations
  @computed
  List<AccountData> get accountListAll {
    List<AccountData> accList = accountList.toList();
    List<AccountData> contactList = rootStore.settings!.contactList.toList();
    contactList.retainWhere((i) => i.observation);
    accList.addAll(contactList);
    return accList;
  }

  @computed
  bool get isFirstAccount {
    return accountListAll.isEmpty;
  }

  @computed
  String get currentAddress {
    return getNetworkAddress(currentAccountPubKey);
  }

  /// Gets the address (SS58) for the corresponding network.
  String getNetworkAddress(String? pubKey) {
    // _log("currentAddress: endpoint.info: ${rootStore.settings.endpoint.info}");
    // _log("currentAddress: endpoint.ss58: ${rootStore.settings.endpoint.ss58}");
    // _log("currentAddress: customSS58: ${rootStore.settings.customSS58Format.toString()}");
    // _log("currentAddress: AddressMap 42: ${pubKeyAddressMap[42].toString()}");
    // _log("currentAddress: AddressMap 2: ${pubKeyAddressMap[2].toString()}");

    int? ss58 = rootStore.settings!.customSS58Format['value'];
    if (rootStore.settings!.customSS58Format['info'] == default_ss58_prefix['info']) {
      ss58 = rootStore.settings!.endpoint.ss58;
    }

    final address = pubKeyAddressMap[ss58!] != null ? pubKeyAddressMap[ss58]![pubKey!] : null;

    if (address != null) {
      return address;
    } else {
      _log("getNetworkAddress: could not get address (SS58)");
      return currentAccount.address;
    }
  }

  @action
  void setTxStatus([TxStatus? status]) {
    txStatus = status;
  }

  @action
  void clearTxStatus() {
    txStatus = null;
  }

  @action
  void setNewAccountName(String name) {
    newAccount.name = name;
  }

  @action
  void setNewAccountPin(String pin) {
    newAccount.password = pin;
  }

  @action
  void setNewAccountKey(String? key) {
    newAccount.key = key;
  }

  @action
  void resetNewAccount() {
    newAccount = AccountCreate();
  }

  @action
  void queueTx(Map<String, dynamic> tx) {
    queuedTxs.add(tx);

    new Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      if (await webApi!.isConnected()) {
        queuedTxs.forEach((args) async {
          Map res = await webApi!.account.sendTxAndShowNotification(
            args['txInfo'],
            args['params'],
            args['title'],
            args['notificationTitle'],
            rawParam: args['rawParam'],
          );

          print("Queued tx result: ${res.toString()}");
          if (res['hash'] == null) {
            NotificationPlugin.showNotification(
              0,
              args['notificationTitle'],
              'Failed to sendTx: ${args['title']} - ${args['txInfo']['module']}.${args['txInfo']['call']}',
            );
          } else {
            if (rootStore.settings!.endpointIsEncointer) {
              rootStore.encointer!.account!.setTransferTxs([res], rootStore.account!.currentAddress);
            }
          }
        });
        rootStore.assets!.setSubmitting(false);
        rootStore.account!.clearTxStatus();
        timer.cancel();
        queuedTxs = [];
      } else {
        print("Waiting for the api to reconnect to send ${queuedTxs.length} queued tx(s)");
      }
    });
  }

  @action
  Future<void> setCurrentAccount(String? pubKey) async {
    if (currentAccountPubKey != pubKey) {
      currentAccountPubKey = pubKey;

      await rootStore.localStorage.setCurrentAccount(pubKey!);

      return loadAccount();
    }
  }

  @action
  Future<void> updateAccountName(AccountData account, String newName) async {
    Map<String, dynamic> acc = AccountData.toJson(account);
    acc['meta']['name'] = newName;

    await updateAccount(acc);
  }

  @action
  Future<void> updateAccount(Map<String, dynamic> acc) async {
    acc = _formatMetaData(acc);

    AccountData accNew = AccountData.fromJson(acc);
    await rootStore.localStorage.removeAccount(accNew.pubKey);
    await rootStore.localStorage.addAccount(acc);

    await loadAccount();
  }

  @action
  Future<void> addAccount(Map<String, dynamic> acc, String password) async {
    String pubKey = acc['pubKey'];
    // save seed and remove it before add account
    void saveSeed(String seedType) {
      String? seed = acc[seedType];
      if (seed != null && seed.isNotEmpty) {
        encryptSeed(pubKey, acc[seedType], seedType, password);
        acc.remove(seedType);
      }
    }

    saveSeed(AccountStore.seedTypeMnemonic);
    saveSeed(AccountStore.seedTypeRawSeed);

    // format meta data of acc
    acc = _formatMetaData(acc);

    int index = accountList.indexWhere((i) => i.pubKey == pubKey);
    if (index > -1) {
      await rootStore.localStorage.removeAccount(pubKey);
      print('removed acc: $pubKey');
    }
    await rootStore.localStorage.addAccount(acc);

    // update account list
    await loadAccount();

    // clear the temp account after addAccount finished
    newAccount = AccountCreate();
  }

  @action
  Future<void> removeAccount(AccountData acc) async {
    _log("removeAccount: removing ${acc.pubKey}");
    await rootStore.localStorage.removeAccount(acc.pubKey);

    // remove encrypted seed after removing account
    deleteSeed(AccountStore.seedTypeMnemonic, acc.pubKey);
    deleteSeed(AccountStore.seedTypeRawSeed, acc.pubKey);

    if (acc.pubKey == currentAccountPubKey) {
      // set new currentAccount after currentAccount was removed
      List<Map<String, dynamic>> accounts = await rootStore.localStorage.getAccountList();
      var newCurrentAccountPubKey = accounts.length > 0 ? accounts[0]['pubKey'] : '';
      _log("removeAccount: newCurrentAccountPubKey $newCurrentAccountPubKey");

      await rootStore.setCurrentAccount(newCurrentAccountPubKey);
    } else {
      // update account list
      await loadAccount();
    }
  }

  /// This needs to always be called after the account list has been updated.
  ///
  /// This is most likely only here due to poor understanding of mobx. Updating
  /// the account list in an action itself should remove the need to call this.
  /// Tackle this in #574.
  @action
  Future<void> loadAccount() async {
    List<Map<String, dynamic>> accList = await rootStore.localStorage.getAccountList();
    accountList = ObservableList.of(accList.map((i) => AccountData.fromJson(i)));

    currentAccountPubKey = await rootStore.localStorage.getCurrentAccount();
    loading = false;
  }

  @action
  Future<void> encryptSeed(String? pubKey, String seed, String seedType, String password) async {
    String key = Fmt.passwordToEncryptKey(password);
    String encrypted = await FlutterAesEcbPkcs5.encryptString(seed, key);
    Map stored = await rootStore.localStorage.getSeeds(seedType) as Map<String, dynamic>;
    stored[pubKey] = encrypted;
    rootStore.localStorage.setSeeds(seedType, stored);
  }

  @action
  Future<String?> decryptSeed(String pubKey, String seedType, String password) async {
    Map stored = await rootStore.localStorage.getSeeds(seedType);
    String? encrypted = stored[pubKey];
    if (encrypted == null) {
      return Future.value(null);
    }
    return FlutterAesEcbPkcs5.decryptString(encrypted, Fmt.passwordToEncryptKey(password));
  }

  @action
  Future<bool> checkSeedExist(String seedType, String? pubKey) async {
    Map stored = await rootStore.localStorage.getSeeds(seedType);
    String? encrypted = stored[pubKey];
    return encrypted != null;
  }

  @action
  Future<void> updateSeed(String? pubKey, String passwordOld, String passwordNew) async {
    Map storedMnemonics = await rootStore.localStorage.getSeeds(AccountStore.seedTypeMnemonic);
    Map? storedRawSeeds = await rootStore.localStorage.getSeeds(AccountStore.seedTypeRawSeed);
    String? encryptedSeed = '';
    String seedType = '';
    if (storedMnemonics[pubKey] != null) {
      encryptedSeed = storedMnemonics[pubKey];
      seedType = AccountStore.seedTypeMnemonic;
    } else if (storedMnemonics[pubKey] != null) {
      encryptedSeed = storedRawSeeds[pubKey];
      seedType = AccountStore.seedTypeRawSeed;
    } else {
      return;
    }

    String seed = await FlutterAesEcbPkcs5.decryptString(encryptedSeed!, Fmt.passwordToEncryptKey(passwordOld));
    encryptSeed(pubKey, seed, seedType, passwordNew);
  }

  @action
  Future<void> deleteSeed(String seedType, String? pubKey) async {
    Map stored = await rootStore.localStorage.getSeeds(seedType);
    if (stored[pubKey] != null) {
      stored.remove(pubKey);
      rootStore.localStorage.setSeeds(seedType, stored);
    }
  }

  @action
  void setPubKeyAddressMap(Map<String, Map> data) {
    data.keys.forEach((ss58) {
      // get old data map
      Map<String, String> addresses = Map.of(pubKeyAddressMap[int.parse(ss58)] ?? {});
      // set new data
      Map.of(data[ss58]!).forEach((k, v) {
        addresses[k] = v;
      });
      // update state
      pubKeyAddressMap[int.parse(ss58)] = addresses;
    });
  }

  @action
  void setPubKeyIconsMap(List list) {
    list.forEach((i) {
      pubKeyIconsMap[i[0]] = i[1];
    });
  }

  @action
  void setAddressIconsMap(List list) {
    print("Address Icons");
    print(list);
    list.forEach((i) {
      addressIconsMap[i[0]] = i[1];
    });
  }

  @action
  void setAccountsIndex(List list) {
    final Map<String?, Map> data = {};
    list.forEach((i) {
      data[i['accountId']] = i;
    });
    accountIndexMap = data;
  }

  @action
  void setAddressIndex(List list) {
    list.forEach((i) {
      addressIndexMap[i['accountId']] = i;
    });
  }
}

class AccountCreate extends _AccountCreate with _$AccountCreate {}

abstract class _AccountCreate with Store {
  @observable
  String name = '';

  @observable
  String password = '';

  @observable
  String? key = '';
}

_log(String msg) {
  print("[AccountStore] $msg");
}
