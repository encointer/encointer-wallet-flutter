import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/models/bazaar/account_business_tuple.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:ew_log/ew_log.dart';
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

  /// Controllers for which the current account is a proxy delegate.
  @observable
  Set<String> delegateOfControllers = {};

  Future<List<AccountBusinessTuple>> _bazaarGetBusinesses(CommunityIdentifier cid) {
    Log.d('_bazaarGetBusinesses: cid = $cid', _targetLogger);
    return webApi.encointer.bazaarGetBusinesses(cid);
  }

  Future<IpfsBusiness> _getBusinesses(String ipfsCid) {
    Log.d('[getBusinesses]: ipfsCid = $ipfsCid', _targetLogger);
    return webApi.ipfsApi.getIpfsBusiness(ipfsCid);
  }

  @action
  Future<void> getBusinesses(CommunityIdentifier cid, String currentAddress) async {
    fetchStatus = FetchStatus.loading;
    businesses = <IpfsBusiness>[];
    sortedBusinesses = <IpfsBusiness>[];
    Log.d('getBusinesses: before update businesses = $businesses', _targetLogger);

    final accountBusinessTuples = await _bazaarGetBusinesses(cid);
    Log.d('getBusinesses: RPC returned ${accountBusinessTuples.length} entries for cid=$cid', _targetLogger);

    // Check delegate status before IPFS fetches — controllers are available
    // from chain data. This ensures delegateOfControllers is populated before
    // business cards render (fixes edit-button flake).
    final controllers = accountBusinessTuples.map((t) => t.controller).toSet();
    await _checkDelegateStatus(controllers, currentAddress);

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

    if (accountBusinessTuples.isEmpty) return;

    await Future.wait(
      accountBusinessTuples.where((e) => e.businessData.url.isNotNullOrEmpty).map((element) async {
        try {
          final business = await _getBusinesses(element.businessData.url);
          Log.d('[updateBusinesses]: response = $business', _targetLogger);
          business.controller = element.controller;
          Log.d('updateBusinesses: right = ${business.toJson()}', _targetLogger);
          businesses.add(business);
          sortedBusinesses.add(business);
          if (fetchStatus == FetchStatus.loading) {
            fetchStatus = FetchStatus.success;
          }
        } catch (e) {
          error = e.toString();
          Log.d('[updateBusinesses]: error = $e', _targetLogger);
        }
      }),
    );
  }

  Future<void> _checkDelegateStatus(Set<String> controllers, String currentAddress) async {
    if (currentAddress.isEmpty || controllers.isEmpty) {
      delegateOfControllers = {};
      return;
    }

    final result = <String>{};

    final nonOwned = controllers.where((c) => !AddressUtils.areEqual(c, currentAddress)).toList();
    if (nonOwned.isEmpty) {
      delegateOfControllers = result;
      return;
    }

    try {
      final pubKeys = nonOwned.map((c) => AddressUtils.addressToPubKey(c).toList()).toList();
      final multiProxies = await Future.wait(pubKeys.map(webApi.encointer.getProxyAccounts));

      for (var i = 0; i < nonOwned.length; i++) {
        if (multiProxies[i].any((p) => AddressUtils.isSamePubKey(currentAddress, p.delegate))) {
          result.add(nonOwned[i]);
        }
      }
    } catch (e) {
      Log.e('Error checking delegate status: $e', _targetLogger);
    }

    delegateOfControllers = result;
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
