import 'dart:math';

import 'package:encointer_wallet/app/presentation/assets/store/assets_view_store.dart';
import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/components/drag_handle.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/extras/utils/translations/translations.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page/account/create/add_account_page.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';
import 'package:encointer_wallet/page/assets/account_or_community/switch_account_or_community.dart';
import 'package:encointer_wallet/page/assets/receive/receive_page.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/encointer_state_mixin.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:upgrader/upgrader.dart';

const _tag = 'assets_view';

class AssetsView extends StatefulWidget {
  const AssetsView({super.key});
  static const route = 'assets-view';

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> with EncointerStateMixin {
  static const double panelHeight = 396;
  static const double fractionOfScreenHeight = .7;
  static const double avatarSize = 70;

  late final AssetsViewStore _store;

  PanelController? panelController;

  PausableTimer? balanceWatchdog;

  late double _panelHeightOpen;
  final double _panelHeightClosed = 0;

  List<AccountOrCommunityData> allCommunities = <AccountOrCommunityData>[];
  List<AccountOrCommunityData> allAccounts = <AccountOrCommunityData>[];

  @override
  void initState() {
    super.initState();
    _store = AssetsViewStore()
      ..reconnect(
        context: context,
        appStore: context.read<AppStore>(),
      );

    panelController ??= PanelController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<AppStore>().settings.cachedPin.isEmpty & !context.read<AppStore>().settings.endpointIsNoTee) {
        _store.showPasswordDialog(context);
      }

      if (context.read<AppStore>().encointer.community?.communityIcon == null) {
        context.read<AppStore>().encointer.community?.getCommunityIcon();
      }
    });
  }

  @override
  void dispose() {
    balanceWatchdog!.cancel();
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();

    // Should typically not be higher than panelHeight, but on really small devices
    // it should not exceed fractionOfScreenHeight x the screen height.
    _panelHeightOpen = min(
      MediaQuery.of(context).size.height * fractionOfScreenHeight,
      panelHeight,
    );

    balanceWatchdog = PausableTimer(
      const Duration(seconds: 12),
      () {
        Log.d('[balanceWatchdog] triggered', _tag);

        _store.refreshBalanceAndNotify(context);
        balanceWatchdog!
          ..reset()
          ..start();
      },
    )..start();

    return FocusDetector(
      onFocusLost: () {
        Log.d('[home:FocusDetector] Focus Lost.', _tag);
        balanceWatchdog!.pause();
      },
      onFocusGained: () {
        Log.d('[home:FocusDetector] Focus Gained.', _tag);
        if (!appStore.settings.loading) {
          _store.refreshBalanceAndNotify(context);
        }
        balanceWatchdog!.reset();
        balanceWatchdog!.start();
      },
      child: Scaffold(
        appBar: _appBar(),
        body: _body(context, appStore, allCommunities, allAccounts),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      key: const Key('assets-index-appbar'),
      title: Text(localization.assets.home),
    );
  }

  Widget _body(
    BuildContext context,
    AppStore appStore,
    List<AccountOrCommunityData> allCommunities,
    List<AccountOrCommunityData> allAccounts,
  ) {
    return UpgradeAlert(
      upgrader: Upgrader(
        appcastConfig: buildConfig.appCast,
        debugLogging: buildConfig == BuildConfig.integrationTest,
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
              EdgeInsets.only(
            bottom: 60 + _appBar().preferredSize.height + MediaQuery.of(context).viewPadding.top,
          ),
          child: RefreshIndicator(
            onRefresh: _store.refreshEncointerState,
            child: _lists(appStore, context),
          ),
        ),
        // panel entering from below
        panelBuilder: (scrollController) => _panelBuilder(
          context,
          scrollController,
          appStore,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
    );
  }

  Widget _lists(
    AppStore appStore,
    BuildContext context,
  ) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      children: [
        Observer(
          builder: (_) {
            final accountData = appStore.account.currentAccount;
            return _accounData(appStore, context, accountData);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
        ),
        Observer(
          builder: (_) {
            final shouldFetch = appStore.encointer.currentPhase == CeremonyPhase.Registering ||
                (appStore.encointer.communityAccount?.meetupCompleted ?? false);

            return appStore.settings.isConnected && shouldFetch
                ? FutureBuilder<bool?>(
                    future: webApi.encointer.hasPendingIssuance(),
                    builder: (_, AsyncSnapshot<bool?> snapshot) {
                      if (snapshot.hasData) {
                        final hasPendingIssuance = snapshot.data!;

                        if (hasPendingIssuance) {
                          return SubmitButton(
                            key: const Key('claim-pending-dev'),
                            child: Text(localization.assets.issuancePending),
                            onPressed: (context) => submitClaimRewards(
                              context,
                              appStore,
                              webApi,
                              appStore.encointer.chosenCid!,
                            ),
                          );
                        } else {
                          return appStore.settings.developerMode
                              ? ElevatedButton(
                                  onPressed: null,
                                  child: Text(localization.assets.issuanceClaimed),
                                )
                              : const SizedBox.shrink();
                        }
                      } else {
                        return const CupertinoActivityIndicator();
                      }
                    },
                  )
                : Container();
          },
        ),
        const SizedBox(height: 24),
        CeremonyBox(appStore, webApi, key: const Key('ceremony-box-wallet')),
      ],
    );
  }

  Widget _accounData(
    AppStore appStore,
    BuildContext context,
    AccountData accountData,
  ) {
    return Column(
      children: <Widget>[
        InkWell(
          key: const Key('panel-controller'),
          child: CombinedCommunityAndAccountAvatar(appStore),
          onTap: () {
            if (panelController != null && panelController!.isAttached) {
              panelController!.open();
            }
          },
        ),
        Observer(
          builder: (_) {
            return (appStore.encointer.community?.name != null) & (appStore.encointer.chosenCid != null)
                ? Column(
                    children: [
                      TextGradient(
                        text: '${Fmt.doubleFormat(appStore.encointer.communityBalance)} ⵐ',
                        style: const TextStyle(fontSize: 60),
                      ),
                      Text(
                        '${localization.assets.balance}, ${appStore.encointer.community?.symbol}',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: encointerGrey),
                      ),
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: (appStore.encointer.chosenCid == null)
                        ? SizedBox(
                            width: double.infinity,
                            child: Text(localization.assets.communityNotSelected, textAlign: TextAlign.center),
                          )
                        : const SizedBox(
                            width: double.infinity,
                            child: CupertinoActivityIndicator(),
                          ),
                  );
          },
        ),
        if (appStore.settings.developerMode)
          ElevatedButton(
            onPressed: appStore.dataUpdate.setInvalidated,
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
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                  ),
                ),
                key: const Key('qr-receive'),
                onPressed: () {
                  if (accountData.address != '') {
                    Navigator.pushNamed(context, ReceivePage.route);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.receive_square_2),
                      const SizedBox(width: 12),
                      Text(localization.assets.receive),
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
                onPressed: appStore.encointer.communityBalance != null
                    ? () => Navigator.pushNamed(context, TransferPage.route)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(localization.assets.transfer),
                      const SizedBox(width: 12),
                      const Icon(Iconsax.send_sqaure_2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  MediaQuery _panelBuilder(
    BuildContext context,
    ScrollController scrollController,
    AppStore appStore,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        key: const Key('list-view-wallet'),
        controller: scrollController,
        children: <Widget>[
          const SizedBox(height: 12),
          const DragHandle(),
          Column(
            children: [
              Observer(
                builder: (BuildContext context) {
                  allCommunities = initAllCommunities(appStore);
                  return SwitchAccountOrCommunity(
                    rowTitle: localization.home.switchCommunity,
                    data: allCommunities,
                    onTap: (int index) {
                      if (index == allCommunities.length - 1) {
                        Navigator.pushNamed(context, CommunityChooserOnMap.route).then((_) {
                          _store.refreshBalanceAndNotify(context);
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
              Observer(
                builder: (BuildContext context) {
                  allAccounts = initAllAccounts(localization, appStore);
                  return SwitchAccountOrCommunity(
                    rowTitle: localization.home.switchAccount,
                    data: allAccounts,
                    onTap: (int index) {
                      if (index == allAccounts.length - 1) {
                        Navigator.of(context).pushNamed(AddAccountPage.route);
                      } else {
                        ///TODO<Azamat>: Why setState() being called?
                        setState(() {
                          _store
                            ..switchAccount(appStore.account.accountListAll[index], appStore)
                            ..refreshBalanceAndNotify(context);
                        });
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<AccountOrCommunityData> initAllCommunities(AppStore appStore) {
    final allCommunities = <AccountOrCommunityData>[
      AccountOrCommunityData(
        avatar: const CommunityAvatar(avatarSize: avatarSize),
        name: appStore.encointer.community?.name ?? '...',
        isSelected: true, // TODO #507 this should later be a function applied on each community, cf. initAllAccounts
      ),
      AccountOrCommunityData(
        avatar: Container(
          height: avatarSize,
          width: avatarSize,
          decoration: BoxDecoration(
            color: zurichLion.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            key: Key('add-community'),
            size: 36,
          ),
        ),
        name: localization.profile.addCommunity,
      )
    ];
    // TODO #507 add back end code so we can initialize the list of communities similar to the commented out code
    // allCommunities.addAll(store.communities.communitiesList.map((community) => AccountOrCommunityData(
    //     avatar: webApi.ipfs.getCommunityIcon(community),
    //     name: community.name)));

    // For now show the selected community if available and let the user add a community from the world map community chooser

    return allCommunities;
  }

  List<AccountOrCommunityData> initAllAccounts(Translations dic, AppStore appStore) {
    final allAccounts = <AccountOrCommunityData>[
      ...appStore.account.accountListAll.map(
        (account) => AccountOrCommunityData(
          avatar: AddressIcon('', account.pubKey, key: Key(account.name), size: avatarSize, tapToCopy: false),
          name: account.name,
          isSelected: account.pubKey == appStore.account.currentAccountPubKey,
        ),
      ),
      AccountOrCommunityData(
        avatar: Container(
          key: const Key('add-account-panel'),
          height: avatarSize,
          width: avatarSize,
          decoration: BoxDecoration(
            color: zurichLion.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, size: 36),
        ),
        name: localization.profile.addAccount,
      )
    ];
    return allAccounts;
  }
}
