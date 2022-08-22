import 'package:mobx/mobx.dart';
part 'bazaar_item_vertical_state.g.dart';

class BazaarItemVerticalState = _BazaarItemVerticalState with _$BazaarItemVerticalState;

abstract class _BazaarItemVerticalState with Store {
  @observable
  bool liked = false;

  @action
  void toggleLiked() {
    liked = !liked;
  }
}
