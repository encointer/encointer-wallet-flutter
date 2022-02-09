import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/page/account/createAccountEntryPage.dart';
import 'package:encointer_wallet/page/profile/account/accountManagePage.dart';
import 'package:encointer_wallet/page/profile/account/changePasswordPage.dart';
import 'package:encointer_wallet/page/profile/settings/settingsPage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:encointer_wallet/common/components/fadingEdge.dart';

class Profile extends StatefulWidget {
  Profile(this.store);
  final AppStore store;
  @override
  _ProfileState createState() => _ProfileState(store);
}

class _ProfileState extends State<Profile> {
  _ProfileState(this.store);
  final AppStore store;
  EndpointData _selectedNetwork;
  bool developerMode = false;

  void _loadAccountCache() {
    // refresh balance
    store.assets.clearTxs();
    store.assets.loadAccountCache();
    store.encointer.loadCache();
  }

  Future<void> _onSelect(AccountData i, String address) async {
    if (address != store.account.currentAddress) {
      print("changing from addres ${store.account.currentAddress} to $address");

      /// set current account
      store.account.setCurrentAccount(i.pubKey);
      _loadAccountCache();

      /// reload account info
      webApi.assets.fetchBalance();
    }
  }

  Future<void> _onCreateAccount() async {
    Navigator.of(context).pushNamed(CreateAccountEntryPage.route);
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return Container(
          child: showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(I18n.of(context).profile['unlock']),
            (password) {
              setState(() {
                store.settings.setPin(password);
              });
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildAccountList() {
    Color primaryColor = Theme.of(context).primaryColor;

    List<Widget> res = [];

    /// first item is current account
    List<AccountData> accounts = [store.account.currentAccount];

    /// add optional accounts
    accounts.addAll(store.account.optionalAccounts);

    res.addAll(accounts.map((i) {
      String address = i.address;
      if (store.account.pubKeyAddressMap[_selectedNetwork.ss58] != null) {
        address = store.account.pubKeyAddressMap[_selectedNetwork.ss58][i.pubKey];
      }
      return InkWell(
        child: Column(
          children: [
            Stack(
              children: [
                AddressIcon(
                  '',
                  size: 70,
                  pubKey: i.pubKey,
                  // addressToCopy: address,
                  tapToCopy: false,
                ),
                Positioned(
                  bottom: 0, right: 0, //give the values according to your requirement
                  child: Icon(Iconsax.edit, color: primaryColor),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              Fmt.accountName(context, i),
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(width: 80),
          ],
        ),
        onTap: () => {
          _onSelect(i, address),
          Navigator.pushNamed(context, AccountManagePage.route),
        },
      );
    }).toList());
    return res;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color grey = Theme.of(context).unselectedWidgetColor;
    Color primaryColor = Theme.of(context).primaryColor;
    _selectedNetwork = store.settings.endpoint;
    // if all accounts are deleted, go to createAccountPage
    if (store.account.accountListAll.isEmpty) {
      store.settings.setPin('');
      Future.delayed(Duration.zero, () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      });
    }
    final Map<String, String> dic = I18n.of(context).profile;

    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              dic['title'],
              style: Theme.of(context).textTheme.headline3,
            ),
            iconTheme: IconThemeData(
              color: Color(0xff666666), //change your color here
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: Observer(
            builder: (_) {
              if (_selectedNetwork == null) return Container();
              return ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${dic['accounts']}',
                          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black),
                        ),
                        Row(children: <Widget>[
                          IconButton(
                              icon: Icon(Iconsax.add_square),
                              color: primaryColor,
                              onPressed: () => {
                                    store.settings.cachedPin.isEmpty ? _showPasswordDialog(context) : _onCreateAccount()
                                  }),
                          developerMode
                              ? IconButton(
                                  // TODO design decision where to put this functionality
                                  key: Key('choose-network'),
                                  icon: Icon(Icons.menu, color: Colors.orange),
                                  onPressed: () => Navigator.of(context).pushNamed('/network'),
                                )
                              : Container(),
                        ])
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    child: Stack(children: [
                      ListView(
                        padding: EdgeInsets.all(16),
                        children: _buildAccountList(),
                        scrollDirection: Axis.horizontal,
                      ),
                      FadeEndListview(),
                    ]),
                  ),
                  ListTile(
                    title: Text(dic['pass.change']),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, ChangePasswordPage.route),
                  ),
                  ListTile(
                    title: Text(dic['reputation.overall']),
                  ),
                  ListTile(
                    title: Text(dic['ceremonies']),
                  ),
                  ListTile(
                    leading: Container(
                      width: 32,
                      child: Icon(Icons.settings, color: grey, size: 22),
                    ),
                    title: Text(dic['setting']),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.of(context).pushNamed(SettingsPage.route),
                  ),
                  Row(
                    children: <Widget>[
                      Text(dic['developer']),
                      Checkbox(
                        value: developerMode,
                        onChanged: (bool value) {
                          setState(() {
                            developerMode = !developerMode;
                          });
                        },
                      ),
                    ],
                  ),
                  if (developerMode == true)
                    Row(
                      children: [
                        InkWell(
                          key: Key('choose-network'),
                          child: Observer(
                            builder: (_) => Text(
                              "change network (current: ${store.settings.endpoint.info})",
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                          onTap: () => Navigator.of(context).pushNamed('/network'),
                        ),
                        SizedBox(width: 8),
                        store.settings.isConnected
                            ? Icon(Icons.check, color: Colors.green)
                            : CupertinoActivityIndicator(),
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
