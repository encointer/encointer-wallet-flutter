import 'dart:math';

import 'package:encointer_wallet/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/drag_handle.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page/account/create/add_account_page.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';
import 'package:encointer_wallet/page/assets/account_or_community/switch_account_or_community.dart';
import 'package:encointer_wallet/page/assets/receive/receive_page.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class Assets extends StatefulWidget {
  Assets(this.store, {Key? key}) : super(key: key);

  final AppStore store;

  @override
  State<Assets> createState() => _AssetsState(store);
}

class _AssetsState extends State<Assets> {
  _AssetsState(this.store);

  final AppStore store;
  static const double panelHeight = 396;
  static const double fractionOfScreenHeight = .7;
  static const double avatarSize = 70;

  bool _enteredPin = false;

  PanelController? panelController;

  PausableTimer? balanceWatchdog;

  @override
  void initState() {
    // if network connected failed, reconnect
    if (!store.settings.loading && store.settings.networkName == null) {
      store.settings.setNetworkLoading(true);
      webApi.connectNodeAll();
    }

    if (panelController == null) {
      panelController = PanelController();
    }

    super.initState();
  }

  @override
  void dispose() {
    balanceWatchdog!.cancel();
    super.dispose();
  }

  late double _panelHeightOpen;
  final double _panelHeightClosed = 0;
  Translations? dic;

  Future<void> _refreshEncointerState() async {
    // getCurrentPhase is the root of all state updates.
    await webApi.encointer.getCurrentPhase();
  }

  @override
  Widget build(BuildContext context) {
    dic = I18n.of(context)!.translationsForLocale();
    _panelHeightOpen = min(MediaQuery.of(context).size.height * fractionOfScreenHeight,
        panelHeight); // should typically not be higher than panelHeight, but on really small devices it should not exceed fractionOfScreenHeight x the screen height.

    List<AccountOrCommunityData> allCommunities = [];
    List<AccountOrCommunityData> allAccounts = [];

    balanceWatchdog = PausableTimer(
      const Duration(seconds: 12),
      () {
        Log.d('[balanceWatchdog] triggered', 'Assets');

        _refreshBalanceAndNotify(dic);
        balanceWatchdog!
          ..reset()
          ..start();
      },
    )..start();

    final appBar = AppBar(
      key: const Key('assets-index-appbar'),
      title: Text(dic!.assets.home),
    );

    return FocusDetector(
      onFocusLost: () {
        print('[home:FocusDetector] Focus Lost.');
        balanceWatchdog!.pause();
      },
      onFocusGained: () {
        print('[home:FocusDetector] Focus Gained.');
        if (!store.settings.loading) {
          _refreshBalanceAndNotify(dic);
        }
        balanceWatchdog!.reset();
        balanceWatchdog!.start();
      },
      child: Scaffold(
        appBar: appBar,
        body: UpgradeAlert(
          upgrader: Upgrader(
            appcastConfig: context.watch<AppStore>().appcastConfiguration,
            debugLogging: context.select<AppStore, bool>((e) => e.appcastConfiguration != null),
            shouldPopScope: () => true,
            canDismissDialog: true,
          ),
          child: SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            backdropEnabled: true,
            controller: panelController,
            // The padding is a hack for #559, which needs https://github.com/akshathjain/sliding_up_panel/pull/303
            body: Padding(
              padding:
                  // Fixme: 60 is hardcoded because we don't know the tabBar size here.
                  // Should be tackled in #607
                  EdgeInsets.only(bottom: 60 + appBar.preferredSize.height + MediaQuery.of(context).viewPadding.top),
              child: RefreshIndicator(
                onRefresh: _refreshEncointerState,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  children: [
                    Observer(builder: (_) {
                      if (ModalRoute.of(context)!.isCurrent &&
                          !_enteredPin & store.settings.cachedPin.isEmpty & !store.settings.endpointIsNoTee) {
                        // The pin is not immediately propagated to the store, hence we track if the pin has been entered to prevent
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
                              InkWell(
                                  child: CombinedCommunityAndAccountAvatar(store),
                                  onTap: () {
                                    if (panelController != null && panelController!.isAttached) {
                                      panelController!.open();
                                    }
                                  }),
                            ],
                          ),
                          Observer(
                            builder: (_) {
                              return (store.encointer.community?.name != null) & (store.encointer.chosenCid != null)
                                  ? Column(
                                      children: [
                                        TextGradient(
                                          text: '${Fmt.doubleFormat(store.encointer.communityBalance)} ⵐ',
                                          style: const TextStyle(fontSize: 60),
                                        ),
                                        Text(
                                          '${dic!.assets.balance}, ${store.encointer.community?.symbol}',
                                          style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: (store.encointer.chosenCid == null)
                                          ? SizedBox(
                                              width: double.infinity,
                                              child:
                                                  Text(dic!.assets.communityNotSelected, textAlign: TextAlign.center))
                                          : const SizedBox(
                                              width: double.infinity,
                                              child: const CupertinoActivityIndicator(),
                                            ),
                                    );
                            },
                          ),
                          if (store.settings.developerMode)
                            ElevatedButton(
                              onPressed: store.dataUpdate.setInvalidated,
                              child: const Text('Invalidate data to trigger state update'),
                            ),
                          const SizedBox(
                            height: 42,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      // don't redefine the entire style just the border radii
                                      borderRadius:
                                          BorderRadius.horizontal(left: Radius.circular(15), right: Radius.zero),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.receive_square_2),
                                        const SizedBox(width: 12),
                                        Text(dic!.assets.receive),
                                      ],
                                    ),
                                  ),
                                  key: const Key('qr-receive'),
                                  onPressed: () {
                                    if (accountData.address != '') {
                                      Navigator.pushNamed(context, ReceivePage.route);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      // don't redefine the entire style just the border radii
                                      borderRadius:
                                          BorderRadius.horizontal(left: Radius.zero, right: Radius.circular(15)),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(dic!.assets.transfer),
                                        const SizedBox(width: 12),
                                        const Icon(Iconsax.send_sqaure_2),
                                      ],
                                    ),
                                  ),
                                  key: const Key('transfer'),
                                  onPressed: store.encointer.communityBalance != null
                                      ? () => Navigator.pushNamed(context, TransferPage.route)
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                    ),
                    Observer(builder: (_) {
                      final Translations dic = I18n.of(context)!.translationsForLocale();

                      final shouldFetch = store.encointer.currentPhase == CeremonyPhase.Registering ||
                          (store.encointer.communityAccount?.meetupCompleted ?? false);

                      return store.settings.isConnected && shouldFetch
                          ? FutureBuilder<bool?>(
                              future: webApi.encointer.hasPendingIssuance(),
                              builder: (_, AsyncSnapshot<bool?> snapshot) {
                                if (snapshot.hasData) {
                                  var hasPendingIssuance = snapshot.data!;

                                  if (hasPendingIssuance) {
                                    return SubmitButton(
                                      child: Text(dic.assets.issuancePending),
                                      onPressed: (context) => submitClaimRewards(
                                        context,
                                        store,
                                        webApi,
                                        store.encointer.chosenCid!,
                                      ),
                                    );
                                  } else {
                                    return store.settings.developerMode
                                        ? ElevatedButton(
                                            child: Text(dic.assets.issuanceClaimed),
                                            onPressed: null,
                                          )
                                        : Container();
                                  }
                                } else {
                                  return const CupertinoActivityIndicator();
                                }
                              },
                            )
                          : Container();
                    }),
                    const SizedBox(height: 24),
                    CeremonyBox(store, webApi),
                  ],
                ),
              ),
            ),
            // panel entering from below
            panelBuilder: (scrollController) => MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                controller: scrollController,
                children: <Widget>[
                  const SizedBox(
                    height: 12.0,
                  ),
                  const DragHandle(),
                  Column(children: [
                    Observer(
                      builder: (BuildContext context) {
                        allCommunities = initAllCommunities();
                        return SwitchAccountOrCommunity(
                          rowTitle: dic!.home.switchCommunity,
                          data: allCommunities,
                          onTap: (int index) {
                            if (index == allCommunities.length - 1) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityChooserOnMap(store)))
                                  .then((_) {
                                _refreshBalanceAndNotify(dic);
                              });
                            } else {
                              setState(() {
                                // TODO
                              });
                            }
                          },
                        );
                      },
                    ),
                    Observer(builder: (BuildContext context) {
                      allAccounts = initAllAccounts(dic!);
                      return SwitchAccountOrCommunity(
                        rowTitle: dic!.home.switchAccount,
                        data: allAccounts,
                        onTap: (int index) {
                          if (index == allAccounts.length - 1) {
                            Navigator.of(context).pushNamed(AddAccountPage.route);
                          } else {
                            setState(() {
                              switchAccount(store.account.accountListAll[index]);
                              _refreshBalanceAndNotify(dic);
                            });
                          }
                        },
                      );
                    }),
                  ]),
                ],
              ),
            ),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          ),
        ),
      ),
    );
  }

  List<AccountOrCommunityData> initAllCommunities() {
    List<AccountOrCommunityData> allCommunities = [];
    // TODO #507 add back end code so we can initialize the list of communities similar to the commented out code
    // allCommunities.addAll(store.communities.communitiesList.map((community) => AccountOrCommunityData(
    //     avatar: webApi.ipfs.getCommunityIcon(community),
    //     name: community.name)));

    // For now show the selected community if available and let the user add a community from the world map community chooser
    allCommunities.add(
      AccountOrCommunityData(
        avatar: const CommunityAvatar(avatarSize: avatarSize),
        name: store.encointer.community?.name ?? '...',
        isSelected: true, // TODO #507 this should later be a function applied on each community, cf. initAllAccounts
      ),
    );
    allCommunities.add(
      AccountOrCommunityData(
        avatar: Container(
          height: avatarSize,
          width: avatarSize,
          decoration: BoxDecoration(
            color: ZurichLion.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, size: 36),
        ),
        name: dic!.profile.addCommunity,
      ),
    );
    return allCommunities;
  }

  List<AccountOrCommunityData> initAllAccounts(Translations dic) {
    List<AccountOrCommunityData> allAccounts = [];
    allAccounts.addAll(store.account.accountListAll.map(
      (account) => AccountOrCommunityData(
        avatar: AddressIcon('', account.pubKey, size: avatarSize, tapToCopy: false),
        name: account.name,
        isSelected: account.pubKey == store.account.currentAccountPubKey,
      ),
    ));
    allAccounts.add(
      AccountOrCommunityData(
        avatar: Container(
          height: avatarSize,
          width: avatarSize,
          decoration: BoxDecoration(
            color: ZurichLion.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, size: 36),
        ),
        name: dic.profile.addAccount,
      ),
    );
    return allAccounts;
  }

  Future<void> switchAccount(AccountData account) async {
    if (account.pubKey != store.account.currentAccountPubKey) {
      store.setCurrentAccount(account.pubKey);
      await store.loadAccountCache();

      webApi.fetchAccountData();
    }
  }

  Future<void> _showPasswordDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(I18n.of(context)!.translationsForLocale().home.unlock),
            (password) {
              setState(() {
                store.settings.setPin(password);
              });
            },
          ),
          onWillPop: () {
            // handles back button press
            return _showPasswordNotEnteredDialog(context).then((value) => value as bool);
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
          title: Text(I18n.of(context)!.translationsForLocale().home.pinNeeded),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.closeApp),
              onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            ),
          ],
        );
      },
    );
  }

  void _refreshBalanceAndNotify(Translations? dic) {
    webApi.encointer.getAllBalances(widget.store.account.currentAddress).then((balances) {
      Log.d('[home:refreshBalanceAndNotify] get all balances', 'Assets');
      if (widget.store.encointer.chosenCid == null) {
        Log.d('[home:refreshBalanceAndNotify] no community selected', 'Assets');
        return;
      }
      bool activeAccountHasBalance = false;
      balances.forEach((cid, balanceEntry) {
        String cidStr = cid.toFmtString();
        if (widget.store.encointer.communityStores!.containsKey(cidStr)) {
          var community = widget.store.encointer.communityStores![cidStr]!;
          double demurrageRate = community.demurrage!;
          double newBalance = community.applyDemurrage(balanceEntry);
          double oldBalance = community.applyDemurrage(
                  widget.store.encointer.accountStores![widget.store.account.currentAddress]!.balanceEntries[cidStr]) ??
              0;
          double delta = newBalance - oldBalance;
          Log.d('[home:refreshBalanceAndNotify] balance for $cidStr was $oldBalance, changed by $delta', 'Assets');
          if (delta.abs() > demurrageRate) {
            widget.store.encointer.accountStores![widget.store.account.currentAddress]
                ?.addBalanceEntry(cid, balances[cid]!);
            if (delta > demurrageRate) {
              var msg = dic!.assets.incomingConfirmed
                  .replaceAll('AMOUNT', delta.toStringAsPrecision(5))
                  .replaceAll('CID_SYMBOL', community.metadata!.symbol)
                  .replaceAll('ACCOUNT_NAME', widget.store.account.currentAccount.name);
              Log.d('[home:balanceWatchdog] $msg', 'Assets');
              NotificationPlugin.showNotification(45, dic.assets.fundsReceived, msg, cid: cidStr);
            }
          }
          if (cid == widget.store.encointer.chosenCid) {
            activeAccountHasBalance = true;
          }
        }
      });
      if (!activeAccountHasBalance) {
        Log.d(
          '[home:refreshBalanceAndNotify] didn\'t get any balance for active account. initialize store balance to zero',
          'Assets',
        );
        widget.store.encointer.accountStores![widget.store.account.currentAddress]
            ?.addBalanceEntry(widget.store.encointer.chosenCid!, BalanceEntry(0, 0));
      }
    }).catchError((e, s) {
      Log.e('[home:refreshBalanceAndNotify] WARNING: could not update balance: $e', 'Assets', s);
    });
  }
}
