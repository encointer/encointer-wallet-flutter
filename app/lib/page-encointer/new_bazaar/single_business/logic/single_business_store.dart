import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

part 'single_business_store.g.dart';

// ignore: library_private_types_in_public_api
class SingleBusinessStore = _SingleBusinessStoreBase with _$SingleBusinessStore;

abstract class _SingleBusinessStoreBase with Store {
  @observable
  List<SingleBusiness>? singleBusiness;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getSingleBusiness() async {
    fetchStatus = FetchStatus.loading;
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = singleBusinessMockData['single_business'];
    final items = data!.map(SingleBusiness.fromJson).toList();
    singleBusiness = items;
    fetchStatus = FetchStatus.success;
  }
}
