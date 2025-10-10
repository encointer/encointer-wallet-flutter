import 'dart:developer';

import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_product.dart';
import 'package:encointer_wallet/models/bazaar/item_offered.dart';
import 'package:encointer_wallet/models/bazaar/offering_data.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:ew_http/ew_http.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'single_business_store.g.dart';

const _targetLogger = 'SingleBusinessStore';

// ignore: library_private_types_in_public_api
class SingleBusinessStore = _SingleBusinessStoreBase with _$SingleBusinessStore;

abstract class _SingleBusinessStoreBase with Store {
  _SingleBusinessStoreBase(
    this._businesses,
    this._cid, {
    bool isLiked1 = false,
    bool isLikedPersonally1 = false,
    int countLikes1 = 0,
  })  : isLiked = isLiked1,
        isLikedPersonally = isLikedPersonally1,
        countLikes = countLikes1;

  late final IpfsBusiness _businesses;

  late final CommunityIdentifier _cid;

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
      name: _businesses.name,
      description: _businesses.description,
      category: _businesses.category.name,
      address: _businesses.address,
      zipcode: 'zipcode',
      addressDescription: 'addressDescription',
      status: _businesses.status?.name ?? '',
      telephone: _businesses.telephone ?? '',
      email: _businesses.email ?? '',
      longitude: double.tryParse(_businesses.longitude) ?? 0,
      latitude: double.tryParse(_businesses.latitude) ?? 0,
      openingHours: _businesses.openingHours,
      logo: _businesses.logo ?? '',
      photo: _businesses.photo ?? '',
      offer: 'offer',
      offerName1: 'offerName1',
      offerName2: 'offerName2',
      moreInfo: 'moreInfo',
    );

    singleBusiness = singleB;

    final offerings = await _bazaarGetOfferingsForBusines();
    await _getIpfsProducts(offerings);

    fetchStatus = FetchStatus.success;
  }

  Future<void> _getIpfsProducts(List<OfferingData> offerings) async {
    if (offerings.isNotEmpty) {
      for (final offering in offerings) {
        if (offering.url.isNotNullOrEmpty) {
          final itemOffered = await _getItemOffered(offering.url!);

          await itemOffered.fold((l) => null, (item) async {
            final ipfsProduct = await _getSingleBusinessProduct(item.itemOffered);

            ipfsProduct.fold(
              (l) {
                error = l.failureType.name;
              },
              (r) {
                r.price = item.price;
                log('SingleBusinessStore _getIpfsProducts r: ${r.toJson()}');
                ipfsProducts.add(r);
                fetchStatus = FetchStatus.success;
              },
            );
          });
        }
      }
    }
  }

  Future<List<OfferingData>> _bazaarGetOfferingsForBusines() {
    Log.d('_bazaarGetOfferingsForBusines: _cid = $_cid', _targetLogger);
    return webApi.encointer.bazaarGetOfferingsForBusiness(_cid, _businesses.controller);
  }

  Future<Either<ItemOffered, EwHttpException>> _getItemOffered(String ipfsUrlHash) {
    Log.d('_getItemOffered: ipfsUrlHash = $ipfsUrlHash', _targetLogger);
    return webApi.encointer.getItemOffered(ipfsUrlHash);
  }

  Future<Either<IpfsProduct, EwHttpException>> _getSingleBusinessProduct(String ipfsUrlHash) {
    Log.d('_getSingleBusinessProduct: ipfsUrlHash = $ipfsUrlHash', _targetLogger);
    return webApi.encointer.getSingleBusinessProduct(ipfsUrlHash);
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
