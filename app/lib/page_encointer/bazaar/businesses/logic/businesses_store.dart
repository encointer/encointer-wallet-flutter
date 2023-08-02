import 'package:mobx/mobx.dart';
import 'package:ew_http/ew_http.dart';

import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/page_encointer/bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';

part 'businesses_store.g.dart';

const _targetLogger = 'BusinessesStore';

// ignore: library_private_types_in_public_api
class BusinessesStore = _BusinessesStoreBase with _$BusinessesStore;

abstract class _BusinessesStoreBase with Store {
  @observable
  List<Businesses> businesses = <Businesses>[];

  @observable
  List<Businesses> sortedBusinesses = <Businesses>[];

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @observable
  String? error;

  Future<List<AccountBusinessTuple>> _bazaarGetBusinesses(CommunityIdentifier cid) {
    Log.d('_bazaarGetBusinesses: cid = $cid', _targetLogger);
    return webApi.encointer.bazaarGetBusinesses(cid);
  }

  Future<Either<Businesses, EwHttpException>> _getBusinesses(String ipfsUrlHash) {
    Log.d('_getBusinesses: ipfsUrlHash = $ipfsUrlHash', _targetLogger);
    return webApi.encointer.getBusinesseses(ipfsUrlHash);
  }

  @action
  Future<void> getBusinesses(CommunityIdentifier cid) async {
    fetchStatus = FetchStatus.loading;
    Log.d('getBusinesses: before update businesses = $businesses', _targetLogger);

    final accountBusinessTuples = await _bazaarGetBusinesses(cid);

    await _getBusinessesLogosAndUpdate(accountBusinessTuples);

    Log.d('getBusinesses: after update businesses = $businesses', _targetLogger);

    _update();
  }

  void _update() {
    if (sortedBusinesses.isEmpty) {
      fetchStatus = FetchStatus.noData;
    } else {
      fetchStatus = FetchStatus.success;
    }
  }

  void _sortByStatus() {
    sortedBusinesses.sort((a, b) {
      if (a.status == Status.highlight && b.status == Status.recently) return -1;
      if (a.status == Status.recently && b.status == Status.highlight) return 1;
      if (a.status == null && b.status == Status.highlight) return 1;
      if (a.status == Status.highlight && b.status == null) return -1;
      return 0;
    });
  }

  Future<void> _getBusinessesLogosAndUpdate(List<AccountBusinessTuple> accountBusinessTuples) async {
    Log.d('_getBusinessesLogosAndUpdate: accountBusinessTuples = $accountBusinessTuples', _targetLogger);

    if (accountBusinessTuples.isNotEmpty) {
      await Future.forEach<AccountBusinessTuple>(accountBusinessTuples, (element) async {
        if (element.businessData != null && element.businessData!.url.isNotNullOrEmpty) {
          Log.d(
            '_getBusinessesLogosAndUpdate: accountBusinessTuple.businessData!.url! = ${element.businessData!.url!}',
            _targetLogger,
          );
          final response = await _getBusinesses(element.businessData!.url!);

          Log.d('_getBusinesses: response = $response', _targetLogger);

          response.fold(
            (l) => error = l.failureType.name,
            (r) {
              r.controller = element.controller;
              Log.d('_getBusinesses: right = ${r.toJson()}', _targetLogger);
              businesses.add(r);
            },
          );
        }
      });
    }

    sortedBusinesses.addAll(businesses);
  }

  @action
  void filterBusinessesByCategory({required Category category}) {
    if (category == Category.all) {
      sortedBusinesses = <Businesses>[];
      sortedBusinesses.addAll(businesses);
    } else {
      sortedBusinesses = <Businesses>[];
      sortedBusinesses
        ..addAll(businesses)
        ..removeWhere((element) => element.category != category);
    }

    _sortByStatus();
    _update();
  }

  ///TOOD(Azamat): Need to fix the method
  // ignore: unused_element
  Future<void> _getBusinessesPhotos() async {
    await Future.forEach<Businesses>(businesses, (element) async {
      if (element.photos.isNotNullOrEmpty) {
        Log.d('_getBusinessesPhotos: element.photos = ${element.photos}', _targetLogger);
        final photosReponse = await webApi.encointer.getBusinessesPhotos(element.photos!);

        photosReponse.fold(
          (l) => error = l.failureType.name,
          (r) {
            Log.d('_getBusinessesPhotos: right = $r', _targetLogger);
          },
        );
      }
    });
  }
}
