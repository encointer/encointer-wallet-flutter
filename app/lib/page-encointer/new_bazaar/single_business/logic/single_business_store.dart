import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'single_business_store.g.dart';

// ignore: library_private_types_in_public_api
class SingleBusinessStore = _SingleBusinessStoreBase with _$SingleBusinessStore;

abstract class _SingleBusinessStoreBase with Store {
  _SingleBusinessStoreBase(this.businesses,
      {bool isLiked1 = false, bool isLikedPersonally1 = false, int countLikes1 = 0})
      : isLiked = isLiked1,
        isLikedPersonally = isLikedPersonally1,
        countLikes = countLikes1;
  final Businesses businesses;

  @observable
  late bool isLiked;

  @observable
  late bool isLikedPersonally;

  @observable
  late int countLikes;

  @observable
  SingleBusiness? singleBusiness;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getSingleBusiness() async {
    fetchStatus = FetchStatus.loading;
    await Future<void>.delayed(const Duration(seconds: 1));
    final items = SingleBusiness.fromJson(singleBusinessMockData);
    singleBusiness = items;
    fetchStatus = FetchStatus.success;
  }

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
