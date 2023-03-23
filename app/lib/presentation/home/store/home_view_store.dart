import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/service/deep_link/deep_link.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/meetup/notification_handler.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';

import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:timezone/timezone.dart' as tz;

part 'home_view_store.g.dart';

const _tag = 'home_view_store';

class HomeViewStore = _HomeViewStoreBase with _$HomeViewStore;

abstract class _HomeViewStoreBase with Store {
  _HomeViewStoreBase() : _appStore = sl.get<AppStore>();

  late final AppStore _appStore;

  @computed
  AppStore get appStore => _appStore;

  @action
  Future<void> init(BuildContext context) async {
    Log.d('init', _tag);

    await initDeepLinks(context);
    await fetchMessagesAndScheduleNotifications(context);
    await runCeremonyNotifications(context);
  }

  @action
  Future<void> initDeepLinks(BuildContext context) async {
    Log.d('initDeepLinks', _tag);
    await initialDeepLinks(context);
  }

  @action
  Future<void> fetchMessagesAndScheduleNotifications(BuildContext context) async {
    Log.d('fetchMessagesAndScheduleNotifications', _tag);
    await NotificationHandler.fetchMessagesAndScheduleNotifications(
      tz.local,
      NotificationPlugin.scheduleNotification,
      Localizations.localeOf(context).languageCode,
    );
  }

  @action
  Future<void> runCeremonyNotifications(BuildContext context) async {
    Log.d('runCeremonyNotifications', _tag);
    // Should never be null, we either come from the splash screen, and hence we had
    // enough time to connect to the blockchain or we already have a populated store.
    //
    // Hence, can only be null if someone uses the app for the first time and is offline.
    final encointer = sl<AppStore>().encointer;
    if (encointer.nextRegisteringPhaseStart != null &&
        encointer.currentCeremonyIndex != null &&
        encointer.ceremonyCycleDuration != null) {
      await CeremonyNotifications.scheduleRegisteringStartsReminders(
        encointer.nextRegisteringPhaseStart!,
        encointer.currentCeremonyIndex!,
        encointer.ceremonyCycleDuration!,
        I18n.of(context)!.translationsForLocale().encointer,
      );

      await CeremonyNotifications.scheduleLastDayOfRegisteringReminders(
        encointer.assigningPhaseStart!,
        encointer.currentCeremonyIndex!,
        encointer.ceremonyCycleDuration!,
        I18n.of(context)!.translationsForLocale().encointer,
      );
    }
  }
}
