import 'package:flutter/cupertino.dart';
import 'package:ew_http/ew_http.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/utils.dart';

part 'home_page_store.g.dart';

const _logTarget = 'HomePageStore';
// ignore: library_private_types_in_public_api
class HomePageStore = _HomePageStoreBase with _$HomePageStore;

abstract class _HomePageStoreBase with Store, WidgetsBindingObserver {
  _HomePageStoreBase(this.appStore, this.buildContext) {
    _init();
  }

  @observable
  late AppStore appStore;

  @observable
  late BuildContext buildContext;

  @action
  void _init() {
    Log.d(_logTarget, '_init');
    WidgetsBinding.instance.addObserver(this);
    if (!RepositoryProvider.of<AppConfig>(buildContext).isIntegrationTest) NotificationPlugin.init(buildContext);
  }

  @action
  Future<void> postFrameCallbacks() async {
    Log.d(_logTarget, 'postFrameCallbacks');
    final encointer = buildContext.read<AppStore>().encointer;
    final cid = encointer.community?.cid.toFmtString();
    await initialDeepLinks(buildContext);
    await NotificationHandler.fetchMessagesAndScheduleNotifications(
      tz.local,
      NotificationPlugin.scheduleNotification,
      langCode: Localizations.localeOf(buildContext).languageCode,
      cid: cid,
      ewHttp: RepositoryProvider.of<EwHttp>(buildContext),
      devMode: buildContext.read<AppSettings>().developerMode,
    );

    // Should never be null, we either come from the splash screen, and hence we had
    // enough time to connect to the blockchain or we already have a populated store.
    //
    // Hence, can only be null if someone uses the app for the first time and is offline.
    if (encointer.nextRegisteringPhaseStart != null &&
        encointer.currentCeremonyIndex != null &&
        encointer.ceremonyCycleDuration != null) {
      await CeremonyNotifications.scheduleRegisteringStartsReminders(
        encointer.nextRegisteringPhaseStart!,
        encointer.currentCeremonyIndex!,
        encointer.ceremonyCycleDuration!,
        I18n.of(buildContext)!.translationsForLocale().encointer,
        cid: cid,
      );

      await CeremonyNotifications.scheduleLastDayOfRegisteringReminders(
        encointer.assigningPhaseStart!,
        encointer.currentCeremonyIndex!,
        encointer.ceremonyCycleDuration!,
        I18n.of(buildContext)!.translationsForLocale().encointer,
        cid: cid,
      );
    }
  }

  @action
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    Log.d(_logTarget, 'Change lifecycle to $state');

    if (state == AppLifecycleState.resumed) {
      final connected = await webApi.isConnected();
      Log.d(_logTarget, 'webApi.isConnected() = $connected');
      if (!connected) {
        /// initialize webApi again if it's failed after
        /// user closes the app and reopens it
        await initWebApi(buildContext, appStore);
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @action
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
