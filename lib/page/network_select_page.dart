import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/common/components/rounded_card.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page/account/create_account_entry_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class NetworkSelectPage extends StatefulWidget {
  const NetworkSelectPage({super.key});

  static const String route = '/network';

  @override
  State<NetworkSelectPage> createState() => _NetworkSelectPageState();
}

class _NetworkSelectPageState extends State<NetworkSelectPage> {
  // Here we commented out the two not-active networks of Cantillon.
  // When they will be relevant, they can be uncommented #232
  final List<EndpointData> networks = [
    networkEndpointEncointerGesell,
    networkEndpointEncointerLietaer,
    networkEndpointEncointerMainnet,
    networkEndpointEncointerGesellDev,
    // networkEndpointEncointerCantillon,
    // networkEndpointEncointerCantillonDev
  ];

  late EndpointData _selectedNetwork;
  bool _networkChanging = false;

  Future<void> _reloadNetwork() async {
    setState(() {
      _networkChanging = true;
    });
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context)!.translationsForLocale().home.loading),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );

    await context.read<AppStore>().settings.reloadNetwork(_selectedNetwork);

    context.read<AppStore>().settings.changeTheme();

    if (mounted) {
      Navigator.of(context).pop();
      setState(() {
        _networkChanging = false;
      });
    }
  }

  Future<void> _onSelect(AccountData i, String? address) async {
    final isCurrentNetwork = _selectedNetwork.info == context.read<AppStore>().settings.endpoint.info;
    if (address != context.read<AppStore>().account.currentAddress || !isCurrentNetwork) {
      /// set current account
      context.read<AppStore>().setCurrentAccount(i.pubKey);

      if (isCurrentNetwork) {
        await context.read<AppStore>().loadAccountCache();

        webApi.fetchAccountData();
      } else {
        /// set new network and reload web view
        await _reloadNetwork();
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _onCreateAccount() async {
    final isCurrentNetwork = _selectedNetwork.info == context.read<AppStore>().settings.endpoint.info;
    if (!isCurrentNetwork) {
      await _reloadNetwork();
    }
    Navigator.of(context).pushNamed(CreateAccountEntryPage.route);
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (_) {
        return Container(
          child: showPasswordInputDialog(
            context,
            context.read<AppStore>().account.currentAccount,
            Text(I18n.of(context)!.translationsForLocale().profile.unlock),
            (String password) {
              setState(() {
                context.read<AppStore>().settings.setPin(password);
              });
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildAccountList() {
    // final primaryColor = Theme.of(context).primaryColor;
    final res = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _selectedNetwork.info!.toUpperCase(),
            style: Theme.of(context).textTheme.headline4,
          ),
          IconButton(
              icon: Image.asset('assets/images/assets/plus_indigo.png'),
              color: Theme.of(context).primaryColor,
              onPressed: () async => {
                    if (context.read<AppStore>().settings.cachedPin.isEmpty)
                      {
                        await _showPasswordDialog(context),
                      }
                    else
                      {
                        _onCreateAccount(),
                      }
                  })
        ],
      ),
    ];

    /// first item is current account
    final accounts = <AccountData>[
      context.read<AppStore>().account.currentAccount,
      ...context.read<AppStore>().account.optionalAccounts
    ];
    
    res.addAll(accounts.map((i) {
      String? address = i.address;
      if (context.read<AppStore>().account.pubKeyAddressMap[_selectedNetwork.ss58] != null) {
        address = context.read<AppStore>().account.pubKeyAddressMap[_selectedNetwork.ss58]![i.pubKey];
      }
      final isCurrentNetwork = _selectedNetwork.info == context.read<AppStore>().settings.endpoint.info;
      final accInfo = context.read<AppStore>().account.accountIndexMap[i.address];
      final accIndex =
          isCurrentNetwork && accInfo != null && accInfo['accountIndex'] != null ? '${accInfo['accountIndex']}\n' : '';
      final padding = accIndex.isEmpty ? 0.0 : 7.0;
      return RoundedCard(
        border: address == context.read<AppStore>().account.currentAddress
            ? Border.all(color: Theme.of(context).primaryColorLight)
            : Border.all(color: Theme.of(context).cardColor),
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.only(top: padding, bottom: padding),
        child: ListTile(
          leading: AddressIcon(address!, i.pubKey),
          title: Text(Fmt.accountName(context, i)),
          subtitle: Text('$accIndex${Fmt.address(address)}', maxLines: 2),
          onTap: _networkChanging ? null : () => _onSelect(i, address),
        ),
      );
    }).toList());
    return res;
  }

  @override
  void initState() {
    super.initState();

    _selectedNetwork = context.read<AppStore>().settings.endpoint;
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.settingNetwork),
        centerTitle: true,
      ),
      body: Row(
        children: <Widget>[
          // left side bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0, // has the effect of softening the shadow
                  spreadRadius: 2.0, // ha
                )
              ],
            ),
            child: Column(
              children: networks.map((i) {
                final network = i.info;
                final isCurrent = network == _selectedNetwork.info;
                final img = 'assets/images/public/$network${isCurrent ? '' : '_gray'}.png';
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.only(right: 8),
                  decoration: isCurrent
                      ? BoxDecoration(
                          border: Border(right: BorderSide(width: 2, color: Theme.of(context).primaryColor)),
                        )
                      : null,
                  child: IconButton(
                    key: Key(i.info ?? '$i'),
                    icon: Image.asset(img),
                    onPressed: () {
                      if (!isCurrent) {
                        setState(() {
                          _selectedNetwork = i;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: _buildAccountList(),
              );
            }),
          ),
        ],
      ),
    );
  }
}
