import 'package:ew_http/ew_http.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_card_store.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_store.dart';
import 'package:encointer_wallet/page/assets/announcement/widgets/announcement_card.dart';
import 'package:encointer_wallet/l10n/l10.dart';

const _logTarget = 'announcement_view';

class AnnouncementView extends StatefulWidget {
  const AnnouncementView({
    super.key,

    /// [cid] is required because in Assets (page)
    /// widget.store.encointer.community?.cid.toFmtString() can be null
    /// required to escape any mistakes could be made by a developer
    /// and not pass cid here
    required this.cid,
  });

  final String? cid;

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  late final AnnouncementStore _announcementStore;
  List<ReactionDisposer> _disposers = <ReactionDisposer>[];

  @override
  void initState() {
    _announcementStore = AnnouncementStore(RepositoryProvider.of<EwHttp>(context));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAnnouncements();
    });

    _listenToErrors();

    super.initState();
  }

  @override
  void dispose() {
    /// Important! Do not forget to dispose all disposable variables
    /// which may lead to a memory leak issues
    if (_disposers.isNotEmpty) {
      for (final d in _disposers) {
        d();
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return switch (_announcementStore.fetchStatus) {
        FetchStatus.loading => const Center(child: CupertinoActivityIndicator()),
        FetchStatus.success => AnnouncementList(announcements: _announcementStore.announcements),
        FetchStatus.error => const SizedBox.shrink(),
      };
    });
  }

  void _listenToErrors() {
    _disposers = <ReactionDisposer>[
      /// in case of an unknown error, it triggers dialog to popup
      reaction((_) => _announcementStore.error.isNotNullOrEmpty, (result) {
        if (result) {
          AppAlert.showErrorDialog(
            context,
            errorText: _getErrorMessages(failureType: FailureType.unknown, error: _announcementStore.error),
            buttontext: context.l10n.ok,
          );
        }
      }),

      /// in case of a known error, it triggers dialog to popup
      reaction((_) => _announcementStore.failureType != null, (result) {
        if (result) {
          AppAlert.showErrorDialog(
            context,
            errorText: _getErrorMessages(failureType: _announcementStore.failureType!, error: _announcementStore.error),
            buttontext: context.l10n.ok,
          );
        }
      })
    ];
  }

  Future<void> _getAnnouncements() async {
    final devMode = context.read<AppSettings>().developerMode;
    await Future.wait([
      _announcementStore.getGlobalAnnouncements(devMode: devMode),
      _announcementStore.getCommunityAnnouncements(widget.cid,
          devMode: devMode, langCode: Localizations.localeOf(context).languageCode),
    ]);
  }

  String _getErrorMessages({
    required FailureType failureType,

    /// [error] is required because we check for it first
    /// if it's not null we return needed localized text
    required String? error,
  }) {
    Log.d('_getErrorMessages: failureType = $failureType, error = $error', _logTarget);
    if (error.isNotNullOrEmpty) {
      return '${context.l10n.announcements} ${context.l10n.errorMessageWithStatusCode(error!)}';
    }
    return switch (failureType) {
      FailureType.badRequest => '${context.l10n.announcements} ${context.l10n.badRequest}',
      FailureType.noAuthorization => '${context.l10n.announcements} ${context.l10n.noAuthorizationError}',
      _ => '${context.l10n.announcements} ${context.l10n.somethingWentWrong}',
    };
  }
}

class AnnouncementList extends StatelessWidget {
  const AnnouncementList({super.key, required this.announcements});

  final List<Announcement> announcements;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: announcements.length,
      itemBuilder: (BuildContext context, int index) {
        final announcement = announcements[index];
        return Provider(
          create: (context) => AnnouncementCardStore(
            isFavorite1: announcement.isFavorite,
            countFavorite1: announcement.countFavorite,
          ),
          child: AnnouncementCard(announcement: announcement),
        );
      },
    );
  }
}
