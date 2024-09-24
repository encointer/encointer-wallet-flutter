import 'package:encointer_wallet/page/profile/account/remark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/logo/community_icon.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/page/profile/account/benefits.dart';
import 'package:encointer_wallet/page/profile/account/export_result_page.dart';
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
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_test_keys/ew_test_keys.dart';

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
    final allFaucets = await webApi.encointer.getAllFaucetsWithAccount();

    // show faucets we have reputation for and faucets for `chosenCid`.
    final relevantCids = _appStore.encointer.account!.reputations.values.map((e) => e.communityIdentifier).toSet()
      ..add(_appStore.encointer.chosenCid!);

    faucets = Map.fromEntries(allFaucets.entries.where((e) {
      final whitelist = e.value.whitelist;
      if (whitelist == null) {
        // if the whitelist is null, all communities may access it.
        return true;
      } else {
        return containsAny(whitelist, relevantCids.toList());
      }
    }));
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
          await context.read<LoginStore>().deleteAuthenticationData();
          await Navigator.pushNamedAndRemoveUntil(context, CreateAccountEntryView.route, (route) => false);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _getBalanceEntryListTile(int index, String address) {
    final h3 = context.titleLarge.copyWith(color: context.colorScheme.primary);

    // Checked in `ListView` generator that `balanceEntries` are not null.
    final cidFmt = _appStore.encointer.accountStores![address]!.balanceEntries.keys.elementAt(index);
    final entry = _appStore.encointer.accountStores![address]!.balanceEntries[cidFmt]!;

    final community = _appStore.encointer.communityStores?[cidFmt];

    if (community == null || community.applyDemurrage == null) {
      // Never happened, but we want to be defensive here to prevent a red screen.
      Log.e('[AccountManagePage] Communities is null, even though we have a balance entry for it. Fatal app error.');
      return Container();
    }

    if ((community.applyDemurrage!(entry) ?? 0) <= 0.0001 && cidFmt != _appStore.encointer.chosenCid!.toFmtString()) {
      Log.p("[AccountManagePage] Don't display community with 0 balance");
      return Container();
    }

    final isBootstrapper = _appStore.encointer.community!.bootstrappers != null &&
        _appStore.encointer.community!.bootstrappers!.contains(address);

    Log.d('_getBalanceEntryListTile: $community', 'AccountManagePage');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(),
      leading: CommunityIcon(
        store: _appStore,
        isBootstrapper: isBootstrapper,
        icon: CommunityCircleAvatar(community.icon),
      ),
      title: Text(community.name!, style: h3),
      subtitle: Text(community.symbol!, style: h3),
      trailing: Text(
        // Should never be null, but we still want to be defensive here.
        '${community.applyDemurrage != null ? Fmt.doubleFormat(community.applyDemurrage!(entry)) : 0} ⵐ',
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
        Navigator.of(context).pop();
        final account = _appStore.account.getKeyringAccount(accountToBeEdited.pubKey);
        await Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
          'key': account.uri,
          'type': '',
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final h3Grey = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final store = context.watch<AppStore>();
    final appConfig = RepositoryProvider.of<AppConfig>(context);

    final accountToBeEditedPubKey = ModalRoute.of(context)!.settings.arguments as String?;
    final accountToBeEdited = store.account.getAccountData(accountToBeEditedPubKey);
    final addressSS58 =
        AddressUtils.pubKeyHexToAddress(accountToBeEditedPubKey!, prefix: store.settings.currentNetwork.ss58());

    _nameCtrl = TextEditingController(text: accountToBeEdited.name);
    _nameCtrl!.selection = TextSelection.fromPosition(TextPosition(offset: _nameCtrl!.text.length));

    Widget benefits() {
      if (faucets == null) {
        return appConfig.isIntegrationTest ? const SizedBox.shrink() : const CupertinoActivityIndicator();
      }

      if (store.account.currentAccountPubKey! != accountToBeEditedPubKey) {
        return Column(children: [
          Text(l10n.benefits, style: h3Grey, textAlign: TextAlign.left),
          Text(l10n.canUseFaucetOnlyWithCurrentAccount, style: h3Grey, textAlign: TextAlign.left),
        ]);
      }

      return Benefits(
        store,
        faucets: faucets!,
        userAddress: Address(
          pubkey: AddressUtils.pubKeyHexToPubKey(accountToBeEditedPubKey),
          prefix: store.settings.currentNetwork.ss58(),
        ),
      );
    }

    Widget remarks() {
      return Remarks(
        store,
        userAddress: Address(
          pubkey: AddressUtils.pubKeyHexToPubKey(accountToBeEditedPubKey),
          prefix: store.settings.currentNetwork.ss58(),
        ),
      );
    }

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
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: store.encointer.accountStores!.containsKey(addressSS58)
                            ? store.encointer.accountStores![addressSS58]?.balanceEntries.length ?? 0
                            : 0,
                        itemBuilder: (BuildContext context, int index) => _getBalanceEntryListTile(
                          index,
                          addressSS58,
                        ),
                      ),
                      benefits(),
                      remarks(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        key: const Key(EWTestKeys.goToAccountShare),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
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
                              accountAction: AccountAction.export, icon: Iconsax.export, title: l10n.exportAccount),
                        ]
                            .map((AccountActionItemData data) => PopupMenuItem<AccountAction>(
                                  key: Key(data.accountAction.name),
                                  value: data.accountAction,
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
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    required this.isBootstrapper,
  });

  final AppStore store;
  final Widget icon;
  final bool isBootstrapper;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: icon,
        ),
        if (isBootstrapper)
          const Positioned(
            bottom: 0,
            right: 0,
            child: Icon(Iconsax.star, color: Colors.yellow),
          )
      ],
    );
  }
}

/// Checks if any entry in list one is contained in another list.
bool containsAny(List<dynamic> list1, List<dynamic> list2) {
  for (final entry in list1) {
    if (list2.contains(entry)) {
      return true;
    }
  }
  return false;
}
