import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/editIcon.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/page/account/createAccountEntryPage.dart';
import 'package:encointer_wallet/page/profile/account/changePasswordPage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  // todo not sure if this is necessary

  void _loadAccountCache() {
    // refresh balance
    store.assets.clearTxs();
    store.assets.loadAccountCache();
    store.encointer.loadCache();
  }

  Future<void> _onSelect(AccountData i, String address) async {
    if (address != store.account.currentAddress) {
      print("we are here changing from addres ${store.account.currentAddress} to $address");

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
          child: PasswordInputDialog(
            title: Text(I18n.of(context).profile['unlock']),
            account: store.account.currentAccount,
            onOk: (password) {
              setState(() {
                store.settings.setPin(password);
              });
            },
            onCancel: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  List<Widget> _buildAccountList() {
    final Map<String, String> dic = I18n.of(context).profile;
    Color primaryColor = Theme.of(context).primaryColor;
    List<Widget> res = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '${dic['accounts']} in ${_selectedNetwork.info.toUpperCase()}',
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(children: <Widget>[
            Text(dic['add']),
            IconButton(
                icon: Image.asset('assets/images/assets/plus_indigo.png'),
                color: primaryColor,
                onPressed: () async => {
                      if (store.settings.cachedPin.isEmpty)
                        {
                          await _showPasswordDialog(context),
                        }
                      else
                        {
                          _onCreateAccount(),
                        }
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
    ];

    /// first item is current account
    List<AccountData> accounts = [store.account.currentAccount];

    /// add optional accounts
    accounts.addAll(store.account.optionalAccounts);

    res.addAll(accounts.map((i) {
      String address = i.address;
      if (store.account.pubKeyAddressMap[_selectedNetwork.ss58] != null) {
        address = store.account.pubKeyAddressMap[_selectedNetwork.ss58][i.pubKey];
      }
      final bool isCurrentNetwork = _selectedNetwork.info == store.settings.endpoint.info;
      final accInfo = store.account.accountIndexMap[i.address];
      final String accIndex =
          isCurrentNetwork && accInfo != null && accInfo['accountIndex'] != null ? '${accInfo['accountIndex']}\n' : '';
      final double padding = accIndex.isEmpty ? 0 : 7;
      return RoundedCard(
        border: address == store.account.currentAddress
            ? Border.all(color: Colors.amber)
            : Border.all(color: Theme.of(context).cardColor),
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.only(top: padding, bottom: padding),
        child: ListTile(
          leading: AddressIcon('', pubKey: i.pubKey, addressToCopy: address),
          title: Text(Fmt.accountName(context, i)),
          subtitle: Text('$accIndex${Fmt.address(address)}', maxLines: 2),
          onTap: () => _onSelect(i, address),
          selected: address == store.account.currentAddress,
          trailing: EditIcon(i, address, 40, store),
        ),
      );
    }).toList());
    return res;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedNetwork = store.settings.endpoint;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Todo it works, but its not working nice, when last account deleted, it goes to account createpage, but shows shortly a red screen, find out why (nvaigator.dart: Failed assertion: line 4112 pos 12: '!_debugLocked': is not true.)
    if (store.account.accountListAll.isEmpty) {
      Future.delayed(Duration.zero, () {
        Navigator.popUntil(context, ModalRoute.withName('/'));
      });
    }
    final Map<String, String> dic = I18n.of(context).profile;
    // final Color grey = Theme.of(context).unselectedWidgetColor;

    return Observer(
      builder: (_) {
        // AccountData acc = store.account.currentAccount;
        // Color primaryColor = Theme.of(context).primaryColor;
        return Scaffold(
          appBar: AppBar(
            title: Text(dic['title']),
            centerTitle: true,
            elevation: 0.0,
          ),
          body: Observer(
            builder: (_) {
              if (_selectedNetwork == null) return Container();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 350,
                    child: ListView(
                      padding: EdgeInsets.all(16),
                      children: _buildAccountList(),
                      // scrollDirection: Axis.horizontal,
                    ),
                  ),
                  ListTile(
                    title: Text(dic['pass.change']),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () => Navigator.pushNamed(context, ChangePasswordPage.route),
                  ),
                  Row(
                    children: <Widget>[
                      Text('developer mode'),
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
                ],
              );
            },
          ),
        );
      },
    );
  }
}
