import 'package:encointer_wallet/page/assets/announcement/widgets/publisher_and_community_icon.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.announcement});
  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final local = Localizations.localeOf(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Card(
        color: zurichLion.shade50,
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
              subtitle: Text(announcement.title, style: textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Text(
                announcement.content,
                style: textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Iconsax.heart5,
                    size: 20,
                    color: encointerGrey,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.share,
                    size: 20,
                    color: encointerGrey,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
