import 'dart:async';

import 'package:aes_ecb_pkcs5_flutter/aes_ecb_pkcs5_flutter.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/page/profile/settings/ss58_prefix_list_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

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
  Map<String?, Map> accountIndexMap = <String, Map>{};

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
    final i = accountListAll.indexWhere((i) => i.pubKey == requestedPubKey);
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
    final accList = accountList.toList();
    final contactList = rootStore.settings.contactList.toList();
    contactList.retainWhere((i) => i.observation ?? false);
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

    var ss58 = rootStore.settings.customSS58Format['value'] as int?;
    if (rootStore.settings.customSS58Format['info'] == defaultSs58Prefix['info']) {
      ss58 = rootStore.settings.endpoint.ss58;
    }

    final address = pubKeyAddressMap[ss58!] != null ? pubKeyAddressMap[ss58]![pubKey!] : null;

    if (address != null) {
      return address;
    } else {
      Log.d('getNetworkAddress: could not get address (SS58)', 'AccountStore');
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

    Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      if (await webApi.isConnected()) {
        queuedTxs.forEach((args) async {
          final res = await webApi.account.sendTxAndShowNotification(
            args['txInfo'] as Map<dynamic, dynamic>?,
            args['params'] as List<dynamic>?,
            args['title'] as String?,
            args['notificationTitle'] as String?,
            rawParam: args['rawParam'] as String?,
          );

          Log.d('Queued tx result: $res', 'AccountStore');
          if (res['hash'] == null) {
            NotificationPlugin.showNotification(
              0,
              args['notificationTitle'] as String?,
              'Failed to sendTx: ${args['title']} - ${args['txInfo']['module']}.${args['txInfo']['call']}',
            );
          } else {
            if (rootStore.settings.endpointIsEncointer) {
              rootStore.encointer.account!.setTransferTxs([res], rootStore.account.currentAddress);
            }
          }
        });
        rootStore.assets.setSubmitting(false);
        rootStore.account.clearTxStatus();
        timer.cancel();
        queuedTxs = [];
      } else {
        Log.d('Waiting for the api to reconnect to send ${queuedTxs.length} queued tx(s)', 'AccountStore');
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
    final acc = AccountData.toJson(account);
    acc['meta']['name'] = newName;

    await updateAccount(acc);
  }

  @action
  Future<void> updateAccount(Map<String, dynamic> acc) async {
    acc = _formatMetaData(acc);

    final accNew = AccountData.fromJson(acc);
    await rootStore.localStorage.removeAccount(accNew.pubKey);
    await rootStore.localStorage.addAccount(acc);

    await loadAccount();
  }

  @action
  Future<void> addAccount(Map<String, dynamic> acc, String password) async {
    final pubKey = acc['pubKey'] as String;
    // save seed and remove it before add account
    void saveSeed(String seedType) {
      final seed = acc[seedType] as String?;
      if (seed != null && seed.isNotEmpty) {
        encryptSeed(pubKey, acc[seedType] as String, seedType, password);
        acc.remove(seedType);
      }
    }

    saveSeed(AccountStore.seedTypeMnemonic);
    saveSeed(AccountStore.seedTypeRawSeed);

    // format meta data of acc
    acc = _formatMetaData(acc);

    final index = accountList.indexWhere((i) => i.pubKey == pubKey);
    if (index > -1) {
      await rootStore.localStorage.removeAccount(pubKey);
      Log.d('removed acc: $pubKey', 'AccountStore');
    }
    await rootStore.localStorage.addAccount(acc);

    // update account list
    await loadAccount();

    // clear the temp account after addAccount finished
    newAccount = AccountCreate();
  }

  @action
  Future<void> removeAccount(AccountData acc) async {
    Log.d('removeAccount: removing ${acc.pubKey}', 'AccountStore');
    await rootStore.localStorage.removeAccount(acc.pubKey);
    // remove encrypted seed after removing account
    deleteSeed(AccountStore.seedTypeMnemonic, acc.pubKey);
    deleteSeed(AccountStore.seedTypeRawSeed, acc.pubKey);

    if (acc.pubKey == currentAccountPubKey) {
      // set new currentAccount after currentAccount was removed
      final accounts = await rootStore.localStorage.getAccountList();
      final newCurrentAccountPubKey = accounts.length > 0 ? accounts[0]['pubKey'] as String? : '';
      Log.d('removeAccount: newCurrentAccountPubKey $newCurrentAccountPubKey', 'AccountStore');
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
    final accList = await rootStore.localStorage.getAccountList();
    accountList = ObservableList.of(accList.map((i) => AccountData.fromJson(i)));

    currentAccountPubKey = await rootStore.localStorage.getCurrentAccount();
    loading = false;
  }

  @action
  Future<void> encryptSeed(String? pubKey, String seed, String seedType, String password) async {
    final key = Fmt.passwordToEncryptKey(password);
    final encrypted = await FlutterAesEcbPkcs5.encryptString(seed, key);
    final Map stored = await rootStore.localStorage.getSeeds(seedType);
    stored[pubKey] = encrypted;
    rootStore.localStorage.setSeeds(seedType, stored);
  }

  @action
  Future<String?> decryptSeed(String pubKey, String seedType, String password) async {
    final Map stored = await rootStore.localStorage.getSeeds(seedType);
    final encrypted = stored[pubKey] as String?;
    if (encrypted == null) {
      return Future.value(null);
    }
    return FlutterAesEcbPkcs5.decryptString(encrypted, Fmt.passwordToEncryptKey(password));
  }

  @action
  Future<bool> checkSeedExist(String seedType, String? pubKey) async {
    final Map stored = await rootStore.localStorage.getSeeds(seedType);
    final encrypted = stored[pubKey] as String?;
    return encrypted != null;
  }

  @action
  Future<void> updateSeed(String? pubKey, String passwordOld, String passwordNew) async {
    final Map storedMnemonics = await rootStore.localStorage.getSeeds(AccountStore.seedTypeMnemonic);
    final Map storedRawSeeds = await rootStore.localStorage.getSeeds(AccountStore.seedTypeRawSeed);
    String? encryptedSeed = '';
    var seedType = '';
    if (storedMnemonics[pubKey] != null) {
      encryptedSeed = storedMnemonics[pubKey] as String?;
      seedType = AccountStore.seedTypeMnemonic;
    } else if (storedMnemonics[pubKey] != null) {
      encryptedSeed = storedRawSeeds[pubKey] as String?;
      seedType = AccountStore.seedTypeRawSeed;
    } else {
      return;
    }

    final seed = await FlutterAesEcbPkcs5.decryptString(encryptedSeed!, Fmt.passwordToEncryptKey(passwordOld));
    encryptSeed(pubKey, seed, seedType, passwordNew);
  }

  @action
  Future<void> deleteSeed(String seedType, String? pubKey) async {
    final stored = await rootStore.localStorage.getSeeds(seedType);
    if (stored[pubKey] != null) {
      stored.remove(pubKey);
      rootStore.localStorage.setSeeds(seedType, stored);
    }
  }

  @action
  void setPubKeyAddressMap(Map<String, Map> data) {
    data.keys.forEach((ss58) {
      // get old data map
      final addresses = Map<String, String>.of(pubKeyAddressMap[int.parse(ss58)] ?? {});
      // set new data
      Map.of(data[ss58]!).forEach((k, v) {
        addresses[k as String] = v as String;
      });
      // update state
      pubKeyAddressMap[int.parse(ss58)] = addresses;
    });
  }

  @action
  void setPubKeyIconsMap(List list) {
    list.forEach((i) {
      pubKeyIconsMap[i[0] as String] = i[1] as String?;
    });
  }

  @action
  void setAddressIconsMap(List list) {
    Log.d('Address Icons', 'AccountStore');
    Log.d('$list', 'AccountStore');
    list.forEach((i) {
      addressIconsMap[i[0] as String] = i[1] as String?;
    });
  }

  @action
  void setAccountsIndex(List list) {
    final data = <String?, Map>{};
    list.forEach((i) {
      data[i['accountId'] as String] = i as Map;
    });
    accountIndexMap = data;
  }

  @action
  void setAddressIndex(List list) {
    list.forEach((i) {
      addressIndexMap[i['accountId'] as String] = i as Map;
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
