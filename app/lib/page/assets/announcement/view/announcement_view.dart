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
import 'package:encointer_wallet/utils/translations/translations_home.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_store.dart';
import 'package:encointer_wallet/page/assets/announcement/widgets/announcement_card.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

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
  late TranslationsHome _dic;

  List<ReactionDisposer> _disposers = <ReactionDisposer>[];

  @override
  void initState() {
    _announcementStore = AnnouncementStore(RepositoryProvider.of<EwHttp>(context));
    _disposers = <ReactionDisposer>[
      /// in case of an unknown error, it triggers dialog to popup
      reaction((_) => _announcementStore.error.isNotNullOrEmpty, (result) {
        if (result) {
          AppAlert.showErrorDialog(
            context,
            errorText: _getErrorMessages(failureType: FailureType.unknown, error: _announcementStore.error),
            buttontext: _dic.ok,
          );
        }
      }),

      /// in case of a known error, it triggers dialog to popup
      reaction((_) => _announcementStore.failureType != null, (result) {
        if (result) {
          AppAlert.showErrorDialog(
            context,
            errorText: _getErrorMessages(failureType: _announcementStore.failureType!, error: _announcementStore.error),
            buttontext: _dic.ok,
          );
        }
      })
    ];
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    _dic = I18n.of(context)!.translationsForLocale().home;
    await _getAnnouncements();

    super.didChangeDependencies();
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

  Future<void> _getAnnouncements() async {
    final devMode = context.read<AppSettings>().developerMode;
    await Future.wait([
      _announcementStore.getGlobalAnnouncements(devMode: devMode),
      _announcementStore.getCommunityAnnouncements(widget.cid, devMode: devMode),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            return buildAnnouncementList(_announcementStore.announcementsGlobal);
          },
        ),
        Observer(
          builder: (_) {
            return buildAnnouncementList(_announcementStore.announcementsCommunnity);
          },
        ),
      ],
    );
  }

  /// NOTE: Do not write any functions inside [build]!
  Widget buildAnnouncementList(List<Announcement> announcements) {
    switch (_announcementStore.fetchStatus) {
      case FetchStatus.loading:
        return const Center(child: CupertinoActivityIndicator());
      case FetchStatus.success:
        return AnnouncementList(announcements: announcements);
      case FetchStatus.error:
        return Center(child: Text(_dic.unknownError));
    }
  }

  String _getErrorMessages({
    required FailureType failureType,

    /// [error] is required because we check for it first
    /// if it's not null we return needed localized text
    required String? error,
  }) {
    Log.d('_getErrorMessages: failureType = $failureType, error = $error', _logTarget);
    if (error.isNotNullOrEmpty) {
      return '${_dic.announcements} ${_dic.errorMessageWithStatusCode(error!)}';
    }
    switch (failureType) {
      case FailureType.badRequest:
        return '${_dic.announcements} ${_dic.badRequest}';
      case FailureType.noAuthorization:
        return '${_dic.announcements} ${_dic.noAuthorizationError}';
      // ignore: no_default_cases
      default:
        return '${_dic.announcements} ${_dic.somethingWentWrong}';
    }
  }
}

class AnnouncementList extends StatelessWidget {
  const AnnouncementList({super.key, required this.announcements});

  final List<Announcement> announcements;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().home;
    if (announcements.isEmpty) return Center(child: Text(dic.noAnnouncementFound));
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
