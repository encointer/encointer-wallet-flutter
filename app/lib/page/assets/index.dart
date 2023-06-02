import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:upgrader/upgrader.dart';
import 'package:collection/collection.dart';

import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/page/assets/announcement/view/announcement_view.dart';
import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/drag_handle.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/models/encointer_balance_data/balance_entry.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';
import 'package:encointer_wallet/page/assets/account_or_community/switch_account_or_community.dart';
import 'package:encointer_wallet/page/assets/receive/receive_page.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

/// Getting confused with Assets (gen) while importing
/// thus changed name to [AssetsView]
class AssetsView extends StatefulWidget {
  const AssetsView(this.store, {super.key});

  final AppStore store;

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  static const double panelHeight = 396;
  static const double fractionOfScreenHeight = .7;
  static const double avatarSize = 70;

  late PanelController panelController;

  late PausableTimer balanceWatchdog;

  late double _panelHeightOpen;
  final double _panelHeightClosed = 0;
  late Translations _dic;

  var _allAccounts = <AccountOrCommunityData>[];

  late AppSettings _appSettingsStore;

  @override
  void initState() {
    super.initState();
    _startBalanceWatchdog();
    panelController = PanelController();
    _connectNodeAll();
    _postFrameCallbacks();
  }

  @override
  void didChangeDependencies() {
    _appSettingsStore = context.watch<AppSettings>();
    _dic = I18n.of(context)!.translationsForLocale();
    // Should typically not be higher than panelHeight, but on really small devices
    // it should not exceed fractionOfScreenHeight x the screen height.
    _panelHeightOpen = min(
      MediaQuery.of(context).size.height * fractionOfScreenHeight,
      panelHeight,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    balanceWatchdog.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: () {
        Log.d('[home:FocusDetector] Focus Lost.');
        balanceWatchdog.pause();
      },
      onFocusGained: () {
        Log.d('[home:FocusDetector] Focus Gained.');
        if (!widget.store.settings.loading) {
          _refreshBalanceAndNotify();
        }
        balanceWatchdog
          ..reset()
          ..start();
      },
      child: Scaffold(
        appBar: _appBar(),
        body: UpgradeAlert(
          upgrader: Upgrader(
            appcastConfig: RepositoryProvider.of<AppConfig>(context).appCast,
            debugLogging: RepositoryProvider.of<AppConfig>(context).isIntegrationTest,
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
                  EdgeInsets.only(bottom: 60 + _appBar().preferredSize.height + MediaQuery.of(context).viewPadding.top),
              child: RefreshIndicator(
                onRefresh: _refreshEncointerState,
                child: ListView(
                  key: const Key('list-view-wallet'),
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  children: [
                    _topContent(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                    ),
                    _claim(),
                    const SizedBox(height: 24),
                    CeremonyBox(widget.store, webApi, key: const Key('ceremony-box-wallet')),
                    const SizedBox(height: 24),
                    if (!_appSettingsStore.developerMode)
                      AnnouncementView(
                        cid: widget.store.encointer.community?.cid.toFmtString(),
                      ),
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
                  const SizedBox(height: 12),
                  const DragHandle(),
                  Column(children: [
                    _switchCommunityBuild(),
                    _switchAccountBuild(),
                  ]),
                ],
              ),
            ),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      key: const Key('assets-index-appbar'),
      title: Text(_dic.assets.home),
    );
  }

  Observer _topContent() {
    return Observer(builder: (_) {
      return Column(
        children: <Widget>[
          InkWell(
            key: const Key('panel-controller'),
            child: CombinedCommunityAndAccountAvatar(widget.store),
            onTap: () {
              if (panelController.isAttached) {
                panelController.open();
              }
            },
          ),
          _avatar(),
          if (_appSettingsStore.developerMode)
            ElevatedButton(
              onPressed: widget.store.dataUpdate.setInvalidated,
              child: const Text('Invalidate data to trigger state update'),
            ),
          const SizedBox(
            height: 42,
          ),
          _sendAndRecieve(),
        ],
      );
    });
  }

  Observer _avatar() {
    return Observer(
      builder: (_) {
        return (widget.store.encointer.community?.name != null) & (widget.store.encointer.chosenCid != null)
            ? Column(
                children: [
                  TextGradient(
                    text: '${Fmt.doubleFormat(widget.store.encointer.communityBalance)} ⵐ',
                    style: const TextStyle(fontSize: 60),
                  ),
                  Text(
                    '${_dic.assets.balance}, ${widget.store.encointer.community?.symbol}',
                    style: context.textTheme.headlineMedium!.copyWith(color: AppColors.encointerGrey),
                  ),
                ],
              )
            : Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: (widget.store.encointer.chosenCid == null)
                    ? SizedBox(
                        width: double.infinity,
                        child: Text(_dic.assets.communityNotSelected, textAlign: TextAlign.center))
                    : const SizedBox(
                        width: double.infinity,
                        child: CupertinoActivityIndicator(),
                      ),
              );
      },
    );
  }

  Widget _sendAndRecieve() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                // don't redefine the entire style just the border radii
                borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              ),
            ),
            key: const Key('qr-receive'),
            onPressed: () => Navigator.pushNamed(context, ReceivePage.route),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.receive_square_2),
                  const SizedBox(width: 12),
                  Text(_dic.assets.receive),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                // don't redefine the entire style just the border radii
                borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
              ),
            ),
            key: const Key('transfer'),
            onPressed: widget.store.encointer.communityBalance != null
                ? () => Navigator.pushNamed(context, TransferPage.route)
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_dic.assets.transfer),
                  const SizedBox(width: 12),
                  const Icon(Iconsax.send_sqaure_2),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Observer _claim() {
    return Observer(builder: (_) {
      final shouldFetch = widget.store.encointer.currentPhase == CeremonyPhase.Registering ||
          (widget.store.encointer.communityAccount?.meetupCompleted ?? false);

      return widget.store.settings.isConnected && shouldFetch
          ? FutureBuilder<bool?>(
              future: webApi.encointer.hasPendingIssuance(),
              builder: (_, AsyncSnapshot<bool?> snapshot) {
                if (snapshot.hasData) {
                  final hasPendingIssuance = snapshot.data!;

                  if (hasPendingIssuance) {
                    return SubmitButton(
                      key: const Key('claim-pending-dev'),
                      child: Text(_dic.assets.issuancePending),
                      onPressed: (context) => submitClaimRewards(
                        context,
                        widget.store,
                        webApi,
                        widget.store.encointer.chosenCid!,
                      ),
                    );
                  } else {
                    return _appSettingsStore.developerMode
                        ? ElevatedButton(
                            onPressed: null,
                            child: Text(_dic.assets.issuanceClaimed),
                          )
                        : const SizedBox.shrink();
                  }
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            )
          : Container();
    });
  }

  Observer _switchAccountBuild() {
    return Observer(builder: (BuildContext context) {
      _allAccounts = _initAllAccounts();
      return SwitchAccountOrCommunity(
        rowTitle: _dic.home.switchAccount,
        accountOrCommunityData: _allAccounts,
        onTap: (int index) {
          setState(() {
            _switchAccountData(widget.store.account.accountListAll[index]);
            _refreshBalanceAndNotify();
          });
        },
        onAddIconPressed: () {
          Navigator.of(context).pushNamed(AddAccountView.route);
        },
        addIconButtonKey: const Key('add-account-panel'),
      );
    });
  }

  Observer _switchCommunityBuild() {
    return Observer(builder: (_) {
      return SwitchAccountOrCommunity(
        rowTitle: _dic.home.switchCommunity,
        accountOrCommunityData: _allAccountOrCommunities(),
        onTap: (int index) async {
          final store = context.read<AppStore>();
          final communityStores = store.encointer.communityStores?.values.toList() ?? [];
          await store.encointer.setChosenCid(communityStores[index].cid);
          if (RepositoryProvider.of<AppSettings>(context).developerMode) {
            context.read<AppSettings>().changeTheme(store.encointer.community?.cid.toFmtString());
          }
        },
        onAddIconPressed: () {
          Navigator.pushNamed(context, CommunityChooserOnMap.route).then((_) {
            _refreshBalanceAndNotify();
          });
        },
        addIconButtonKey: const Key('add-community'),
      );
    });
  }

  List<AccountOrCommunityData> _allAccountOrCommunities() {
    final communityStores = context.read<AppStore>().encointer.communityStores?.values.toList();

    if (communityStores != null && communityStores.isNotEmpty) {
      return communityStores.mapIndexed((index, communityStore) {
        return AccountOrCommunityData(
          avatar: Container(
            height: avatarSize,
            width: avatarSize,
            decoration: BoxDecoration(
              color: context.colorScheme.background,
              shape: BoxShape.circle,
            ),
            child: communityStore.communityIcon != null
                ? SvgPicture.string(communityStore.communityIcon!)
                : SvgPicture.asset(fallBackCommunityIcon),
          ),
          name: communityStore.name,
          isSelected: widget.store.encointer.community?.cid == communityStore.cid,
        );
      }).toList();
    } else {
      return [
        AccountOrCommunityData(
            avatar: Container(
              height: avatarSize,
              width: avatarSize,
              decoration: BoxDecoration(
                color: context.colorScheme.background,
                shape: BoxShape.circle,
              ),
              child: const CenteredActivityIndicator(),
            ),
            name: '...')
      ];
    }
  }

  List<AccountOrCommunityData> _initAllAccounts() {
    final allAccounts = <AccountOrCommunityData>[
      ...widget.store.account.accountListAll.map(
        (account) => AccountOrCommunityData(
          avatar: AddressIcon(
            '',
            account.pubKey,
            key: Key(account.name),
            size: avatarSize,
            tapToCopy: false,
          ),
          name: account.name,
          isSelected: account.pubKey == widget.store.account.currentAccountPubKey,
        ),
      ),
    ];
    return allAccounts;
  }

  Future<void> _switchAccountData(AccountData account) async {
    if (account.pubKey != widget.store.account.currentAccountPubKey) {
      await widget.store.setCurrentAccount(account.pubKey);
      await widget.store.loadAccountCache();

      webApi.fetchAccountData();
    }
  }

  Future<void> _showPasswordDialog() async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: showPasswordInputDialog(
            context,
            widget.store.account.currentAccount,
            Text(I18n.of(context)!.translationsForLocale().home.unlock),
            (String password) {
              setState(() {
                widget.store.settings.setPin(password);
              });
            },
          ),
          // handles back button press
          onWillPop: () async {
            await _showPasswordNotEnteredDialog();
            return false;
          },
        );
      },
    );
  }

  Future<void> _showPasswordNotEnteredDialog() async {
    await showCupertinoDialog<void>(
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

  void _refreshBalanceAndNotify() {
    webApi.encointer.getAllBalances(widget.store.account.currentAddress).then((balances) {
      Log.d('[home:refreshBalanceAndNotify] get all balances', 'Assets');
      if (widget.store.encointer.chosenCid == null) {
        Log.d('[home:refreshBalanceAndNotify] no community selected', 'Assets');
        return;
      }
      var activeAccountHasBalance = false;
      balances.forEach((cid, balanceEntry) {
        final cidStr = cid.toFmtString();
        if (widget.store.encointer.communityStores!.containsKey(cidStr)) {
          final community = widget.store.encointer.communityStores![cidStr]!;
          final oldBalanceEntry =
              widget.store.encointer.accountStores?[widget.store.account.currentAddress]?.balanceEntries[cidStr];
          final demurrageRate = community.demurrage!;
          final newBalance = community.applyDemurrage != null ? community.applyDemurrage!(balanceEntry) ?? 0 : 0;
          final oldBalance = (community.applyDemurrage != null && oldBalanceEntry != null)
              ? community.applyDemurrage!(oldBalanceEntry) ?? 0
              : 0;

// =======
//           double newBalance = community.applyDemurrage(balanceEntry) as double;
//           double oldBalance = community.applyDemurrage(widget.store.encointer
//                   .accountStores![widget.store.account.currentAddress]!.balanceEntries[cidStr]) as double? ??
//               0;
// >>>>>>> 9d4143d3262181f3ad0429032d40bcd3c94c1b9f
          final delta = newBalance - oldBalance;
          Log.d('[home:refreshBalanceAndNotify] balance for $cidStr was $oldBalance, changed by $delta', 'Assets');
          if (delta.abs() > demurrageRate) {
            widget.store.encointer.accountStores![widget.store.account.currentAddress]
                ?.addBalanceEntry(cid, balances[cid]!);
            if (delta > demurrageRate) {
              final msg = _dic.assets.incomingConfirmed
                  .replaceAll('AMOUNT', delta.toStringAsPrecision(5))
                  .replaceAll('CID_SYMBOL', community.metadata!.symbol)
                  .replaceAll('ACCOUNT_NAME', widget.store.account.currentAccount.name);
              Log.d('[home:balanceWatchdog] $msg', 'Assets');
              NotificationPlugin.showNotification(45, _dic.assets.fundsReceived, msg, cid: cidStr);
            }
          }
          if (cid == widget.store.encointer.chosenCid) {
            activeAccountHasBalance = true;
          }
        }
      });
      if (!activeAccountHasBalance) {
        Log.d(
          "[home:refreshBalanceAndNotify] didn't get any balance for active account. initialize store balance to zero",
          'Assets',
        );
        widget.store.encointer.accountStores![widget.store.account.currentAddress]
            ?.addBalanceEntry(widget.store.encointer.chosenCid!, BalanceEntry(0, 0));
      }
    }).catchError((Object? e, StackTrace? s) {
      Log.e('[home:refreshBalanceAndNotify] WARNING: could not update balance: $e', 'Assets', s);
    });
  }

  void _postFrameCallbacks() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.store.settings.cachedPin.isEmpty & !widget.store.settings.endpointIsNoTee) {
        _showPasswordDialog();
      }

      if (context.read<AppStore>().encointer.community?.communityIcon == null) {
        context.read<AppStore>().encointer.community?.getCommunityIcon();
      }
    });
  }

  void _connectNodeAll() {
    // if network connected failed, reconnect
    if (!widget.store.settings.loading && widget.store.settings.networkName == null) {
      widget.store.settings.setNetworkLoading(true);

      /// webApi.connectNodeAll() eventually fetches communities and sets them
      webApi.connectNodeAll();
    }
  }

  void _startBalanceWatchdog() {
    balanceWatchdog = PausableTimer(
      const Duration(seconds: 12),
      () {
        Log.d('[balanceWatchdog] triggered', 'Assets');

        _refreshBalanceAndNotify();
        balanceWatchdog
          ..reset()
          ..start();
      },
    )..start();
  }

  Future<void> _refreshEncointerState() async {
    // getCurrentPhase is the root of all state updates.
    await webApi.encointer.getCurrentPhase();
  }
}
