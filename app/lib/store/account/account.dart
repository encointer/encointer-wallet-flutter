import 'dart:async';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/services/account_storage_service.dart';
import 'package:encointer_wallet/store/account/services/legacy_encryption_service.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_keyring/ew_keyring.dart';

part 'account.g.dart';

/// Mobx-store containing account related data.
///
/// Todo: This store has been inherited from upstream, and I think it would need a refactoring:
/// * https://github.com/encointer/encointer-wallet-flutter/issues/574
/// * https://github.com/encointer/encointer-wallet-flutter/issues/487

class AccountStore extends _AccountStore with _$AccountStore {
  AccountStore(super.appStore);

  // Re-export these here for backwards compatibility.
  static const String seedTypeMnemonic = LegacyEncryptionService.seedTypeMnemonic;
  static const String seedTypeRawSeed = LegacyEncryptionService.seedTypeRawSeed;
  static const String seedTypeKeystore = LegacyEncryptionService.seedTypeKeystore;
}

abstract class _AccountStore with Store {
  _AccountStore(this.rootStore) : legacyEncryptionService = LegacyEncryptionService(rootStore.localStorage);

  final AppStore rootStore;

  final LegacyEncryptionService legacyEncryptionService;

  Map<String, dynamic> _formatMetaData(Map<String, dynamic> acc, {String? name}) {
    acc['name'] = name ?? (acc['meta'] as Map<String, dynamic>)['name'];
    if ((acc['meta'] as Map<String, dynamic>)['whenCreated'] == null) {
      (acc['meta'] as Map<String, dynamic>)['whenCreated'] = DateTime.now().millisecondsSinceEpoch;
    }
    (acc['meta'] as Map<String, dynamic>)['whenEdited'] = DateTime.now().millisecondsSinceEpoch;
    return acc;
  }

  @observable
  bool loading = true;

  @observable
  TxStatus? txStatus;

  @observable
  String? currentAccountPubKey = '';

  @observable
  ObservableList<AccountData> accountList = ObservableList<AccountData>();

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
        return AccountData.empty();
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
    final contactList = rootStore.settings.contactList.toList()..retainWhere((i) => i.observation ?? false);
    final accList = accountList.toList()..addAll(contactList);
    return accList;
  }

  @computed
  bool get isFirstAccount {
    return accountListAll.isEmpty;
  }

  @computed
  String get currentAddress {
    // Todo #1110: `currentAccountPubkey` should be non-nullable.
    if (currentAccountPubKey == null || currentAccountPubKey!.isEmpty) return '';
    return AddressUtils.pubKeyHexToAddress(currentAccountPubKey ?? '', prefix: rootStore.settings.endpoint.ss58!);
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
  void queueTx(Map<String, dynamic> tx) {
    queuedTxs.add(tx);

    Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
      if (await webApi.isConnected()) {
        final cid = rootStore.encointer.community?.cid.toFmtString();
        for (final args in queuedTxs) {
          final report = await webApi.account.sendTxAndShowNotification(
            args['txInfo'] as Map<String, dynamic>,
            args['params'] as List<dynamic>?,
            rawParam: args['rawParam'] as String?,
            cid: cid,
          );

          Log.d('Queued tx result: $report', 'AccountStore');
          if (report.isExtrinsicFailed) {
            await NotificationPlugin.showNotification(
              0,
              '${report.dispatchError!}',
              'Failed to sendTx: ${args['title']} - ${(args['txInfo'] as Map<String, dynamic>)['module']}.${(args['txInfo'] as Map<String, dynamic>)['call']}',
              cid: cid,
            );
          } else {
            // if (rootStore.settings.endpointIsEncointer) {
            //   await rootStore.encointer.account!.setTransferTxs([report], rootStore.account.currentAddress);
            // }
          }
        }
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
    (acc['meta'] as Map<String, dynamic>)['name'] = newName;

    await updateAccount(acc);
  }

  @action
  Future<void> updateAccount(Map<String, dynamic> acc) async {
    final formattedAcc = _formatMetaData(acc);

    final accNew = AccountData.fromJson(formattedAcc);
    await rootStore.localStorage.removeAccount(accNew.pubKey);
    await rootStore.localStorage.addAccount(formattedAcc);

    await loadAccount();
  }

  @action
  Future<void> addAccount(Map<String, dynamic> acc, String password, {String? name}) async {
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
    final formattedAcc = _formatMetaData(acc, name: name);

    final index = accountList.indexWhere((i) => i.pubKey == pubKey);
    if (index > -1) {
      await rootStore.localStorage.removeAccount(pubKey);
      Log.d('removed acc: $pubKey', 'AccountStore');
    }
    await rootStore.localStorage.addAccount(formattedAcc);

    // update account list
    await loadAccount();
  }

  @action
  Future<void> removeAccount(AccountData acc) async {
    Log.d('removeAccount: removing ${acc.pubKey}', 'AccountStore');
    await rootStore.localStorage.removeAccount(acc.pubKey);
    // remove encrypted seed after removing account
    await Future.wait([
      rootStore.localStorage.removeAccount(acc.pubKey),
      deleteSeed(AccountStore.seedTypeMnemonic, acc.pubKey),
      deleteSeed(AccountStore.seedTypeRawSeed, acc.pubKey),
    ]);

    if (acc.pubKey == currentAccountPubKey) {
      // set new currentAccount after currentAccount was removed
      final accounts = await rootStore.localStorage.getAccountList();
      final newCurrentAccountPubKey = accounts.isNotEmpty ? accounts[0]['pubKey'] as String? : '';
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
    accountList = ObservableList.of(accList.map(AccountData.fromJson));

    currentAccountPubKey = await rootStore.localStorage.getCurrentAccount();
    loading = false;
  }

  @action
  Future<void> updateSeed(String? pubKey, String passwordOld, String passwordNew) async {
    return legacyEncryptionService.updateSeed(pubKey, passwordOld, passwordNew);
  }

  @action
  Future<void> encryptSeed(String? pubKey, String seed, String seedType, String password) async {
    return legacyEncryptionService.encryptSeed(pubKey, seed, seedType, password);
  }

  @action
  Future<String?> decryptSeed(String pubKey, String seedType, String password) async {
    return legacyEncryptionService.decryptSeed(pubKey, seedType, password);
  }

  @action
  Future<bool> checkSeedExist(String seedType, String? pubKey) async {
    return legacyEncryptionService.checkSeedExist(seedType, pubKey);
  }

  @action
  Future<void> deleteSeed(String seedType, String? pubKey) async {
    return legacyEncryptionService.deleteSeed(seedType, pubKey);
  }
}
