import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page/account/createAccountEntryPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NetworkSelectPage extends StatefulWidget {
  const NetworkSelectPage({Key? key}) : super(key: key);

  static const String route = '/network';

  @override
  _NetworkSelectPageState createState() => _NetworkSelectPageState();
}

class _NetworkSelectPageState extends State<NetworkSelectPage> {
  // Here we commented out the two not-active networks of Cantillon. When they will be relevant, they can be uncommented #232
  final List<EndpointData> networks = [
    networkEndpointEncointerGesell,
    networkEndpointEncointerLietaer,
    networkEndpointEncointerMainnet,
    networkEndpointEncointerGesellDev,
    // networkEndpointEncointerCantillon,
    // networkEndpointEncointerCantillonDev
  ];

  EndpointData? _selectedNetwork;
  bool _networkChanging = false;

  Future<void> _reloadNetwork(BuildContext context) async {
    setState(() {
      _networkChanging = true;
    });
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context)!.translationsForLocale().home.loading),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );

    await context.read<AppStore>().settings.reloadNetwork(_selectedNetwork!);

    // widget.changeTheme();

    if (mounted) {
      Navigator.of(context).pop();
      setState(() {
        _networkChanging = false;
      });
    }
  }

  Future<void> _onSelect(AccountData i, String? address, BuildContext context) async {
    final _store = context.read<AppStore>();
    bool isCurrentNetwork = _selectedNetwork!.info == _store.settings.endpoint.info;
    if (address != _store.account.currentAddress || !isCurrentNetwork) {
      /// set current account
      _store.setCurrentAccount(i.pubKey);

      if (isCurrentNetwork) {
        await _store.loadAccountCache();

        webApi.fetchAccountData();
      } else {
        /// set new network and reload web view
        await _reloadNetwork(context);
      }
    }
    Navigator.of(context).pop();
  }

  Future<void> _onCreateAccount(BuildContext context) async {
    bool isCurrentNetwork = _selectedNetwork!.info == context.read<AppStore>().settings.endpoint.info;
    if (!isCurrentNetwork) {
      await _reloadNetwork(context);
    }
    Navigator.of(context).pushNamed(CreateAccountEntryPage.route);
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return Container(
          child: showPasswordInputDialog(
            context,
            context.read<AppStore>().account.currentAccount,
            Text(I18n.of(context)!.translationsForLocale().profile.unlock),
            (password) {
              setState(() {
                context.read<AppStore>().settings.setPin(password);
              });
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildAccountList(BuildContext context) {
    final _store = context.read<AppStore>();
    final primaryColor = Theme.of(context).primaryColor;
    List<Widget> res = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedNetwork!.info!.toUpperCase(),
            style: Theme.of(context).textTheme.headline4,
          ),
          IconButton(
              icon: Image.asset('assets/images/assets/plus_indigo.png'),
              color: primaryColor,
              onPressed: () async => {
                    if (context.read<AppStore>().settings.cachedPin.isEmpty)
                      {
                        await _showPasswordDialog(context),
                      }
                    else
                      {
                        _onCreateAccount(context),
                      }
                  })
        ],
      ),
    ];

    /// first item is current account
    List<AccountData> accounts = [_store.account.currentAccount];

    /// add optional accounts
    accounts.addAll(_store.account.optionalAccounts);

    res.addAll(accounts.map((i) {
      String? address = i.address;
      if (_store.account.pubKeyAddressMap[_selectedNetwork!.ss58] != null) {
        address = _store.account.pubKeyAddressMap[_selectedNetwork!.ss58]![i.pubKey];
      }
      final isCurrentNetwork = _selectedNetwork!.info == _store.settings.endpoint.info;
      final accInfo = _store.account.accountIndexMap[i.address];
      final accIndex =
          isCurrentNetwork && accInfo != null && accInfo['accountIndex'] != null ? '${accInfo['accountIndex']}\n' : '';
      final padding = accIndex.isEmpty ? 0.0 : 7.0;
      return RoundedCard(
        border: address == _store.account.currentAddress
            ? Border.all(color: Theme.of(context).primaryColorLight)
            : Border.all(color: Theme.of(context).cardColor),
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.only(top: padding, bottom: padding),
        child: ListTile(
          leading: AddressIcon(address!, i.pubKey),
          title: Text(Fmt.accountName(context, i)),
          subtitle: Text('$accIndex${Fmt.address(address)}', maxLines: 2),
          onTap: _networkChanging ? null : () => _onSelect(i, address, context),
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
        _selectedNetwork = context.read<AppStore>().settings.endpoint;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.settingNetwork),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          if (_selectedNetwork == null) return const SizedBox();
          return Row(
            children: [
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
                    final isCurrent = network == _selectedNetwork!.info;
                    final img = 'assets/images/public/$network${isCurrent ? '' : '_gray'}.png';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(right: 8),
                      decoration: isCurrent
                          ? BoxDecoration(
                              border: Border(right: BorderSide(width: 2, color: Theme.of(context).primaryColor)))
                          : null,
                      child: IconButton(
                        padding: const EdgeInsets.all(8),
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
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: _buildAccountList(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
