class Announcement {
  const Announcement({
    required this.title,
    required this.publisher,
    required this.message,
    required this.date,
  });

  final String title;
  final String publisher;
  final String message;
  final DateTime date;
}

List<Announcement> announcements = [
  Announcement(
    title: 'Announcement 1',
    publisher: 'Publisher 1',
    message: 'This is the message for announcement 1',
    date: DateTime.now(),
  ),
  Announcement(
    title: 'Announcement 2',
    publisher: 'Publisher 2',
    message: 'This is the message for announcement 2',
    date: DateTime.now(),
  ),
  Announcement(
    title: 'Announcement 3',
    publisher: 'Publisher 3',
    message: 'This is the message for announcement 3',
    date: DateTime.now(),
  ),
];

// const announcementMockData = {
//   'announcement': [
//     {
//       'title': 'This is a title',
//       'publisher': 'John Doe',
//       'message': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
//       'date': DateTime.now(),
   
//     },
   
//   ]
// };

