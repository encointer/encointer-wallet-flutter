import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

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
    unawaited(showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(context.l10n.loading),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    ));

    await context.read<AppStore>().settings.reloadNetwork(_selectedNetwork);

    if (mounted) {
      Navigator.of(context).pop();
      setState(() {
        _networkChanging = false;
      });
    }
  }

  Future<void> _onSelect(AccountData accountData, String? address) async {
    final isCurrentNetwork = _selectedNetwork.info == context.read<AppStore>().settings.endpoint.info;
    if (address != context.read<AppStore>().account.currentAddress || !isCurrentNetwork) {
      /// set current account
      await context.read<AppStore>().setCurrentAccount(accountData.pubKey);

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

  List<Widget> _buildAccountList() {
    final appStore = context.read<AppStore>();
    final res = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _selectedNetwork.info!.toUpperCase(),
            style: context.bodyLarge.copyWith(color: context.colorScheme.primary),
          ),
        ],
      ),
    ];

    /// first item is current account
    final accounts = <AccountData>[appStore.account.currentAccount, ...appStore.account.optionalAccounts];

    res.addAll(accounts.map((accountData) {
      final address = Fmt.ss58Encode(accountData.pubKey, prefix: appStore.settings.endpoint.ss58 ?? 42);

      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: address == context.read<AppStore>().account.currentAddress
              ? BorderSide(color: context.colorScheme.background)
              : BorderSide.none,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          leading: AddressIcon(address, accountData.pubKey, size: 55),
          title: Text(Fmt.accountName(context, accountData)),
          subtitle: Text(Fmt.address(address)!, maxLines: 2),
          onTap: _networkChanging ? null : () => _onSelect(accountData, address),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingNetwork),
      ),
      body: Row(
        children: <Widget>[
          // left side bar
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: Column(
                children: networks.map((i) {
                  final network = i.info;
                  final isCurrent = network == _selectedNetwork.info;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border:
                          isCurrent ? Border(right: BorderSide(width: 2, color: context.colorScheme.primary)) : null,
                    ),
                    child: IconButton(
                      key: Key(i.info ?? '$i'),
                      icon: Image.asset(networkIconFromNetworkId(network!, isCurrent)),
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
          ),
          Expanded(
            flex: 4,
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

  String networkIconFromNetworkId(String networkId, bool isCurrent) {
    return switch (networkId) {
      'nctr-gsl' => isCurrent ? Assets.images.public.nctrGsl.path : Assets.images.public.nctrGslGray.path,
      'nctr-r' => isCurrent ? Assets.images.public.nctrR.path : Assets.images.public.nctrRGray.path,
      'nctr-k' => isCurrent ? Assets.images.public.nctrK.path : Assets.images.public.nctrKGray.path,
      'nctr-gsl-dev' => isCurrent ? Assets.images.public.nctrGslDev.path : Assets.images.public.nctrGslDevGray.path,
      _ => Assets.images.public.nctrKGray.path,
    };
  }
}
