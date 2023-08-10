import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_tx_wrappers.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/logo/community_icon.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/page/profile/account/export_result_page.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/page/profile/contacts/account_share_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/ui.dart';

class AccountManagePage extends StatefulWidget {
  const AccountManagePage({super.key});

  static const String route = '/profile/account';

  @override
  State<AccountManagePage> createState() => _AccountManagePageState();
}

enum AccountAction { delete, export }

class _AccountManagePageState extends State<AccountManagePage> {
  TextEditingController? _nameCtrl;
  bool _isEditingText = false;
  late final AppStore _appStore;

  Map<String, Faucet>? faucets;

  @override
  void initState() {
    super.initState();
    _appStore = context.read<AppStore>();
    if (_appStore.encointer.chosenCid != null) webApi.encointer.getBootstrappers();
    _init();
  }

  Future<void> _init() async {
    faucets = await webApi.encointer.getAllFaucetsWithAccount();
    setState(() {});
  }

  @override
  void dispose() {
    _nameCtrl!.dispose();
    super.dispose();
  }

  void _onDeleteAccount(BuildContext context, AccountData accountToBeEdited) {
    LoginDialog.verifyPinOrBioAuth(
      context,
      titleText: context.l10n.accountDelete,
      onSuccess: (v) async {
        await _appStore.account
            .removeAccount(accountToBeEdited)
            .then((_) => _appStore.loadAccountCache())
            .then((_) => webApi.fetchAccountData());
        if (_appStore.account.accountListAll.isEmpty) {
          await context.read<LoginStore>().clearPin();
          await Navigator.pushNamedAndRemoveUntil(context, CreateAccountEntryView.route, (route) => false);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _getBalanceEntryListTile(String cidFmt, BalanceEntry? entry, String? address) {
    final h3 = context.titleLarge.copyWith(color: context.colorScheme.primary);

    final community = _appStore.encointer.communityStores![cidFmt]!;

    Log.d('_getBalanceEntryListTile: $community', 'AccountManagePage');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      leading: CommunityIcon(
        store: _appStore,
        address: address,
        icon: const CommunityIconObserver(),
      ),
      title: Text(community.name!, style: h3),
      subtitle: Text(community.symbol!, style: h3),
      trailing: Text(
        '${entry != null && community.applyDemurrage != null ? Fmt.doubleFormat(community.applyDemurrage!(entry)) : 0} ⵐ',
        style: h3.copyWith(color: AppColors.encointerGrey),
      ),
    );
  }

  Future<void> _showPasswordDialog(BuildContext context, AccountData accountToBeEdited) async {
    await LoginDialog.verifyPinOrBioAuth(
      context,
      titleText: context.l10n.confirmPin,
      autoCloseOnSuccess: false,
      onSuccess: (password) async {
        final isMnemonic =
            await _appStore.account.checkSeedExist(AccountStore.seedTypeMnemonic, accountToBeEdited.pubKey);
        Navigator.pop(context);
        if (isMnemonic) {
          final seed =
              await _appStore.account.decryptSeed(accountToBeEdited.pubKey, AccountStore.seedTypeMnemonic, password);

          await Navigator.pushNamed(context, ExportResultPage.route, arguments: {
            'key': seed,
            'type': AccountStore.seedTypeMnemonic,
          });
        } else {
          final l10n = context.l10n;
          AppAlert.showErrorDialog(
            context,
            title: Text(l10n.noMnemonicFound),
            errorText: l10n.importedWithRawSeedHenceNoMnemonic,
            buttontext: l10n.ok,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final h3Grey = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final store = context.watch<AppStore>();
    final appSettingsStore = context.watch<AppSettings>();

    final accountToBeEditedPubKey = ModalRoute.of(context)!.settings.arguments as String?;
    final accountToBeEdited = store.account.getAccountData(accountToBeEditedPubKey);
    final addressSS58 = Fmt.ss58Encode(accountToBeEditedPubKey!, prefix: store.settings.endpoint.ss58!);

    _nameCtrl = TextEditingController(text: accountToBeEdited.name);
    _nameCtrl!.selection = TextSelection.fromPosition(TextPosition(offset: _nameCtrl!.text.length));

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            key: const Key(EWTestKeys.closeAccountManage),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          title: _isEditingText
              ? TextFormField(
                  key: const Key(EWTestKeys.accountNameField),
                  controller: _nameCtrl,
                  validator: (v) => InputValidation.validateAccountName(context, v, _appStore.account.accountList),
                )
              : Text(_nameCtrl!.text),
          actions: <Widget>[
            if (!_isEditingText)
              IconButton(
                key: const Key(EWTestKeys.accountNameEdit),
                icon: const Icon(Iconsax.edit),
                onPressed: () {
                  setState(() {
                    _isEditingText = true;
                  });
                },
              )
            else
              IconButton(
                key: const Key(EWTestKeys.accountNameEditCheck),
                icon: const Icon(Icons.check),
                onPressed: () async {
                  await _appStore.account.updateAccountName(accountToBeEdited, _nameCtrl!.text.trim());
                  setState(() {
                    _isEditingText = false;
                  });
                },
              )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                if (!isKeyboard)
                  AddressIcon(
                    addressSS58,
                    accountToBeEditedPubKey,
                    size: 130,
                  ),
                Text(
                  addressSS58,
                  key: const Key(EWTestKeys.accountPublicKey),
                  // Text only read `addressSS58` for integration test
                  style: const TextStyle(fontSize: 2, color: Colors.transparent),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Fmt.address(addressSS58)!,
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.copy),
                      color: context.colorScheme.secondary,
                      onPressed: () => UI.copyAndNotify(context, addressSS58),
                    ),
                  ],
                ),
                Text(l10n.communities, style: h3Grey, textAlign: TextAlign.left),
                if (appSettingsStore.developerMode)
                  ListView.builder(
                      shrinkWrap: true,
                      // Fixme: https://github.com/encointer/encointer-wallet-flutter/issues/586
                      itemCount: store.encointer.accountStores!.containsKey(addressSS58)
                          ? store.encointer.accountStores![addressSS58]?.balanceEntries.length ?? 0
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        final community =
                            store.encointer.accountStores![addressSS58]!.balanceEntries.keys.elementAt(index);
                        return _getBalanceEntryListTile(
                          community,
                          store.encointer.accountStores![addressSS58]!.balanceEntries[community],
                          addressSS58,
                        );
                      })
                else
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: store.encointer.chosenCid != null ? 1 : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return _getBalanceEntryListTile(
                          _appStore.encointer.chosenCid!.toFmtString(),
                          _appStore.encointer.communityBalanceEntry,
                          addressSS58,
                        );
                      }),
                Text(l10n.benefits, style: h3Grey, textAlign: TextAlign.left),
                if (faucets != null)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: faucets!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final faucetAccount = faucets!.keys.elementAt(index);
                      return FaucetListTile(store, faucet: faucets![faucetAccount]!, faucetAccount: faucetAccount);
                    },
                  )
                else
                  const CupertinoActivityIndicator(),
                const Spacer(),
                DecoratedBox(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        key: const Key(EWTestKeys.goToAccountShare),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16), // make splash animation as high as the container
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Iconsax.share),
                            const SizedBox(width: 12),
                            Text(
                              l10n.accountShare,
                              style: context.titleLarge.copyWith(color: context.colorScheme.background, fontSize: 19),
                            ),
                          ],
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, AccountSharePage.route, arguments: accountToBeEditedPubKey),
                      ),
                      const Spacer(),
                      PopupMenuButton<AccountAction>(
                          offset: const Offset(-10, -150),
                          icon: const Icon(
                            Iconsax.more,
                            key: Key(EWTestKeys.popupMenuAccountTrashExport),
                            color: Colors.white,
                          ),
                          color: context.colorScheme.background,
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (AccountAction accountAction) {
                            return switch (accountAction) {
                              AccountAction.delete => _onDeleteAccount(context, accountToBeEdited),
                              AccountAction.export => _showPasswordDialog(context, accountToBeEdited),
                            };
                          },
                          itemBuilder: (BuildContext context) => [
                                AccountActionItemData(
                                  accountAction: AccountAction.delete,
                                  icon: Iconsax.trash,
                                  title: l10n.deleteAccount,
                                ),
                                AccountActionItemData(
                                    accountAction: AccountAction.export,
                                    icon: Iconsax.export,
                                    title: l10n.exportAccount),
                              ]
                                  .map((AccountActionItemData data) => PopupMenuItem<AccountAction>(
                                        key: Key(data.accountAction.name),
                                        value: data.accountAction,
                                        // https://github.com/flutter/flutter/issues/31247 as soon as we use a newer flutter version we might be able to add this to our theme.dart
                                        child: ListTileTheme(
                                          textColor: context.colorScheme.secondary,
                                          iconColor: context.colorScheme.secondary,
                                          child: ListTile(
                                            minLeadingWidth: 0,
                                            title: Text(data.title),
                                            leading: Icon(data.icon),
                                          ),
                                        ),
                                      ))
                                  .toList() //<PopupMenuEntry<AccountAction>>,
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FaucetListTile extends StatefulWidget {
  const FaucetListTile(
    this.store, {
    super.key,
    required this.faucetAccount,
    required this.faucet,
  });

  final AppStore store;

  final String faucetAccount;
  final Faucet faucet;

  @override
  State<FaucetListTile> createState() => _FaucetListTileState();
}

class _FaucetListTileState extends State<FaucetListTile> {
  late Future<Map<int, CommunityIdentifier>> future;
  late Future<BigInt> nativeBalance;

  @override
  void initState() {
    super.initState();
    future = _getUncommittedReputationIds();
    nativeBalance = getNativeFreeBalance();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Assets.kusama.svg(fit: BoxFit.fitHeight),
        ),
      ),
      title: Text(
        widget.faucet.name,
        style: context.titleMedium.copyWith(color: context.colorScheme.primary),
      ),
      subtitle: Row(
        children: [
          const Text('KSM: '),
          FutureBuilder(
          future: nativeBalance,
          builder: (BuildContext context, AsyncSnapshot<BigInt> snapshot) {
            if (snapshot.hasData) {
              return Text(Fmt.token(snapshot.data!, ertDecimals));
            } else {
              return const CupertinoActivityIndicator();
            }
          })
        ],
      ),
      trailing: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<Map<int, CommunityIdentifier>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SubmitButtonSmall(
                onPressed: (context) async {
                  await _submitFaucetDripTxs(context, snapshot.data!, widget.faucetAccount);
                  future = _getUncommittedReputationIds();
                  nativeBalance = getNativeFreeBalance();
                  setState(() {});
                },
                child: const Text('Claim'),
              );
            } else {
              return const SubmitButtonSmall(
                  child: Text('No Claim')
              );
            }
          } else {
            return const CupertinoActivityIndicator();
          }
        },
      ),
    );
  }

  /// Returns all reputation ids, which haven't been committed for this faucet's
  /// purpose id yet, i.e., can be used to drip the faucet currently.
  Future<Map<int, CommunityIdentifier>> _getUncommittedReputationIds() async {
    final reputations = widget.store.encointer.account!.reputations;
    final ids = Map<int, CommunityIdentifier>.of({});

    // Create a set of futures to await in parallel.
    final futures = reputations.entries.map(
      (e) async {
        final cid = e.value.communityIdentifier!;
        // Only check if the reputations community id is allowed to drip the faucet.
        if (widget.faucet.whitelist != null && widget.faucet.whitelist!.contains(cid)) {
          final hasCommitted = await webApi.encointer.hasCommittedFor(
            cid,
            e.key,
            widget.faucet.purposeId,
            widget.store.account.currentAddress,
          );

          if (!hasCommitted) ids[e.key] = e.value.communityIdentifier!;
        }
      },
    );

    await Future.wait(futures);
    return ids;
  }

  Future<void> _submitFaucetDripTxs(
    BuildContext context,
    Map<int, CommunityIdentifier> ids,
    String faucetAccount,
  ) async {
    final futures =
        ids.entries.map((e) => submitFaucetDrip(context, widget.store, webApi, faucetAccount, e.value, e.key));
    await Future.wait(futures);
  }

  Future<BigInt> getNativeFreeBalance() async {
    final balance = await webApi.assets.getBalance();
    return balance.freeBalance;
  }
}

class AccountActionItemData {
  const AccountActionItemData({
    required this.title,
    required this.accountAction,
    required this.icon,
  });

  // in newer flutter versions you can put that stuff into the AccountAction enum and do not need an extra class
  final String title;
  final AccountAction accountAction;
  final IconData icon;
}

class CommunityIcon extends StatelessWidget {
  const CommunityIcon({
    super.key,
    required this.store,
    required this.icon,
    required this.address,
  });

  final AppStore store;
  final Widget icon;
  final String? address;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    return Stack(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: icon,
        ),
        Observer(
          builder: (_) {
            if (store.encointer.community!.bootstrappers != null &&
                store.encointer.community!.bootstrappers!.contains(address)) {
              return const Positioned(
                bottom: 0,
                right: 0, //give the values according to your requirement
                child: Icon(Iconsax.star, color: Colors.yellow),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
