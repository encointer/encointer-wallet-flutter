import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/page/assets/announcement/widgets/publisher_and_community_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';

class AnnouncementCard extends StatefulWidget {
  const AnnouncementCard({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  State<AnnouncementCard> createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  late int _countFavorite;
  late bool _isFavorite;

  @override
  void initState() {
    _isFavorite = widget.announcement.isFavorite;
    _countFavorite = widget.announcement.countFavorite;
    super.initState();
  }

  void _likeUnlike() {
    setState(() {
      if (_isFavorite) {
        _isFavorite = false;
        _countFavorite--;

        /// send favorite to backend unlike
      } else {
        _isFavorite = true;
        _countFavorite++;

        /// send favorite to backend to like
      }
    });
  }

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
              leading: PublisherSVGandCommunityIcon(widget.announcement.publisherSVG),
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(DateFormat.MMMd(local.languageCode).format(widget.announcement.publishDate),
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              subtitle: Text(widget.announcement.title, style: textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: Text(
                widget.announcement.content,
                style: textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                    size: 20,
                    color: _isFavorite ? encointerGrey : encointerGrey,
                  ),
                  onPressed: _likeUnlike,
                ),
                Text('$_countFavorite'),
                IconButton(
                  icon: const Icon(
                    Icons.share,
                    size: 20,
                    color: encointerGrey,
                  ),
                  onPressed: () {
                    Share.share(widget.announcement.content);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
