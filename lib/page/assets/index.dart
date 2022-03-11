import 'dart:async';
import 'dart:ui';

import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremonyBox.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/page/assets/receive/receivePage.dart';
import 'package:encointer_wallet/page/assets/transfer/transferPage.dart';
import 'package:encointer_wallet/page/profile/account/accountManagePage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

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
    final Translations dic = I18n.of(context).translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.assets.home),
      ),
      body: SafeArea(
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
                  !_enteredPin & store.settings.cachedPin.isEmpty & !store.settings.endpointIsGesell) {
                // The pin is not immeditally propagated to the store, hence we track if the pin has been entered to prevent
                // showing the dialog multiple times.
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    _showPasswordDialog(context);
                  },
                );
              }

              AccountData accountData = store.account.currentAccount;

              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommunityWithCommunityChooser(store),
                      InkWell(
                        child: Column(
                          children: [
                            AddressIcon(
                              '',
                              pubKey: store.account.currentAccount.pubKey,
                              tapToCopy: false,
                            ),
                            SizedBox(height: 6),
                            Text(
                              Fmt.accountName(context, accountData),
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                        onTap: () => Navigator.of(context).pushNamed(
                          AccountManagePage.route,
                        ),
                      ),
                    ],
                  ),
                  Observer(
                    builder: (_) {
                      return (store.encointer.communityName != null) & (store.encointer.chosenCid != null)
                          ? Column(
                              children: [
                                TextGradient(text: '${Fmt.doubleFormat(store.encointer.communityBalance)} ⵐ'),
                                Text(
                                  "${dic.assets.balance}, ${store.encointer.communitySymbol}",
                                  style: Theme.of(context).textTheme.headline4.copyWith(
                                        color: encointerGrey,
                                      ),
                                ),
                              ],
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: (store.encointer.chosenCid == null)
                                  ? Container(
                                      width: double.infinity,
                                      child: Text(dic.assets.communityNotSelected, textAlign: TextAlign.center))
                                  : Container(
                                      width: double.infinity,
                                      child: CupertinoActivityIndicator(),
                                    ),
                            );
                    },
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              // don't redefine the entire style just the border radii
                              borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.zero),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.receive_square_2),
                                SizedBox(width: 12),
                                Text(dic.assets.receive),
                              ],
                            ),
                          ),
                          key: Key('qr-receive'),
                          onPressed: () {
                            if (accountData.address != '') {
                              Navigator.pushNamed(context, ReceivePage.route);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              // don't redefine the entire style just the border radii
                              borderRadius: BorderRadius.horizontal(left: Radius.zero, right: Radius.circular(15)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(dic.assets.transfer),
                                SizedBox(width: 12),
                                Icon(Iconsax.send_sqaure_2),
                              ],
                            ),
                          ),
                          key: Key('transfer'),
                          onPressed: store.encointer.communityBalance != null
                              ? () {
                                  Navigator.pushNamed(
                                    context,
                                    TransferPage.route,
                                    arguments: TransferPageParams(
                                        redirect: '/',
                                        cid: store.encointer.chosenCid,
                                        communitySymbol: store.encointer.communitySymbol),
                                  );
                                }
                              : null,
                        ),
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
              final Translations dic = I18n.of(context).translationsForLocale();

              return store.settings.isConnected
                  ? FutureBuilder<bool>(
                      future: webApi.encointer.hasPendingIssuance(),
                      builder: (_, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasData) {
                          var hasPendingIssuance = snapshot.data;

                          if (hasPendingIssuance) {
                            return ElevatedButton(
                              child: Text(dic.assets.issuancePending),
                              onPressed: () => submitClaimRewards(context, store.encointer.chosenCid),
                            );
                          } else {
                            return ElevatedButton(
                              child: Text(dic.assets.issuanceClaimed),
                              onPressed: null,
                            );
                          }
                        } else {
                          return CupertinoActivityIndicator();
                        }
                      },
                    )
                  : Container();
            }),
            SizedBox(height: 24),
            CeremonyBox(store: store),
          ],
        ),
      ),
    );
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(I18n.of(context).translationsForLocale().home.unlock),
            (password) {
              setState(() {
                store.settings.setPin(password);
              });
            },
          ),
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
          title: Text(I18n.of(context).translationsForLocale().home.pinNeeded),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.closeApp),
              onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            ),
          ],
        );
      },
    );
  }
}
