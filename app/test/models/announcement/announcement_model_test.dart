import 'package:encointer_wallet/mocks/announcements/mock_announcements_api.dart';
import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test Announcement serialization', () {
    test('for leu', () {
      final leuAnnon = leuAnnouncements;
      final leuAnnonJson = leuAnnouncementsJson;

      final result = leuAnnonJson.map(Announcement.fromJson).toList();

      expect(result.first.communityIdentifier, leuAnnon.first.communityIdentifier);
    });

    test('for global', () {
      final globalAnnon = globalAnnouncements;
      final globalAnnonJson = globalAnnouncementsJson;

      final result = globalAnnonJson.map(Announcement.fromJson).toList();

      expect(result.first.communityIdentifier, globalAnnon.first.communityIdentifier);
    });
  });
}
