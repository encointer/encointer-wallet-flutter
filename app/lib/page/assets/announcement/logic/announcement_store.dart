import 'package:encointer_wallet/models/announcement/announcement.dart';
import 'package:mobx/mobx.dart';

part 'announcement_store.g.dart';

// ignore: library_private_types_in_public_api
class AnnouncementStore = _AnnouncementStoreBase with _$AnnouncementStore;

abstract class _AnnouncementStoreBase with Store {
  @observable
  List<Announcement>? announcements;

  @action
  Future<void> getAnnouncement() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = announcementMockData['announcement'];
    announcements = data?.map(Announcement.fromJson).toList();
  }
}
