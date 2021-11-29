import 'package:mobx/mobx.dart';

import '../shared/data_model/model/BazaarItemData.dart';

part 'BazaarFavoritesState.g.dart';

class BazaarFavoritesState = _BazaarFavoritesState with _$BazaarFavoritesState;

abstract class _BazaarFavoritesState with Store {
  @observable
  ObservableList<BazaarItemData> bazaarItems;
}
