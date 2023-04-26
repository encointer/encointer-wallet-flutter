import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_store.dart';
import 'package:encointer_wallet/page/assets/announcement/widgets/announcement_card.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AnnouncementStore>();
    final dic = I18n.of(context)!.translationsForLocale().home;
    final appSettingsStore = context.watch<AppSettings>();
    return Observer(builder: (_) {
      if (store.announcements == null) {
        return const Center(child: CupertinoActivityIndicator());
      } else if (store.announcements!.isEmpty) {
        return const Center(child: Text('No Announcement found!!!'));
      } else if (store.announcements!.isNotEmpty) {
        if (appSettingsStore.developerMode) {
          return AnnouncementList(announcements: store.announcements!);
        } else {
          return Container();
        }
      } else {
        return Center(child: Text(dic.unknownError));
      }
    });
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
        return AnnouncementCard(announcement: announcement);
      },
    );
  }
}
