
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'single_business_store.g.dart';

// const _targetLogger = 'SingleBusinessStore';

// ignore: library_private_types_in_public_api
class SingleBusinessStore = _SingleBusinessStoreBase with _$SingleBusinessStore;

abstract class _SingleBusinessStoreBase with Store {
  _SingleBusinessStoreBase(
    this._business, {
    bool isLiked1 = false,
    bool isLikedPersonally1 = false,
    int countLikes1 = 0,
  })  : isLiked = isLiked1,
        isLikedPersonally = isLikedPersonally1,
        countLikes = countLikes1;

  late final IpfsBusiness _business;


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

  @observable
  List<IpfsProduct> ipfsProducts = <IpfsProduct>[];

  @observable
  String? error;

  @action
  Future<void> getSingleBusiness() async {
    fetchStatus = FetchStatus.loading;

    final singleB = SingleBusiness(
      name: _business.name,
      description: _business.description,
      category: _business.category.name,
      address: _business.address,
      zipcode: 'zipcode',
      addressDescription: 'addressDescription',
      status: _business.status?.name ?? '',
      telephone: _business.telephone ?? '',
      email: _business.email ?? '',
      longitude: double.tryParse(_business.longitude) ?? 0,
      latitude: double.tryParse(_business.latitude) ?? 0,
      openingHours: _business.openingHours,
      logo: _business.logo ?? '',
      photo: _business.photo ?? '',
      offer: 'offer',
      offerName1: 'offerName1',
      offerName2: 'offerName2',
      moreInfo: 'moreInfo',
    );

    singleBusiness = singleB;
    //
    // final offerings = await _bazaarGetOfferingsForBusines();
    // await _getIpfsProducts(offerings);

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
