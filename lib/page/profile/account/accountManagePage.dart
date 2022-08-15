import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/profile/account/exportResultPage.dart';
import 'package:encointer_wallet/page/profile/contacts/accountSharePage.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/encointerBalanceData.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/inputValidation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AccountManagePage extends StatefulWidget {
  const AccountManagePage({Key? key}) : super(key: key);

  static const String route = '/profile/account';

  @override
  _AccountManagePageState createState() => _AccountManagePageState();
}

enum AccountAction { delete, export }

class _AccountManagePageState extends State<AccountManagePage> {
  TextEditingController _nameCtrl = TextEditingController();
  bool _isEditingText = false;

  @override
  void initState() {
    super.initState();
    if (context.read<AppStore>().encointer.chosenCid != null) webApi.encointer.getBootstrappers();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _onDeleteAccount(BuildContext context, AccountData accountToBeEdited) {
    showCupertinoDialog(
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
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () => {
                context.read<AppStore>().account.removeAccount(accountToBeEdited).then(
                  (_) async {
                    // refresh balance
                    await context.read<AppStore>().loadAccountCache();
                    webApi.fetchAccountData();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getBalanceEntryListTile(String cidFmt, BalanceEntry? entry, String? address) {
    final h3 = Theme.of(context).textTheme.headline3!;

    final community = context.read<AppStore>().encointer.communityStores![cidFmt]!;

    Log.p("_getBalanceEntryListTile: ${community.toJson()}", 'accountManegePage.dart');

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      leading: CommunityIcon(
        store: context.read<AppStore>(),
        address: address,
        icon: FutureBuilder<SvgPicture>(
          future: webApi.ipfs.getCommunityIcon(community.assetsCid),
          builder: (_, AsyncSnapshot<SvgPicture> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const CupertinoActivityIndicator();
            }
          },
        ),
      ),
      title: Text(community.name!, style: h3),
      subtitle: Text(community.symbol!, style: h3),
      trailing: Text(
        '${Fmt.doubleFormat(community.applyDemurrage(entry))} ⵐ',
        style: h3.copyWith(color: encointerGrey),
      ),
    );
  }

  void _showPasswordDialog(BuildContext context, AccountData accountToBeEdited) {
    final dic = I18n.of(context)!.translationsForLocale();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return showPasswordInputDialog(context, accountToBeEdited, Text(dic.profile.confirmPin), (password) async {
          Log.d('password is: $password', 'account manege page');
          setState(() {
            context.read<AppStore>().settings.setPin(password);
          });

          final isMnemonic = await context.read<AppStore>().account.checkSeedExist(
                AccountStore.seedTypeMnemonic,
                accountToBeEdited.pubKey,
              );

          if (isMnemonic) {
            final seed = await context.read<AppStore>().account.decryptSeed(
                  accountToBeEdited.pubKey,
                  AccountStore.seedTypeMnemonic,
                  password,
                );

            Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
              'key': seed,
              'type': AccountStore.seedTypeMnemonic,
            });
          } else {
            // Assume that the account was imported via `RawSeed` if mnemonic does not exist.
            showCupertinoDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text(dic.profile.noMnemonicFound),
                  content: Text(dic.profile.importedWithRawSeedHenceNoMnemonic),
                  actions: <Widget>[
                    CupertinoButton(
                      child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final h3 = Theme.of(context).textTheme.headline3;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    final accountToBeEditedPubKey = ModalRoute.of(context)!.settings.arguments as String?;
    final accountToBeEdited = context.read<AppStore>().account.getAccountData(accountToBeEditedPubKey);
    final addressSS58 = context.read<AppStore>().account.getNetworkAddress(accountToBeEditedPubKey);

    _nameCtrl = TextEditingController(text: accountToBeEdited.name);
    _nameCtrl.selection = TextSelection.fromPosition(TextPosition(offset: _nameCtrl.text.length));

    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: _isEditingText
              ? TextFormField(
                  controller: _nameCtrl,
                  validator: (v) => InputValidation.validateAccountName(
                    context,
                    v!,
                    context.read<AppStore>().account.optionalAccounts,
                  ),
                )
              : Text(_nameCtrl.text),
          actions: <Widget>[
            !_isEditingText
                ? IconButton(
                    icon: const Icon(Iconsax.edit),
                    onPressed: () {
                      setState(() {
                        _isEditingText = true;
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      context.read<AppStore>().account.updateAccountName(accountToBeEdited, _nameCtrl.text.trim());
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
                          '',
                          accountToBeEditedPubKey!,
                          size: 130,
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Fmt.address(addressSS58)!, style: const TextStyle(fontSize: 20)),
                          IconButton(
                            icon: const Icon(Iconsax.copy),
                            color: ZurichLion.shade500,
                            onPressed: () => UI.copyAndNotify(context, addressSS58),
                          ),
                        ],
                      ),
                      Text(
                        dic.encointer.communities,
                        style: h3!.copyWith(color: encointerGrey),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                context.read<AppStore>().settings.developerMode
                    ? Expanded(
                        child: ListView.builder(
                            // Fixme: https://github.com/encointer/encointer-wallet-flutter/issues/586
                            itemCount: context.read<AppStore>().encointer.accountStores!.containsKey(addressSS58)
                                ? context
                                        .read<AppStore>()
                                        .encointer
                                        .accountStores![addressSS58]
                                        ?.balanceEntries
                                        .length ??
                                    0
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              final community =
                                  context.read<AppStore>().encointer.account!.balanceEntries.keys.elementAt(index);
                              return _getBalanceEntryListTile(
                                community,
                                context
                                    .read<AppStore>()
                                    .encointer
                                    .accountStores![addressSS58]!
                                    .balanceEntries[community],
                                addressSS58,
                              );
                            }),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: context.read<AppStore>().encointer.chosenCid != null ? 1 : 0,
                            itemBuilder: (BuildContext context, int index) {
                              return _getBalanceEntryListTile(
                                context.read<AppStore>().encointer.chosenCid!.toFmtString(),
                                context.read<AppStore>().encointer.communityBalanceEntry,
                                addressSS58,
                              );
                            }),
                      ),
                Container(
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16), // make splash animation as high as the container
                          primary: Colors.transparent,
                          onPrimary: Colors.white,
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
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AccountSharePage.route,
                          arguments: accountToBeEditedPubKey,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        child: PopupMenuButton<AccountAction>(
                            offset: const Offset(-10, -150),
                            icon: const Icon(Iconsax.more, color: Colors.white),
                            color: ZurichLion.shade50,
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
                                  AccountActionItemData(dic.profile.deleteAccount, AccountAction.delete),
                                  AccountActionItemData(dic.profile.exportAccount, AccountAction.export),
                                ]
                                    .map(
                                      (AccountActionItemData data) => PopupMenuItem<AccountAction>(
                                        value: data.accountAction,
                                        // https://github.com/flutter/flutter/issues/31247 as soon as we use a newer flutter version we might be able to add this to our theme.dart
                                        child: ListTileTheme(
                                          textColor: ZurichLion.shade500,
                                          iconColor: ZurichLion.shade500,
                                          child: ListTile(
                                            minLeadingWidth: 0,
                                            title: Text(data.title),
                                            leading: const Icon(Iconsax.trash),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList() //<PopupMenuEntry<AccountAction>>,
                            ),
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
  const AccountActionItemData(this.title, this.accountAction);
  // in newer flutter versions you can put that stuff into the AccountAction enum and do not need an extra class
  final String title;
  final AccountAction accountAction;
}

class CommunityIcon extends StatelessWidget {
  const CommunityIcon({
    Key? key,
    required this.store,
    required this.icon,
    required this.address,
  }) : super(key: key);

  final AppStore store;
  final Widget icon;
  final String? address;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: icon,
        ),
        Observer(
          builder: (_) {
            if (context.read<AppStore>().encointer.community!.bootstrappers != null &&
                context.read<AppStore>().encointer.community!.bootstrappers!.contains(address)) {
              return const Positioned(
                bottom: 0, right: 0, //give the values according to your requirement
                child: Icon(Iconsax.star, color: Colors.yellow),
              );
            } else
              return const SizedBox();
          },
        ),
      ],
    );
  }
}
