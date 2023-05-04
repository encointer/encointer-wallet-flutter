import 'package:encointer_wallet/page/assets/announcement/logic/announcement_card_store.dart';
import 'package:encointer_wallet/utils/translations/translations_home.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_store.dart';
import 'package:encointer_wallet/page/assets/announcement/widgets/announcement_card.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AnnouncementView extends StatefulWidget {
  const AnnouncementView({
    super.key,
    required this.cid,
  });

  final String? cid;

  @override
  State<AnnouncementView> createState() => _AnnouncementViewState();
}

class _AnnouncementViewState extends State<AnnouncementView> {
  final AnnouncementStore _announcementStore = AnnouncementStore();
  late TranslationsHome _dic;

  @override
  void initState() {
    _announcementStore.init();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    _dic = I18n.of(context)!.translationsForLocale().home;
    await _getAnnouncements();
    super.didChangeDependencies();
  }

  Future<void> _getAnnouncements() async {
    await Future.wait([
      _announcementStore.getAnnouncementGlobal(),
      _announcementStore.getAnnouncementCommunnity(widget.cid),
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
    if (_announcementStore.error != null) {
      return Center(
        child: Text(_announcementStore.error!),
      );
    } else if (announcements == null) {
      return const Center(child: CupertinoActivityIndicator());
    } else if (announcements.isEmpty) {
      return const Center(child: Text('No Announcement found!!!'));
    } else if (announcements.isNotEmpty) {
      return AnnouncementList(announcements: announcements);
    } else {
      return Center(child: Text(_dic.unknownError));
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
