import 'package:encointer_wallet/mocks/announcements/mock_announcements_api.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test Announcement serialization', () {
    test('test Announcement serialization for leu', () {
      final leuAnnon = leuAnnouncements;
      final leuAnnonData = leuAnnouncementsData;

      final result = leuAnnonData.map((e) => Announcement.fromJson(e)).toList();

      expect(result.first.communityIdentifier, leuAnnon.first.communityIdentifier);
    });

    test('test Announcement serialization for global', () {
      final globalAnnon = globalAnnouncements;
      final globalAnnonData = globalAnnouncementsData;

      final result = globalAnnonData.map((e) => Announcement.fromJson(e)).toList();

      expect(result.first.communityIdentifier, globalAnnon.first.communityIdentifier);
    });
  });
}
