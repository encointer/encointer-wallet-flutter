import 'dart:async';

import 'package:convert/convert.dart';
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
  _AccountStore(this.rootStore)
      : legacyEncryptionService = LegacyEncryptionService(rootStore.localStorage),
        accountStorageService = AccountStorageService(rootStore.secureStorage),
        keyring = EncointerKeyring();

  final AppStore rootStore;

  final LegacyEncryptionService legacyEncryptionService;

  final AccountStorageService accountStorageService;

  @observable
  EncointerKeyring keyring;

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

  KeyringAccount getKeyringAccount(String pubKeyHex) {
    return keyring.getAccountByPubKeyHex(pubKeyHex);
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
    final acc = keyring.getAccountByPubKeyHex(account.pubKey)..name = newName;
    // not-sure if this is necessary double check.
    keyring.addAccount(acc);

    await storeAccountData();
    await loadAccount();
  }

  /// Adds a new account, will overwrite the account data if they same seed already exists.
  @action
  Future<void> addAccount(Map<String, dynamic> acc, String password, {required String name}) async {
    final uri = getUriFromMeta(acc);
    final account = await KeyringAccount.fromUri(name, uri);
    Log.d('[AddAccount]: added account ${account.toAccountData()}');

    keyring.addAccount(account);
    await storeAccountData();

    // update account list
    await loadAccount();
  }

  String getUriFromMeta(Map<String, dynamic> acc) {
    final maybeMnemonic = acc[AccountStore.seedTypeMnemonic] as String?;
    if (maybeMnemonic != null && maybeMnemonic.isNotEmpty) return maybeMnemonic;

    final maybeRawSeed = acc[AccountStore.seedTypeRawSeed] as String?;
    if (maybeRawSeed != null && maybeRawSeed.isNotEmpty) return maybeRawSeed;

    // this was never thrown in the old case and it will be obsolete soon.
    throw Exception(['Invalid seed generated in JS']);
  }

  @action
  Future<void> removeAccount(AccountData acc) async {
    Log.d('removeAccount: removing ${acc.pubKey}', 'AccountStore');
    keyring.remove(hex.decode(acc.pubKey.replaceFirst('0x', '')));
    await storeAccountData();

    if (acc.pubKey == currentAccountPubKey) {
      if (keyring.accounts.isNotEmpty) {
        await rootStore.setCurrentAccount(keyring.accountsIter.first.pubKeyHex);
      } else {
        await rootStore.setCurrentAccount('');
      }
    } else {
      // update account list
      await loadAccount();
    }
  }

  @action
  Future<void> storeAccountData() async {
    await accountStorageService.storeAccountData(keyring.accountDatas);
  }

  /// This needs to always be called after the account list has been updated.
  ///
  /// This is most likely only here due to poor understanding of mobx. Updating
  /// the account list in an action itself should remove the need to call this.
  /// Tackle this in #574.
  @action
  Future<void> loadAccount() async {
    final keyringAccounts = await accountStorageService.readAccountData();
    keyring = await EncointerKeyring.fromAccountData(keyringAccounts);

    accountList = ObservableList.of(
      keyring.accountsIter.map(
        (acc) => AccountData(name: acc.name, pubKey: acc.pubKeyHex, address: acc.address().encode()),
      ),
    );

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
