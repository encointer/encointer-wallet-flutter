import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/add_account_page.dart';
import 'package:encointer_wallet/page/profile/about_page.dart';
import 'package:encointer_wallet/page/profile/account/account_manage_page.dart';
import 'package:encointer_wallet/page/profile/account/change_password_page.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatefulWidget {
  Profile(this.store);

  final AppStore store;

  @override
  _ProfileState createState() => _ProfileState(store);
}

class _ProfileState extends State<Profile> {
  _ProfileState(this.store);

  final AppStore store;
  EndpointData? _selectedNetwork;

  List<Widget> _buildAccountList() {
    List<Widget> allAccountsAsWidgets = [];

    List<AccountData> accounts = store.account.accountListAll;

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
            SizedBox(height: 6),
            Text(
              Fmt.accountName(context, account),
              style: Theme.of(context).textTheme.headline4,
            ),
            // This sizedBox is here to define a distance between the accounts
            SizedBox(width: 100),
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
    _selectedNetwork = store.settings.endpoint;

    // if all accounts are deleted, go to createAccountPage
    if (store.account.accountListAll.isEmpty) {
      store.settings.setPin('');
      Future.delayed(Duration.zero, () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      });
    }
    final Translations dic = I18n.of(context)!.translationsForLocale();

    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(dic.profile.title),
            iconTheme: IconThemeData(color: encointerGrey), //change your color here,
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
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${dic.profile.accounts}',
                          style: Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack),
                        ),
                        IconButton(
                            icon: Icon(Iconsax.add_square),
                            color: ZurichLion.shade500,
                            onPressed: () => Navigator.of(context).pushNamed(AddAccountPage.route)),
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
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, ChangePasswordPage.route),
                  ),
                  ListTile(
                    title: Text(dic.profile.accountsDeleteAll, style: h3Grey),
                    onTap: () => showRemoveAccountsDialog(context, store),
                  ),
                  ListTile(
                      title: Text(dic.profile.reputationOverall, style: h3Grey),
                      trailing: store.encointer.account?.reputations != null
                          ? Text(store.encointer.account?.reputations.length.toString() ?? 0.toString())
                          : Text(dic.encointer.fetchingReputations)),
                  ListTile(
                    title: Text(dic.profile.about, style: Theme.of(context).textTheme.headline3),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, AboutPage.route),
                  ),
                  ListTile(
                    title: Text(dic.profile.developer, style: h3Grey),
                    trailing: Checkbox(
                      value: store.settings.developerMode,
                      onChanged: (_) => store.settings.toggleDeveloperMode(),
                    ),
                  ),
                  if (store.settings.developerMode)
                    // Column in case we add more developer options
                    Column(
                      children: <Widget>[
                        ListTile(
                          title: InkWell(
                            key: Key('choose-network'),
                            child: Observer(
                              builder: (_) => Text(
                                "Change network (current: ${store.settings.endpoint.info})", // for devs only
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            onTap: () => Navigator.of(context).pushNamed('/network'),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: 13), // align with developer checkbox above
                            child: store.settings.isConnected
                                ? Icon(Icons.check, color: Colors.green)
                                : CupertinoActivityIndicator(),
                          ),
                        ),
                        ListTile(
                          title: Text(dic.profile.enableBazaar, style: h3Grey),
                          trailing: Checkbox(
                            value: store.settings.enableBazaar,
                            // Fixme: Need to change the tab to update the tabList. But, do we care? This is only
                            // temporary, and a developer option. It is unnecessary to include the complexity to update
                            // the parent widget from here.
                            onChanged: (_) => store.settings.toggleEnableBazaar(),
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

Future<void> showRemoveAccountsDialog(BuildContext context, AppStore store) {
  final dic = I18n.of(context)!.translationsForLocale();

  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(title: Text(dic.profile.accountsDelete), actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoButton(
              child: Text(dic.home.ok),
              onPressed: () async {
                final accounts = store.account.accountListAll;

                for (var acc in accounts) {
                  await store.account.removeAccount(acc);
                }

                Navigator.of(context).pop();
              }),
        ]);
      });
}
