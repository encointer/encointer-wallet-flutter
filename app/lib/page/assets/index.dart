import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/common/components/drag_handle.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
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
import 'package:encointer_wallet/l10n/l10.dart';

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

  PanelController? panelController;

  PausableTimer? balanceWatchdog;

  @override
  void initState() {
    super.initState();

    // if network connected failed, reconnect
    if (!widget.store.settings.loading && widget.store.settings.networkName == null) {
      widget.store.settings.setNetworkLoading(true);
      webApi.connectNodeAll();
    }

    panelController ??= PanelController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<AppStore>().encointer.community?.communityIcon == null) {
        context.read<AppStore>().encointer.community?.getCommunityIcon();
      }
    });
  }

  @override
  void dispose() {
    balanceWatchdog!.cancel();
    super.dispose();
  }

  late double _panelHeightOpen;
  final double _panelHeightClosed = 0;

  Future<void> _refreshEncointerState() async {
    // getCurrentPhase is the root of all state updates.
    await webApi.encointer.getCurrentPhase();
  }

  @override
  Widget build(BuildContext context) {
    final dic = context.l10n;
    final appSettingsStore = context.watch<AppSettings>();

    // Should typically not be higher than panelHeight, but on really small devices
    // it should not exceed fractionOfScreenHeight x the screen height.
    _panelHeightOpen = min(
      MediaQuery.of(context).size.height * fractionOfScreenHeight,
      panelHeight,
    );

    var allAccounts = <AccountOrCommunityData>[];

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
      title: Text(dic.home),
    );
    return FocusDetector(
      onFocusLost: () {
        Log.d('[home:FocusDetector] Focus Lost.');
        balanceWatchdog!.pause();
      },
      onFocusGained: () {
        Log.d('[home:FocusDetector] Focus Gained.');
        if (!widget.store.settings.loading) {
          _refreshBalanceAndNotify(dic);
        }
        balanceWatchdog!.reset();
        balanceWatchdog!.start();
      },
      child: Scaffold(
        appBar: appBar,
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
                  EdgeInsets.only(bottom: 60 + appBar.preferredSize.height + MediaQuery.of(context).viewPadding.top),
              child: RefreshIndicator(
                onRefresh: _refreshEncointerState,
                child: ListView(
                  key: const Key('list-view-wallet'),
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  children: [
                    Observer(builder: (_) {
                      return Column(
                        children: <Widget>[
                          InkWell(
                            key: const Key('panel-controller'),
                            child: CombinedCommunityAndAccountAvatar(widget.store),
                            onTap: () {
                              if (panelController != null && panelController!.isAttached) {
                                panelController!.open();
                              }
                            },
                          ),
                          Observer(
                            builder: (_) {
                              return (widget.store.encointer.community?.name != null) &
                                      (widget.store.encointer.chosenCid != null)
                                  ? Column(
                                      children: [
                                        TextGradient(
                                          text: '${Fmt.doubleFormat(widget.store.encointer.communityBalance)} ⵐ',
                                          style: const TextStyle(fontSize: 60),
                                        ),
                                        Text(
                                          '${dic.balance}, ${widget.store.encointer.community?.symbol}',
                                          style: context.textTheme.headlineMedium!
                                              .copyWith(color: AppColors.encointerGrey),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: (widget.store.encointer.chosenCid == null)
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: Text(dic.communityNotSelected, textAlign: TextAlign.center))
                                          : const SizedBox(
                                              width: double.infinity,
                                              child: CupertinoActivityIndicator(),
                                            ),
                                    );
                            },
                          ),
                          if (appSettingsStore.developerMode)
                            ElevatedButton(
                              onPressed: widget.store.dataUpdate.setInvalidated,
                              child: const Text('Invalidate data to trigger state update'),
                            ),
                          const SizedBox(height: 42),
                          Row(
                            children: [
                              ActionButton(
                                key: const Key('qr-receive'),
                                icon: const Icon(Iconsax.receive_square_2),
                                label: dic.receive,
                                onPressed: () => Navigator.pushNamed(context, ReceivePage.route),
                              ),
                              const SizedBox(width: 3),
                              ActionButton(
                                key: const Key('go-transfer-history'),
                                icon: Assets.images.assets.receiveSquare2.svg(),
                                label: dic.transferHistory,
                                onPressed: widget.store.encointer.communityBalance != null
                                    ? () => Navigator.pushNamed(context, TransferHistoryView.route)
                                    : null,
                              ),
                              const SizedBox(width: 3),
                              ActionButton(
                                key: const Key('transfer'),
                                icon: const Icon(Iconsax.send_sqaure_2),
                                label: dic.transfer,
                                onPressed: widget.store.encointer.communityBalance != null
                                    ? () => Navigator.pushNamed(context, TransferPage.route)
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                    ),
                    Observer(builder: (_) {
                      final dic = context.l10n;

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
                                      child: Text(dic.issuancePending),
                                      onPressed: (context) => submitClaimRewards(
                                        context,
                                        widget.store,
                                        webApi,
                                        widget.store.encointer.chosenCid!,
                                      ),
                                    );
                                  } else {
                                    return appSettingsStore.developerMode
                                        ? ElevatedButton(
                                            onPressed: null,
                                            child: Text(dic.issuanceClaimed),
                                          )
                                        : const SizedBox.shrink();
                                  }
                                } else {
                                  return const CupertinoActivityIndicator();
                                }
                              },
                            )
                          : Container();
                    }),
                    const SizedBox(height: 24),
                    CeremonyBox(widget.store, webApi, key: const Key('ceremony-box-wallet')),
                    const SizedBox(height: 24),
                    AnnouncementView(
                      cid: Community.fromCid(widget.store.encointer.community?.cid.toFmtString()).cid,
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
                    Observer(builder: (_) {
                      return SwitchAccountOrCommunity(
                        rowTitle: dic.switchCommunity,
                        data: _allCommunities(),
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
                            _refreshBalanceAndNotify(dic);
                          });
                        },
                        addIconButtonKey: const Key('add-community'),
                      );
                    }),
                    Observer(builder: (BuildContext context) {
                      allAccounts = initAllAccounts(dic);
                      return SwitchAccountOrCommunity(
                        rowTitle: dic.switchAccount,
                        data: allAccounts,
                        onTap: (int index) {
                          setState(() {
                            switchAccount(widget.store.account.accountListAll[index]);
                            _refreshBalanceAndNotify(dic);
                          });
                        },
                        onAddIconPressed: () {
                          Navigator.of(context).pushNamed(AddAccountView.route);
                        },
                        addIconButtonKey: const Key('add-account-panel'),
                      );
                    }),
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

  List<AccountOrCommunityData> _allCommunities() {
    final communityStores = context.read<AppStore>().encointer.communityStores?.values.toList();
    if (communityStores != null && communityStores.isNotEmpty) {
      return communityStores
          .mapIndexed(
            (i, e) => AccountOrCommunityData(
              avatar: Container(
                height: avatarSize,
                width: avatarSize,
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: e.communityIcon != null
                    ? SvgPicture.string(e.communityIcon!)
                    : SvgPicture.asset(fallBackCommunityIcon),
              ),
              name: e.name,
              isSelected: widget.store.encointer.community?.cid == e.cid,
            ),
          )
          .toList();
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

  List<AccountOrCommunityData> initAllAccounts(AppLocalizations dic) {
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

  Future<void> switchAccount(AccountData account) async {
    if (account.pubKey != widget.store.account.currentAccountPubKey) {
      await widget.store.setCurrentAccount(account.pubKey);
      await widget.store.loadAccountCache();

      webApi.fetchAccountData();
    }
  }

  void _refreshBalanceAndNotify(AppLocalizations dic) {
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

          final delta = newBalance - oldBalance;
          Log.d('[home:refreshBalanceAndNotify] balance for $cidStr was $oldBalance, changed by $delta', 'Assets');
          if (delta.abs() > demurrageRate) {
            widget.store.encointer.accountStores![widget.store.account.currentAddress]
                ?.addBalanceEntry(cid, balances[cid]!);
            if (delta > demurrageRate) {
              final msg = dic.incomingConfirmed(
                delta,
                community.metadata!.symbol,
                widget.store.account.currentAccount.name,
              );

              Log.d('[home:balanceWatchdog] $msg', 'Assets');
              NotificationPlugin.showNotification(45, dic.fundsReceived, msg, cid: cidStr);
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
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final Widget icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          child: Column(
            children: [
              icon,
              const SizedBox(height: 4),
              Text(label, softWrap: false, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
