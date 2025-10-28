import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/utils/fetch_status.dart';

part 'single_business_store.g.dart';

// const _targetLogger = 'SingleBusinessStore';

// ignore: library_private_types_in_public_api
class SingleBusinessStore = _SingleBusinessStoreBase with _$SingleBusinessStore;

abstract class _SingleBusinessStoreBase with Store {
  _SingleBusinessStoreBase(
    this.business, {
    bool isLiked1 = false,
    bool isLikedPersonally1 = false,
    int countLikes1 = 0,
  })  : isLiked = isLiked1,
        isLikedPersonally = isLikedPersonally1,
        countLikes = countLikes1;

  late final IpfsBusiness business;

  @observable
  late bool isLiked;

  @observable
  late bool isLikedPersonally;

  @observable
  late int countLikes;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @observable
  List<IpfsProduct> ipfsProducts = <IpfsProduct>[];

  @observable
  String? error;

  @action
  Future<void> getSingleBusiness() async {
    fetchStatus = FetchStatus.loading;

    // todo get photos

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
