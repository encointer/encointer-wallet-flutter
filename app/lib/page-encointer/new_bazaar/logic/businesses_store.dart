import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';

part 'businesses_store.g.dart';

// ignore: library_private_types_in_public_api
class BusinessesStore = _BusinessesStoreBase with _$BusinessesStore;

abstract class _BusinessesStoreBase with Store {
  @observable
  List<Businesses>? businesses;

  @observable
  FetchStatus fetchStatus = FetchStatus.loading;

  @action
  Future<void> getBusinesses({Category category = Category.all}) async {
    fetchStatus = FetchStatus.loading;
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = businessesMockData['businesses'];
    final items = data!.map(Businesses.fromJson).toList();
    if (category != Category.all) items.removeWhere((element) => element.category != category);
    items.sort((a, b) {
      if (a.status == Status.highlight && b.status == Status.neuBeiLeu) return -1;
      if (a.status == Status.neuBeiLeu && b.status == Status.highlight) return 1;
      if (a.status == null && b.status == Status.highlight) return 1;
      if (a.status == Status.highlight && b.status == null) return -1;
      return 0;
    });
    businesses = items;
    fetchStatus = FetchStatus.success;
  }
}
