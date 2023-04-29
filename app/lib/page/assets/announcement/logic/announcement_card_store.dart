import 'package:mobx/mobx.dart';

part 'announcement_card_store.g.dart';

// ignore: library_private_types_in_public_api
class AnnouncementCardStore = _AnnouncementCardStoreBase with _$AnnouncementCardStore;

abstract class _AnnouncementCardStoreBase with Store {
  @observable
  bool isFavorite = false;

  @observable
  int countFavorite = 0;

  @action
  void toggleFavorite() {
    if (isFavorite) {
      isFavorite = false;
      countFavorite--;

      /// send favorite to backend unlike
    } else {
      isFavorite = true;
      countFavorite++;

      /// send favorite to backend to like
    }
  }
}
