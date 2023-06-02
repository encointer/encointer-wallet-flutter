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
import 'package:encointer_wallet/utils/translations/index.dart';
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

  @override
  void initState() {
    super.initState();
    _appStore = context.read<AppStore>();
    if (_appStore.encointer.chosenCid != null) webApi.encointer.getBootstrappers();
  }

  @override
  void dispose() {
    _nameCtrl!.dispose();
    super.dispose();
  }

  void _onDeleteAccount(BuildContext context, AccountData accountToBeEdited) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context)!.translationsForLocale().profile.accountDelete),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              key: const Key('delete-account'),
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _appStore.account
                    .removeAccount(accountToBeEdited)
                    .then((_) => _appStore.loadAccountCache())
                    .then((_) => webApi.fetchAccountData());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getBalanceEntryListTile(String cidFmt, BalanceEntry? entry, String? address) {
    final h3 = context.textTheme.displaySmall!;

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
    await AppAlert.showPasswordInputDialog(
      context,
      shouldShowCancelButton: true,
      autoCloseOnSuccess: false,
      account: _appStore.account.currentAccount,
      onSuccess: (password) async {
        final isMnemonic =
            await _appStore.account.checkSeedExist(AccountStore.seedTypeMnemonic, accountToBeEdited.pubKey);
        if (isMnemonic) {
          final seed =
              await _appStore.account.decryptSeed(accountToBeEdited.pubKey, AccountStore.seedTypeMnemonic, password);

          await Navigator.pushNamed(context, ExportResultPage.route, arguments: {
            'key': seed,
            'type': AccountStore.seedTypeMnemonic,
          });
        } else {
          final dic = I18n.of(context)!.translationsForLocale();
          Navigator.pop(context);
          AppAlert.showErrorDialog(
            context,
            title: Text(dic.profile.noMnemonicFound),
            errorText: dic.profile.importedWithRawSeedHenceNoMnemonic,
            buttontext: dic.home.ok,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final h3 = context.textTheme.displaySmall;
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
            key: const Key('close-account-manage'),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          title: _isEditingText
              ? TextFormField(
                  key: const Key('account-name-field'),
                  controller: _nameCtrl,
                  validator: (v) => InputValidation.validateAccountName(context, v, _appStore.account.accountList),
                )
              : Text(_nameCtrl!.text),
          actions: <Widget>[
            if (!_isEditingText)
              IconButton(
                key: const Key('account-name-edit'),
                icon: const Icon(Iconsax.edit),
                onPressed: () {
                  setState(() {
                    _isEditingText = true;
                  });
                },
              )
            else
              IconButton(
                key: const Key('account-name-edit-check'),
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
                SingleChildScrollView(
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
                        key: const Key('account-public-key'),
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
                      Text(dic.encointer.communities,
                          style: h3!.copyWith(color: AppColors.encointerGrey), textAlign: TextAlign.left),
                    ],
                  ),
                ),
                if (appSettingsStore.developerMode)
                  Expanded(
                    child: ListView.builder(
                        // Fixme: https://github.com/encointer/encointer-wallet-flutter/issues/586
                        itemCount: store.encointer.accountStores!.containsKey(addressSS58)
                            ? store.encointer.accountStores![addressSS58]?.balanceEntries.length ?? 0
                            : 0,
                        itemBuilder: (BuildContext context, int index) {
                          final community = store.encointer.account!.balanceEntries.keys.elementAt(index);
                          return _getBalanceEntryListTile(
                            community,
                            store.encointer.accountStores![addressSS58]!.balanceEntries[community],
                            addressSS58,
                          );
                        }),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                        itemCount: store.encointer.chosenCid != null ? 1 : 0,
                        itemBuilder: (BuildContext context, int index) {
                          return _getBalanceEntryListTile(
                            _appStore.encointer.chosenCid!.toFmtString(),
                            _appStore.encointer.communityBalanceEntry,
                            addressSS58,
                          );
                        }),
                  ),
                DecoratedBox(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        key: const Key('go-to-account-share'),
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
                            Text(dic.profile.accountShare, style: h3.copyWith(color: Colors.white)),
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
                            key: Key('popup-menu-account-trash-export'),
                            color: Colors.white,
                          ),
                          color: context.colorScheme.background,
                          padding: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onSelected: (AccountAction accountAction) {
                            switch (accountAction) {
                              case AccountAction.delete:
                                _onDeleteAccount(context, accountToBeEdited);
                                break;
                              case AccountAction.export:
                                _showPasswordDialog(context, accountToBeEdited);
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                                AccountActionItemData(
                                  accountAction: AccountAction.delete,
                                  icon: Iconsax.trash,
                                  title: dic.profile.deleteAccount,
                                ),
                                AccountActionItemData(
                                    accountAction: AccountAction.export,
                                    icon: Iconsax.export,
                                    title: dic.profile.exportAccount),
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
