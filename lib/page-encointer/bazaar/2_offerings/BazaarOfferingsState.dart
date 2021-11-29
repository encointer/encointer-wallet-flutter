import 'package:mobx/mobx.dart';

import '../shared/data_model/model/BazaarItemData.dart';

part 'BazaarOfferingsState.g.dart';

class BazaarOfferingsState = _BazaarOfferingsState with _$BazaarOfferingsState;

abstract class _BazaarOfferingsState with Store {
  @observable
  ObservableList<Object> categories;

  @observable
  ObservableList<BazaarOfferingData> offerings;
}
