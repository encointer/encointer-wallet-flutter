import 'dart:async';
import 'dart:math';

import 'package:encointer_wallet/page-encointer/democracy/exercise_swap/exercise_swap_page.dart';
import 'package:encointer_wallet/page-encointer/democracy/utils/swap_options.dart';
import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/encointer_primitives/treasuries/swap_asset_option.dart'
    show SwapAssetOption;
import 'package:ew_polkadart/generated/encointer_kusama/types/encointer_primitives/treasuries/swap_native_option.dart'
    show SwapNativeOption;
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobx/mobx.dart' show ReactionDisposer, reaction;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:upgrader/upgrader.dart';
import 'package:collection/collection.dart';

import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/page/assets/announcement/view/announcement_view.dart';
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
import 'package:encointer_wallet/page-encointer/ceremony_box/ceremony_box.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page/assets/account_or_community/account_or_community_data.dart';
import 'package:encointer_wallet/page/assets/account_or_community/switch_account_or_community.dart';
import 'package:encointer_wallet/page/assets/receive/receive_page.dart';
import 'package:encointer_wallet/page/assets/transfer/transfer_page.dart';
import 'package:encointer_wallet/service/offline/offline_identity_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/connectivity/connectivity_store.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_storage/ew_storage.dart';

const _logTarget = 'AssetsHomepageStore';

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

  late PanelController _panelController;
  late AppSettings _appSettingsStore;
  late double _panelHeightOpen;
  final double _panelHeightClosed = 0;
  late AppLocalizations l10n;

  NativeSwap? nativeSwap;
  AssetSwap? assetSwap;

  // MobX reaction disposer
  late ReactionDisposer _swapReaction;

  @override
  void initState() {
    super.initState();

    _panelController = PanelController();
    _connectNodeAll();

    // Reaction: automatically fetch swap options when CID or account changes
    _swapReaction = reaction(
      (_) => [widget.store.encointer.chosenCid, widget.store.account.currentAddress],
      (_) => getSwapOptions(),
      fireImmediately: true, // optional: fetch immediately on init if values exist
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOfflineRegistration());
  }

  Future<void> _checkOfflineRegistration() async {
    final appSettings = context.read<AppSettings>();
    if (appSettings.isIntegrationTest) return;
    if (!appSettings.developerMode) return;

    final pubKey = widget.store.account.currentAccountPubKey;
    if (pubKey == null) return;

    final service = OfflineIdentityService(const SecureStorage());
    final prefsKey = 'offline_registration_prompted_$pubKey';
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(prefsKey) ?? false) {
      // User previously declined — run consistency check silently if registered and online
      if (await service.isRegistered(pubKey)) {
        final connectivity = context.read<ConnectivityStore>();
        if (connectivity.isConnectedToNetwork && mounted) {
          try {
            await service.ensureConsistency(context);
          } on Exception catch (e) {
            Log.d('Offline consistency check failed: $e', _logTarget);
          }
        }
      }
      return;
    }

    if (await service.isRegistered(pubKey)) {
      return;
    }

    if (!mounted) return;
    final connectivity = context.read<ConnectivityStore>();
    if (!connectivity.isConnectedToNetwork) return;

    // Only offer registration if the account has some balance to pay fees
    final balance = widget.store.encointer.communityBalanceOrCached;
    if (balance == null || balance <= 0) return;

    await AppAlert.showConfirmDialog<void>(
      context: context,
      title: const Text('Enable Offline Payments?'),
      content: const Text('Register your identity to send and receive payments without internet.'),
      onOK: () async {
        Navigator.of(context).pop();
        try {
          await service.register(context);
          if (!mounted) return;
          await AppAlert.showDialog<void>(
            context,
            title: const Text('Registration Successful'),
            content: const Text('You can now pay while offline.'),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        } on Exception catch (e) {
          if (!mounted) return;
          AppAlert.showErrorDialog(context, errorText: 'Registration failed: $e', buttontext: 'OK');
        }
      },
      onCancel: () async {
        Navigator.of(context).pop();
        // Only remember the choice when user explicitly declines
        await prefs.setBool(prefsKey, true);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _appSettingsStore = context.read<AppSettings>();
    l10n = context.l10n;

    _panelHeightOpen = min(
      MediaQuery.of(context).size.height * fractionOfScreenHeight,
      panelHeight,
    );
  }

  @override
  void dispose() {
    _swapReaction(); // dispose reaction
    super.dispose();
  }

  Future<void> getSwapOptions() async {
    setState(() {
      nativeSwap = null;
      assetSwap = null;
    });

    final cid = widget.store.encointer.chosenCid;
    final accountId = widget.store.account.currentAddress;

    if (cid == null || accountId.isEmpty) {
      Log.d('[getSwapOptions]: No CID or account chosen, returning...', _logTarget);
      return;
    }

    Log.d('Fetching swap options', _logTarget);

    final pubKey = AddressUtils.addressToPubKey(accountId).toList();

    try {
      final results = await Future.wait([
        webApi.encointer.getSwapAssetOptionForAccount(cid, pubKey),
        webApi.encointer.getSwapNativeOptionForAccount(cid, pubKey),
      ]);

      final fetchedAssetOption = results[0] as SwapAssetOption?;
      final fetchedNativeOption = results[1] as SwapNativeOption?;

      // Prevent stale results if user switches account/community quickly
      if (!mounted) return;
      if (cid != widget.store.encointer.chosenCid || accountId != widget.store.account.currentAddress) {
        return;
      }

      setState(() {
        assetSwap = fetchedAssetOption != null ? AssetSwap(fetchedAssetOption) : null;
        nativeSwap = fetchedNativeOption != null ? NativeSwap(fetchedNativeOption) : null;
      });

      if (fetchedAssetOption == null) Log.d('No Swap Asset Options Found', _logTarget);
      if (fetchedNativeOption == null) Log.d('No Swap Native Options Found', _logTarget);
    } catch (e, st) {
      Log.e('Failed to fetch swap options: $e', _logTarget, st);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RepositoryProvider.of<AppConfig>(context).isIntegrationTest
          ? _slidingUpPanel(_appBar())
          : _upgradeAlert(_appBar()),
    );
  }

  AppBar _appBar() {
    return AppBar(
      key: const Key('assets-index-appbar'),
      title: Text(l10n.home),
    );
  }

  UpgradeAlert _upgradeAlert(
    AppBar appBar,
  ) {
    final url = RepositoryProvider.of<AppConfig>(context).appCastUrl;
    final controller = url != null
        ? UpgraderStoreController(
            onAndroid: () => UpgraderAppcastStore(appcastURL: RepositoryProvider.of<AppConfig>(context).appCastUrl!))
        : null;

    return UpgradeAlert(
      upgrader: Upgrader(
        storeController: controller,
        debugLogging: RepositoryProvider.of<AppConfig>(context).isIntegrationTest,
      ),
      shouldPopScope: () => true,
      barrierDismissible: true,
      child: _slidingUpPanel(appBar),
    );
  }

  SlidingUpPanel _slidingUpPanel(
    AppBar appBar,
  ) {
    return SlidingUpPanel(
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      backdropEnabled: true,
      controller: _panelController,
      // The padding is a hack for #559, which needs https://github.com/akshathjain/sliding_up_panel/pull/303
      body: Padding(
        padding:
            // Fixme: 60 is hardcoded because we don't know the tabBar size here.
            // Should be tackled in #607
            EdgeInsets.only(bottom: 60 + appBar.preferredSize.height + MediaQuery.of(context).viewPadding.top),
        child: RefreshIndicator(
          onRefresh: _refreshEncointerState,
          child: ListView(
            key: const Key(EWTestKeys.listViewWallet),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            children: [
              Observer(builder: (_) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      key: const Key(EWTestKeys.panelController),
                      child: CombinedCommunityAndAccountAvatar(widget.store),
                      onTap: () {
                        if (_panelController.isAttached) {
                          _panelController.open();
                        }
                      },
                    ),
                    Observer(
                      builder: (_) {
                        final displayBalance = widget.store.encointer.communityBalanceOrCached;
                        final pendingDelta = widget.store.offlinePayment.pendingBalanceDelta;
                        final effectiveBalance = displayBalance != null ? displayBalance + pendingDelta : null;

                        return (widget.store.encointer.community?.name != null) &&
                                (widget.store.encointer.chosenCid != null) &&
                                (effectiveBalance != null)
                            ? Column(
                                children: [
                                  TextGradient(
                                    text: '${Fmt.doubleFormat(effectiveBalance)} ⵐ',
                                    style: const TextStyle(fontSize: 50),
                                  ),
                                  Text(
                                    '${l10n.balance}, ${widget.store.encointer.community?.symbol}',
                                    style: context.bodyLarge.copyWith(color: AppColors.encointerGrey),
                                  ),
                                  if (pendingDelta != 0)
                                    Text(
                                      '(incl. pending offline)',
                                      style: context.bodySmall.copyWith(color: AppColors.encointerGrey),
                                    ),
                                  if (widget.store.encointer.isBalanceCached)
                                    Text(
                                      '(offline, approximate)',
                                      style: context.bodySmall.copyWith(color: AppColors.encointerGrey),
                                    ),
                                ],
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 16),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: (widget.store.encointer.chosenCid == null)
                                    ? SizedBox(
                                        width: double.infinity,
                                        child: Text(l10n.communityNotSelected, textAlign: TextAlign.center))
                                    : const SizedBox(
                                        width: double.infinity,
                                        child: CupertinoActivityIndicator(),
                                      ),
                              );
                      },
                    ),
                    if (_appSettingsStore.developerMode)
                      ElevatedButton(
                        onPressed: () {
                          getSwapOptions();
                          widget.store.dataUpdate.setInvalidated();
                        },
                        child: const Text('Invalidate data to trigger state update'),
                      ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        ActionButton(
                          key: const Key(EWTestKeys.qrReceive),
                          icon: const Icon(Iconsax.receive_square_2),
                          label: l10n.receive,
                          onPressed: () => Navigator.pushNamed(context, ReceivePage.route),
                        ),
                        const SizedBox(width: 3),
                        Observer(
                            builder: (_) => widget.store.encointer.communityBalanceOrCached != null
                                ? ActionButton(
                                    key: const Key(EWTestKeys.goTransferHistory),
                                    icon: Assets.images.assets.receiveSquare2.svg(
                                      colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                                    ),
                                    label: l10n.transferHistory,
                                    onPressed: () => Navigator.pushNamed(context, TransferHistoryView.route))
                                : ActionButton(
                                    // ActionButton without key. The integration tests break if the key is tapped
                                    // before the button is enabled.
                                    icon: Assets.images.assets.receiveSquare2.svg(
                                      colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                                    ),
                                    label: l10n.transferHistory,
                                  )),
                        const SizedBox(width: 3),
                        Observer(
                          builder: (_) => widget.store.encointer.communityBalanceOrCached != null
                              ? ActionButton(
                                  key: const Key(EWTestKeys.transfer),
                                  icon: const Icon(Iconsax.send_sqaure_2),
                                  label: l10n.transfer,
                                  onPressed: () => Navigator.pushNamed(context, TransferPage.route),
                                )
                              : ActionButton(
                                  // ActionButton without key. The integration tests break if the key is tapped
                                  // before the button is enabled.
                                  icon: const Icon(Iconsax.send_sqaure_2),
                                  label: l10n.transfer,
                                ),
                        ),
                      ],
                    ),
                    if (widget.store.offlinePayment.otherAccountsHavePendingPayments)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Other accounts have pending offline payments',
                          style: context.bodySmall.copyWith(color: AppColors.encointerGrey),
                        ),
                      ),
                  ],
                );
              }),
              if (assetSwap != null)
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.trade),
                      const SizedBox(width: 4),
                      Text(l10n.exerciseSwapAssetOptionAvailable(assetSwap!.symbol)),
                    ],
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, ExerciseSwapPage.route, arguments: assetSwap);
                    unawaited(getSwapOptions());
                  },
                ),
              if (widget.store.settings.usdcMockSwapEnabled && widget.store.encointer.chosenCid != null)
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.trade),
                      const SizedBox(width: 4),
                      Text(l10n
                          .exerciseSwapAssetOptionAvailable(mockAssetSwap(widget.store.encointer.chosenCid!).symbol)),
                    ],
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      ExerciseSwapPage.route,
                      arguments: mockAssetSwap(widget.store.encointer.chosenCid!),
                    );
                    unawaited(getSwapOptions());
                  },
                ),
              if (nativeSwap != null)
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.trade),
                      const SizedBox(width: 4),
                      Text(l10n.exerciseSwapNativeOptionAvailable),
                    ],
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, ExerciseSwapPage.route, arguments: nativeSwap);
                    unawaited(getSwapOptions());
                  },
                ),
              if (widget.store.settings.ksmMockSwapEnabled && widget.store.encointer.chosenCid != null)
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.trade),
                      const SizedBox(width: 4),
                      Text(l10n.exerciseSwapNativeOptionAvailable),
                    ],
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      ExerciseSwapPage.route,
                      arguments: mockNativeSwap(widget.store.encointer.chosenCid!),
                    );
                    unawaited(getSwapOptions());
                  },
                ),
              Observer(builder: (_) {
                final shouldFetch = widget.store.encointer.currentPhase == CeremonyPhase.Registering ||
                    (widget.store.encointer.communityAccount?.meetupCompleted ?? false);

                return widget.store.settings.isConnected && shouldFetch
                    ? FutureBuilder<bool?>(
                        future: webApi.encointer.hasPendingIssuance(),
                        builder: (_, AsyncSnapshot<bool?> snapshot) {
                          if (snapshot.hasData) {
                            final hasPendingIssuance = snapshot.data!;

                            final store = widget.store;

                            if (hasPendingIssuance) {
                              return SubmitButton(
                                key: const Key(EWTestKeys.claimPendingDev),
                                child: Text(l10n.issuancePending, textAlign: TextAlign.center),
                                onPressed: (context) => submitClaimRewards(
                                  context,
                                  store,
                                  webApi,
                                  store.account.getKeyringAccount(store.account.currentAccountPubKey!),
                                  widget.store.encointer.chosenCid!,
                                  txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
                                  onError: (dispatchError) {
                                    final message = getLocalizedTxErrorMessage(context.l10n, dispatchError);
                                    showTxErrorDialog(context, message, false);
                                  },
                                ),
                              );
                            } else {
                              return _appSettingsStore.developerMode
                                  ? ElevatedButton(
                                      onPressed: null,
                                      child: Text(l10n.issuanceClaimed),
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
              CeremonyBox(widget.store, webApi, key: const Key(EWTestKeys.ceremonyBoxWallet)),
              const SizedBox(height: 24),
              if (widget.store.encointer.community != null)
                Observer(
                  builder: (_) => AnnouncementView(
                    cid: widget.store.encointer.community!.cid.toFmtString(),
                    devMode: context.read<AppSettings>().developerMode,
                    languageCode: Localizations.localeOf(context).languageCode,
                  ),
                )
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
                  rowTitle: l10n.switchCommunity,
                  accountOrCommunityData: _allCommunities(),
                  onTap: (int index) async {
                    final store = context.read<AppStore>();
                    final communityStores = store.encointer.communityStores?.values.toList() ?? [];
                    await store.encointer.setChosenCid(communityStores[index].cid);

                    context.read<AppSettings>().changeTheme(store.encointer.community?.cid.toFmtString());
                  },
                  onAddIconPressed: () {
                    Navigator.pushNamed(context, CommunityChooserOnMap.route).then((_) {
                      _refreshEncointerState();
                    });
                  },
                  addIconButtonKey: const Key(EWTestKeys.addCommunity),
                );
              }),
              Observer(builder: (BuildContext context) {
                return SwitchAccountOrCommunity(
                  rowTitle: l10n.switchAccount,
                  accountOrCommunityData: initAllAccounts(),
                  onTap: (int index) async {
                    await switchAccount(widget.store.account.accountListAll[index]);
                    unawaited(_refreshEncointerState());
                  },
                  onAddIconPressed: () {
                    Navigator.of(context).pushNamed(AddAccountView.route);
                  },
                  addIconButtonKey: const Key(EWTestKeys.addAccountPanel),
                );
              }),
            ]),
          ],
        ),
      ),
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
    );
  }

  List<AccountOrCommunityData> _allCommunities() {
    final communityStores = context.read<AppStore>().encointer.communityStores?.values.toList();

    if (communityStores == null) return [];
    return communityStores
        .mapIndexed(
          (i, e) => AccountOrCommunityData(
            avatar: Container(
              height: avatarSize,
              width: avatarSize,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
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
  }

  List<AccountOrCommunityData> initAllAccounts() {
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

  void _connectNodeAll() {
    // if network connected failed, reconnect
    if (!widget.store.settings.loading && !webApi.provider.isConnected()) {
      webApi.init();
    }
  }

  Future<void> _refreshEncointerState() async {
    // getCurrentPhase is the root of all state updates.
    unawaited(getSwapOptions());
    await webApi.encointer.getCurrentPhase();
    await widget.store.encointer.getEncointerBalance();
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
