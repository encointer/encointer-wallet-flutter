import 'package:mobx/mobx.dart';
import '../shared/data_model/model/BazaarItemData.dart';

part 'BazaarBusinessesState.g.dart';

class BazaarBusinessesState = _BazaarBusinessesState with _$BazaarBusinessesState;

abstract class _BazaarBusinessesState with Store {
  @observable
  ObservableList<Object> categories;

  @observable
  ObservableList<BazaarBusinessData> businesses;
}
