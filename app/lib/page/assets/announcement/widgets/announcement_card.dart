import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/page/assets/announcement/widgets/publisher_and_community_icon.dart';
import 'package:encointer_wallet/page/assets/announcement/logic/announcement_card_store.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/theme/theme.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final local = Localizations.localeOf(context);
    final cardStore = context.watch<AnnouncementCardStore>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Card(
        color: context.colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: PublisherSVGandCommunityIcon(announcement.publisherSVG),
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(DateFormat.MMMd(local.languageCode).format(announcement.publishDate),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              subtitle: Text(announcement.title, style: textTheme.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Text(
                announcement.content,
                style: textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Observer(builder: (_) {
                    return Icon(
                      cardStore.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                      size: 20,
                      color: AppColors.encointerGrey,
                    );
                  }),
                  onPressed: context.read<AnnouncementCardStore>().toggleFavorite,
                ),
                Observer(builder: (_) {
                  return Text('${cardStore.countFavorite}');
                }),
                IconButton(
                  icon: const Icon(Icons.share, size: 20, color: AppColors.encointerGrey),
                  onPressed: () => Share.share('${announcement.title}\n${announcement.content}\n$encointerLink/home'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
