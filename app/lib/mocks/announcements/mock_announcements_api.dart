import 'package:encointer_wallet/models/announcement/announcement.dart';

List<Announcement> leuAnnouncements = [
  Announcement(
    communityIdentifier: 'u0qj944rhWE',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
    publishDate: DateTime.now(),
    publisherSVG:
        'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/communnity_leader_photo.png?raw=true',
    title: 'Leu announcements!',
    isFavorite: true,
    countFavorite: 1,
  )
];
List<Announcement> globalAnnouncements = [
  Announcement(
    communityIdentifier: 'global',
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
    publishDate: DateTime.now(),
    publisherSVG:
        'https://raw.githubusercontent.com/SourbaevaJanaraJ/lock_screen/master/assets/communnity_leader_photo.png',
    title: 'Global announcements!',
    countFavorite: 101,
  )
];

List<Map<String, dynamic>> globalAnnouncementsData = [
  {
    'communityIdentifier': 'global',
    'title': 'This is a title',
    'publisherSVG':
        'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/communnity_leader_photo.png?raw=true',
    'content':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
    'publishDate': '2023-04-28T11:30:00.00+00:00',
    'isFavorite': false,
    'countFavorite': 101
  }
];

List<Map<String, dynamic>> leuAnnouncementsData = [
  {
    'communityIdentifier': 'u0qj944rhWE',
    'title': 'This is a title',
    'publisherSVG':
        'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/communnity_leader_photo.png?raw=true',
    'content':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
    'publishDate': '2023-04-28T11:30:00.00+00:00',
    'isFavorite': true,
    'countFavorite': 1
  }
];
