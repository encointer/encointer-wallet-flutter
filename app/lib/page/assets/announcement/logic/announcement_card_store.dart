import 'package:mobx/mobx.dart';

part 'announcement_card_store.g.dart';

// ignore: library_private_types_in_public_api
class AnnouncementCardStore = _AnnouncementCardStoreBase with _$AnnouncementCardStore;

abstract class _AnnouncementCardStoreBase with Store {
  _AnnouncementCardStoreBase({bool isFavorite1 = false, int countFavorite1 = 0})
      : isFavorite = isFavorite1,
        countFavorite = countFavorite1;

  @observable
  late bool isFavorite;

  @observable
  late int countFavorite;

  @action
  void toggleFavorite() {
    isFavorite = !isFavorite;
    isFavorite ? countFavorite++ : countFavorite--;
  }
}
