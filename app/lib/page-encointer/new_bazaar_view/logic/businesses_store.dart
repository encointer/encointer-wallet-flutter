import 'package:mobx/mobx.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';

part 'businesses_store.g.dart';

// ignore: library_private_types_in_public_api
class BusinessesStore = _BusinessesStoreBase with _$BusinessesStore;

abstract class _BusinessesStoreBase with Store {
  @observable
  List<Businesses>? businesses;

  @action
  Future<void> getBusinesses() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final data = businessesMockData['businesses'];
    businesses = data?.map(Businesses.fromJson).toList();
  }
}
