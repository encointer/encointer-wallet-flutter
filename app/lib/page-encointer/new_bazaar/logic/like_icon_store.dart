import 'package:mobx/mobx.dart';

part 'like_icon_store.g.dart';

// ignore: library_private_types_in_public_api
class LikeIconStore = _LikeIconStoreBase with _$LikeIconStore;

abstract class _LikeIconStoreBase with Store {
  _LikeIconStoreBase({bool isLiked1 = false, bool isLikedPersonally1 = false, int countLikes1 = 0})
      : isLiked = isLiked1,
        isLikedPersonally = isLikedPersonally1,
        countLikes = countLikes1;

  @observable
  late bool isLiked;

  @observable
  late bool isLikedPersonally;

  @observable
  late int countLikes;

  @action
  void toggleLikes() {
    isLiked = !isLiked;
    isLiked ? countLikes++ : countLikes--;
  }

  @action
  void toggleOwnLikes() {
    isLikedPersonally = !isLikedPersonally;
  }
}
