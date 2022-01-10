import 'dart:async';
import 'dart:ui';

import 'package:encointer_wallet/common/components/BorderedTitle.dart';
import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/iconTextButton.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/page/account/scanPage.dart';
import 'package:encointer_wallet/page/account/uos/qrSignerPage.dart';
import 'package:encointer_wallet/page/assets/asset/assetPage.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/networkSelectPage.dart';
import 'package:encointer_wallet/page/profile/account/accountManagePage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/balancesInfo.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Assets extends StatefulWidget {
  Assets(this.store);

  final AppStore store;

  @override
  _AssetsState createState() => _AssetsState(store);
}

class _AssetsState extends State<Assets> {
  _AssetsState(this.store);

  final AppStore store;

  bool _enteredPin = false;

  @override
  void initState() {
    // if network connected failed, reconnect
    if (!store.settings.loading && store.settings.networkName == null) {
      store.settings.setNetworkLoading(true);
      webApi.connectNodeAll();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).assets;
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        children: [
          Observer(builder: (_) {
            String symbol = store.settings.networkState.tokenSymbol ?? '';

            int decimals = store.settings.networkState.tokenDecimals ?? ert_decimals;
            String networkName = store.settings.networkName ?? '';
            final String tokenView = Fmt.tokenView(symbol);

            List<String> communityIds = [];
            if (store.settings.endpointIsEncointer && networkName != null) {
              if (store.settings.networkConst['communityIds'] != null) {
                communityIds.addAll(List<String>.from(store.settings.networkConst['communityIds']));
              }
              communityIds.retainWhere((i) => i != symbol);
            }
            final BalancesInfo balancesInfo = store.assets.balances[symbol];
            if (ModalRoute.of(context).isCurrent &&
                !_enteredPin & store.account.cachedPin.isEmpty & !store.settings.endpointIsGesell) {
              // The pin is not immeditally propagated to the store, hence we track if the pin has been entered to prevent
              // showing the dialog multiple times.
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  _showPasswordDialog(context);
                },
              );
            }
            var dic = I18n.of(context).assets;
            String network =
                store.settings.loading ? dic['node.connecting'] : store.settings.networkName ?? dic['node.failed'];

            AccountData acc = store.account.currentAccount;

            final accInfo = store.account.accountIndexMap[acc.address];
            final String accIndex =
                accInfo != null && accInfo['accountIndex'] != null ? '${accInfo['accountIndex']}\n' : '';
            final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

            var developerMode = true;
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                      iconData: Icons.person_add_alt,
                      text: I18n.of(context).assets['invite'],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          TransferPage.route,
                          arguments: TransferPageParams(
                              redirect: AssetPage.route,
                              symbol: store.encointer.chosenCid.toFmtString(),
                              isEncointerCommunityCurrency: true,
                              communitySymbol: store.encointer.communitySymbol),
                        );
                      },
                    ),
                    if (developerMode = true)
                      IconButton(
                        // TODO design decision where to put this functionality
                        key: Key('choose-network'),
                        icon: Icon(Icons.menu, color: Colors.orange),
                        onPressed: () => Navigator.of(context).pushNamed('/network'),
                      ),
                    if (developerMode)
                      IconButton(
                        // TODO design decision where to put this functionality
                        key: Key('qr-receive'),
                        icon: Icon(Icons.qr_code_outlined, color: Colors.orange),
                        onPressed: () {
                          if (acc.address != '') {
                            Navigator.pushNamed(context, ReceivePage.route);
                          }
                        },
                      ),
                    // qr-receive text:
                    // Text(
                    //   '$accIndex${Fmt.address(store.account.currentAddress)}',
                    //   style: TextStyle(fontSize: 14),
                    // ),
                    IconTextButton(
                      iconData: Icons.person,
                      text: Fmt.accountName(context, acc),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => AccountManagePage(store),
                        ),
                      ),
                    ),
                  ],
                ),
                CommunityWithCommunityChooser(store),
                Observer(
                  builder: (_) {
                    return (store.encointer.communityName != null) & (store.encointer.chosenCid != null)
                        ? RoundedCard(
                      margin: EdgeInsets.only(top: 16),
                      child: ListTile(
                        key: Key('cid-asset'),
                        leading: Container(
                          width: 36,
                          child: webApi.ipfs
                              .getCommunityIcon(store.encointer.communityIconsCid, devicePixelRatio),
                        ),
                        title: Text(store.encointer.communityName + " (${store.encointer.communitySymbol})"),
                        trailing: store.encointer.communityBalance != null
                            ? Text(
                          Fmt.doubleFormat(store.encointer.communityBalance),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),
                        )
                            : CupertinoActivityIndicator(),
                        onTap: store.encointer.communityBalance != null
                            ? () {
                          Navigator.pushNamed(context, AssetPage.route,
                              arguments: AssetPageParams(
                                  token: store.encointer.chosenCid.toFmtString(),
                                  isEncointerCommunityCurrency: true,
                                  communityName: store.encointer.communityName,
                                  communitySymbol: store.encointer.communitySymbol));
                        }
                            : null,
                      ),
                    )
                        : Container(
                      margin: EdgeInsets.only(top: 16),
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: (store.encointer.chosenCid == null)
                          ? Container(
                          width: double.infinity,
                          child: Text(dic['community.not.selected'], textAlign: TextAlign.center))
                          : Container(
                        width: double.infinity,
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 32),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    Navigator.pushNamed(context, AssetPage.route,
                        arguments: AssetPageParams(token: symbol, isEncointerCommunityCurrency: false));
                  },
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: showPasswordDialogWithAccountSwitch(context, store.account.currentAccount, (password) {
            setState(() {
              store.account.setPin(password);
            });
          },
              () async => {
                    Navigator.of(context).pop(),
                    await Navigator.of(context).pushNamed(NetworkSelectPage.route),
                    setState(() {}),
                  }),
          onWillPop: () {
            // handles back button press
            return _showPasswordNotEnteredDialog(context);
          },
        );
      },
    );
    setState(() {
      _enteredPin = true;
    });
  }

  Future<void> _showPasswordNotEnteredDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context).home['pin.needed']),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).home['cancel']),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).home['close.app']),
              onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleScan() async {
    final Map dic = I18n.of(context).account;
    final data = await Navigator.pushNamed(
      context,
      ScanPage.route,
      arguments: 'tx',
    );
    if (data != null) {
      if (store.account.currentAccount.observation ?? false) {
        showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text(dic['uos.title']),
              content: Text(dic['uos.acc.invalid']),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context).home['ok']),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
        return;
      }

      final Map sender = await webApi.account.parseQrCode(data.toString().trim());
      if (sender['signer'] != store.account.currentAddress) {
        showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text(dic['uos.title']),
              content: sender['error'] != null
                  ? Text(sender['error'])
                  : sender['signer'] == null
                      ? Text(dic['uos.qr.invalid'])
                      : Text(dic['uos.acc.mismatch']),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context).home['ok']),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        showCupertinoDialog(
          context: context,
          builder: (_) {
            return showPasswordInputDialog(
              context,
              store.account.currentAccount,
              Text(dic['uos.title']),
              (password) {
                print('pass ok: $password');
                _signAsync(password);
              },
            );
          },
        );
      }
    }
  }

  Future<void> _signAsync(String password) async {
    final Map dic = I18n.of(context).account;
    final Map signed = await webApi.account.signAsync(password);
    print('signed: $signed');
    if (signed['error'] != null) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(dic['uos.title']),
            content: Text(signed['error']),
            actions: <Widget>[
              CupertinoButton(
                child: Text(I18n.of(context).home['ok']),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    }
    Navigator.of(context).pushNamed(
      QrSignerPage.route,
      arguments: signed['signature'].toString().substring(2),
    );
  }
}
