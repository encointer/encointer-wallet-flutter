// import 'package:encointer_wallet/data/common_services/models/network/api_response.dart';
// import 'package:encointer_wallet/data/remote/announcements/announcements_api_services.dart';
// import 'package:encointer_wallet/mocks/announcements/mock_announcements_api.dart';
// import 'package:encointer_wallet/models/announcement/announcement.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockAnnouncementsApi extends Mock implements AnnouncementsApiServices {}

// void main() {
//   late MockAnnouncementsApi mockAnnouncementsApi;

//   setUp(() {
//     mockAnnouncementsApi = MockAnnouncementsApi();
//   });

//   void setGetAnnouncementCommunnity() {
//     when(
//       () => mockAnnouncementsApi.getCommunityAnnouncements(cid: any(named: 'cid')),
//     ).thenAnswer((_) async => Success<List<Announcement>>(data: leuAnnouncements));
//   }

//   void setGetAnnouncementGlobal() {
//     when(
//       () => mockAnnouncementsApi.getGlobalAnnouncements(),
//     ).thenAnswer((_) async => Success<List<Announcement>>(data: globalAnnouncements));
//   }

//   group('AnnouncementsApi methods test:', () {
//     test('AnnouncementsApi getAnnouncementCommunnity method test', () async {
//       // arrange
//       setGetAnnouncementCommunnity();

//       // act
//       final result = await mockAnnouncementsApi.getCommunityAnnouncements(cid: 'cid');

//       // assert
//       expect((result as Success<List<Announcement>>).data!.first.communityIdentifier,
//           equals(leuAnnouncements.first.communityIdentifier));
//     });
//     test('AnnouncementsApi getAnnouncementGlobal method test', () async {
//       // arrange
//       setGetAnnouncementGlobal();

//       // act
//       final result = await mockAnnouncementsApi.getGlobalAnnouncements();

//       // assert
//       expect((result as Success<List<Announcement>>).data!.first.communityIdentifier,
//           equals(globalAnnouncements.first.communityIdentifier));
//     });
//   });
// }
