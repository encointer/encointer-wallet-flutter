import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_card_store.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/utils/translations/translations_home.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/models/announcement/announcement.dart';
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
  final AnnouncementStore _announcementStore = AnnouncementStore();
  late TranslationsHome _dic;

  List<ReactionDisposer> _disposers = <ReactionDisposer>[];

  @override
  void initState() {
    _disposers = <ReactionDisposer>[
      /// in case of an error, it triggers dialog to popup
      reaction((_) => _announcementStore.error.isNotNullOrEmpty, (result) {
        if (result) {
          AppAlert.showErrorDialog(
            context,
            errorText: _getErrorMessages(failureType: FailureType.unknown, error: _announcementStore.error),
            buttontext: _dic.ok,
          );
        }
      }),

      /// in case of an error, it triggers dialog to popup
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
    await Future.wait([
      _announcementStore.getGlobalAnnouncements(),
      _announcementStore.getLeuAnnouncements(widget.cid),
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
  Widget buildAnnouncementList(List<Announcement>? announcements) {
    if (_announcementStore.loading) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (announcements!.isEmpty) {
      return Center(child: Text(_dic.noAnnouncementFound));
    } else if (announcements.isNotEmpty) {
      return AnnouncementList(announcements: announcements);
    } else {
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
