import 'dart:async';
import 'dart:ui';

import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/iconTextButton.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaarMain.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/page/assets/asset/assetPage.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/networkSelectPage.dart';
import 'package:encointer_wallet/page/profile/account/accountManagePage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
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
    Future<void> _submitClaimRewards(BuildContext context) async {
      var args = {
        "title": 'claim_rewards',
        "txInfo": {
          "module": 'encointerCeremonies',
          "call": 'claimRewards',
          "cid": store.encointer.chosenCid,
        },
        "detail": "cid: ${store.encointer.chosenCid.toFmtString()}",
        "params": [store.encointer.chosenCid],
        'onFinish': (BuildContext txPageContext, Map res) {
          Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
        }
      };
      Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
    }

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
        children: [
          Observer(builder: (_) {
            String symbol = store.settings.networkState.tokenSymbol ?? '';

            String networkName = store.settings.networkName ?? '';

            List<String> communityIds = [];
            if (store.settings.endpointIsEncointer && networkName != null) {
              if (store.settings.networkConst['communityIds'] != null) {
                communityIds.addAll(List<String>.from(store.settings.networkConst['communityIds']));
              }
              communityIds.retainWhere((i) => i != symbol);
            }

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
            AccountData acc = store.account.currentAccount;

            var developerMode = true;
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                      iconData: Icons.person_add_alt,
                      text: dic['invite'],
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
                    if (developerMode == true)
                      InkWell(
                        // TODO design decision where to put this functionality
                        key: Key('choose-network'),
                        child: Observer(
                          builder: (_) => Text(
                            "net: ${store.settings.endpoint.info}",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                        onTap: () => Navigator.of(context).pushNamed('/network'),
                      ),
                    // qr-receive text:
                    // Text(
                    //   '$accIndex${Fmt.address(store.account.currentAddress)}',
                    //   style: TextStyle(fontSize: 14),
                    // ),
                    InkWell(
                      child: Column(
                        children: [
                          AddressIcon(
                            '',
                            pubKey: store.account.currentAccount.pubKey,
                            tapToCopy: false,
                          ),
                          Text(
                            Fmt.accountName(context, acc),
                          ),
                        ],
                      ),
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
                        ? Container(
                            margin: EdgeInsets.only(bottom: 32),
                            child: Text(
                                '${Fmt.doubleFormat(store.encointer.communityBalance)} ${store.encointer.communitySymbol}',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconTextButton(
                      text: dic['receive'],
                      iconData: Icons.download_sharp,
                      key: Key('qr-receive'),
                      onTap: () {
                        if (acc.address != '') {
                          Navigator.pushNamed(context, ReceivePage.route);
                        }
                      },
                    ),
                    IconTextButton(
                      text: dic['bazaar'],
                      iconData: Icons.shopping_bag_sharp,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          BazaarMain.route,
                        );
                      },
                    ),
                    IconTextButton(
                      key: Key('transfer'),
                      text: dic['transfer'],
                      iconData: Icons.upload_sharp,
                      onTap: store.encointer.communityBalance != null
                          ? () {
                              Navigator.pushNamed(
                                context,
                                TransferPage.route,
                                arguments: TransferPageParams(
                                    redirect: '/',
                                    symbol: store.encointer.chosenCid.toFmtString(),
                                    isEncointerCommunityCurrency: true,
                                    communitySymbol: store.encointer.communitySymbol),
                              );
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
          ),
          Observer(builder: (_) {
            var dic = I18n.of(context).assets;

            return store.settings.isConnected
                ? FutureBuilder<bool>(
                    future: webApi.encointer.hasPendingIssuance(),
                    builder: (_, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasData) {
                        var hasPendingIssuance = snapshot.data;

                        if (hasPendingIssuance) {
                          return RoundedButton(
                            text: dic['issuance.pending'],
                            onPressed: () => _submitClaimRewards(context),
                          );
                        } else {
                          return RoundedButton(
                            text: dic['issuance.claimed'],
                            onPressed: null,
                            color: Theme.of(context).disabledColor,
                          );
                        }
                      } else {
                        return CupertinoActivityIndicator();
                      }
                    },
                  )
                : Container();
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
}
