import 'package:ew_http/ew_http.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_card_store.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_store.dart';
import 'package:encointer_wallet/page/assets/announcement/widgets/announcement_card.dart';

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

  @override
  void initState() {
    _announcementStore = AnnouncementStore(RepositoryProvider.of<EwHttp>(context));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAnnouncements();
    });

    super.initState();
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

  Future<void> _getAnnouncements() async {
    final devMode = context.read<AppSettings>().developerMode;
    await Future.wait([
      _announcementStore.getGlobalAnnouncements(devMode: devMode),
      _announcementStore.getCommunityAnnouncements(widget.cid,
          devMode: devMode, langCode: Localizations.localeOf(context).languageCode),
    ]);
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
