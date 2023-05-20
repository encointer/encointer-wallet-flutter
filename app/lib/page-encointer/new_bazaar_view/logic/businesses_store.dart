import 'package:encointer_wallet/page-encointer/new_bazaar_view/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:mobx/mobx.dart';
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
  Future<void> getBusinesses({Category category = Category.alle}) async {
    fetchStatus = FetchStatus.loading;
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = businessesMockData['businesses'];
    final items = data!.map(Businesses.fromJson).toList();
    if (category != Category.alle) items.removeWhere((element) => element.category != category.name);
    businesses = items;
    fetchStatus = FetchStatus.success;
  }
}
