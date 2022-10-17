import 'package:encointer_wallet/modules/modules.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/add_account_page.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/page/profile/about_page.dart';
import 'package:encointer_wallet/page/profile/account/account_manage_page.dart';
import 'package:encointer_wallet/page/profile/account/change_password_page.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  EndpointData? _selectedNetwork;

  List<Widget> _buildAccountList() {
    List<Widget> allAccountsAsWidgets = [];

    List<AccountData> accounts = context.read<AppStore>().account.accountListAll;

    allAccountsAsWidgets.addAll(accounts.map((account) {
      return InkWell(
        child: Column(
          children: [
            Stack(
              children: [
                AddressIcon(
                  '',
                  account.pubKey,
                  size: 70,
                  tapToCopy: false,
                ),
                Positioned(
                  bottom: 0,
                  right: 0, //give the values according to your requirement
                  child: Icon(Iconsax.edit, color: ZurichLion.shade800),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              Fmt.accountName(context, account),
              style: Theme.of(context).textTheme.headline4,
            ),
            // This sizedBox is here to define a distance between the accounts
            const SizedBox(width: 100),
          ],
        ),
        onTap: () => {
          Navigator.pushNamed(context, AccountManagePage.route, arguments: account.pubKey),
        },
      );
    }).toList());
    return allAccountsAsWidgets;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h3Grey = Theme.of(context).textTheme.headline3!.copyWith(color: encointerGrey);
    final _store = context.watch<AppStore>();
    _selectedNetwork = _store.settings.endpoint;

    // if all accounts are deleted, go to createAccountPage
    if (_store.account.accountListAll.isEmpty) {
      _store.settings.setPin('');
      Future.delayed(Duration.zero, () {
        Navigator.pop(context);
      });
    }
    final Translations dic = I18n.of(context)!.translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.title),
        iconTheme: const IconThemeData(color: encointerGrey), //change your color here,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Observer(
        builder: (_) {
          if (_selectedNetwork == null) return Container();
          return ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      dic.profile.accounts,
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.add_square),
                      color: ZurichLion.shade500,
                      onPressed: () => Navigator.of(context).pushNamed(AddAccountPage.route),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                      ],
                      stops: [0.0, 0.1, 0.9, 1.0],
                    ).createShader(bounds);
                  },
                  child: ListView(
                    children: _buildAccountList(),
                    scrollDirection: Axis.horizontal,
                  ),
                  // blendMode: BlendMode.dstATop,
                ),
              ),
              ListTile(
                title: Text(
                  dic.profile.changeYourPin,
                  style: Theme.of(context).textTheme.headline3,
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.pushNamed(context, ChangePasswordPage.route),
              ),
              ListTile(
                title: Text(dic.profile.accountsDeleteAll, style: h3Grey),
                onTap: () => showRemoveAccountsDialog(context, _store),
              ),
              ListTile(
                  title: Text(dic.profile.reputationOverall, style: h3Grey),
                  trailing: _store.encointer.account?.reputations != null
                      ? Text(_store.encointer.account?.reputations.length.toString() ?? 0.toString())
                      : Text(dic.encointer.fetchingReputations)),
              ListTile(
                title: Text(dic.profile.about, style: Theme.of(context).textTheme.headline3),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.pushNamed(context, AboutPage.route),
              ),
              ListTile(
                title: Text(dic.profile.appHints, style: h3Grey),
                onTap: () => Navigator.pushNamed(context, Instruction.route),
              ),
              ListTile(
                title: Text(dic.profile.developer, style: h3Grey),
                trailing: Checkbox(
                  value: _store.settings.developerMode,
                  onChanged: (_) => _store.settings.toggleDeveloperMode(),
                ),
              ),
              if (_store.settings.developerMode)
                // Column in case we add more developer options
                Column(
                  children: <Widget>[
                    ListTile(
                      title: InkWell(
                        key: const Key('choose-network'),
                        child: Observer(
                          builder: (_) => Text(
                            'Change network (current: ${_store.settings.endpoint.info})', // for devs only
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        onTap: () => Navigator.of(context).pushNamed('/network'),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 13), // align with developer checkbox above
                        child: _store.settings.isConnected
                            ? const Icon(Icons.check, color: Colors.green)
                            : const CupertinoActivityIndicator(),
                      ),
                    ),
                    ListTile(
                      title: Text(dic.profile.enableBazaar, style: h3Grey),
                      trailing: Checkbox(
                        value: _store.settings.enableBazaar,
                        // Fixme: Need to change the tab to update the tabList. But, do we care? This is only
                        // temporary, and a developer option. It is unnecessary to include the complexity to update
                        // the parent widget from here.
                        onChanged: (_) => _store.settings.toggleEnableBazaar(),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

Future<void> showRemoveAccountsDialog(BuildContext context, AppStore _store) {
  final dic = I18n.of(context)!.translationsForLocale();

  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(dic.profile.accountsDelete),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoButton(
            child: Text(dic.home.ok),
            onPressed: () async {
              final accounts = _store.account.accountListAll;

              for (var acc in accounts) {
                await _store.account.removeAccount(acc);
              }

              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => CreateAccountEntryPage()),
                (route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}
