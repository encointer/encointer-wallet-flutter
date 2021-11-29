import 'package:mobx/mobx.dart';

import '../../bazaar/shared/data_model/model/BazaarItemData.dart';
import 'BazaarSearch/BazaarSearchState.dart';

part 'BazaarHomeState.g.dart';

class BazaarHomeState = _BazaarHomeState with _$BazaarHomeState;

abstract class _BazaarHomeState with Store {
  final bazaarSearchState = BazaarSearchState();

  @observable
  ObservableList<BazaarItemData> newInBazaar;

  @observable
  ObservableList<BazaarBusinessData> businessesInVicinity;

  @observable
  ObservableList<BazaarItemData> lastVisited;
}
