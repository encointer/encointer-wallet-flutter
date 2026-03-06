import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:mobx/mobx.dart';

part 'single_business_store.g.dart';

// const _targetLogger = 'SingleBusinessStore';

// ignore: library_private_types_in_public_api
class SingleBusinessStore = _SingleBusinessStoreBase with _$SingleBusinessStore;

abstract class _SingleBusinessStoreBase with Store {
  _SingleBusinessStoreBase(
    this.business, {
    // ignore: unused_element_parameter
    this.isOwner = false,
    // ignore: unused_element_parameter
    this.isDelegate = false,
    bool isLiked1 = false,
    bool isLikedPersonally1 = false,
    int countLikes1 = 0,
  })  : isLiked = isLiked1,
        isLikedPersonally = isLikedPersonally1,
        countLikes = countLikes1;

  @observable
  IpfsBusiness business;

  @observable
  bool wasEdited = false;

  final bool isOwner;
  final bool isDelegate;

  @observable
  late bool isLiked;

  @observable
  late bool isLikedPersonally;

  @observable
  late int countLikes;

  @observable
  List<IpfsProduct> ipfsProducts = <IpfsProduct>[];

  @observable
  String? error;

  @action
  void updateBusiness(IpfsBusiness b) {
    business = b;
    wasEdited = true;
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
