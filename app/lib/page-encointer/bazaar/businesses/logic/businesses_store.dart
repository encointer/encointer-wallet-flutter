import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'businesses_store.g.dart';

const _targetLogger = 'BusinessesStore';

// ignore: library_private_types_in_public_api
class BusinessesStore = _BusinessesStoreBase with _$BusinessesStore;

abstract class _BusinessesStoreBase with Store {
  @observable
  List<IpfsBusiness> businesses = <IpfsBusiness>[];

  @observable
  List<IpfsBusiness> sortedBusinesses = <IpfsBusiness>[];

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @observable
  String? error;

  Future<List<AccountBusinessTuple>> _bazaarGetBusinesses(CommunityIdentifier cid) {
    Log.d('_bazaarGetBusinesses: cid = $cid', _targetLogger);
    return webApi.encointer.bazaarGetBusinesses(cid);
  }

  Future<IpfsBusiness> _getBusinesses(String ipfsCid) {
    Log.d('[getBusinesses]: ipfsCid = $ipfsCid', _targetLogger);
    return webApi.ipfsApi.getIpfsBusiness(ipfsCid);
  }

  @action
  Future<void> getBusinesses(CommunityIdentifier cid) async {
    fetchStatus = FetchStatus.loading;
    Log.d('getBusinesses: before update businesses = $businesses', _targetLogger);

    final accountBusinessTuples = await _bazaarGetBusinesses(cid);

    await _updateBusinesses(accountBusinessTuples);

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

  Future<void> _updateBusinesses(List<AccountBusinessTuple> accountBusinessTuples) async {
    Log.d('[updateBusinesses]: accountBusinessTuples = $accountBusinessTuples', _targetLogger);

    if (accountBusinessTuples.isNotEmpty) {
      await Future.forEach<AccountBusinessTuple>(accountBusinessTuples, (element) async {
        if (element.businessData.url.isNotNullOrEmpty) {
          Log.d(
            '[updateBusinesses]: accountBusinessTuple.businessData!.url! = ${element.businessData.url}',
            _targetLogger,
          );

          try {
            final business = await _getBusinesses(element.businessData.url);
            Log.d('[updateBusinesses]: response = $business', _targetLogger);
            business.controller = element.controller;
            Log.d('updateBusinesses: right = ${business.toJson()}', _targetLogger);
            businesses.add(business);
          } catch (e) {
            error = e.toString();
            Log.d('[updateBusinesses]: error = $e', _targetLogger);
          }
        }
      });
    }

    sortedBusinesses.addAll(businesses);
  }

  @action
  void filterBusinessesByCategory({required Category category}) {
    if (category == Category.all) {
      sortedBusinesses = <IpfsBusiness>[];
      sortedBusinesses.addAll(businesses);
    } else {
      sortedBusinesses = <IpfsBusiness>[];
      sortedBusinesses
        ..addAll(businesses)
        ..removeWhere((element) => element.category != category);
    }

    _sortByStatus();
    _update();
  }
}
