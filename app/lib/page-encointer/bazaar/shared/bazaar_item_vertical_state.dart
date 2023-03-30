import 'package:mobx/mobx.dart';

part 'bazaar_item_vertical_state.g.dart';

// ignore: library_private_types_in_public_api
class BazaarItemVerticalState = _BazaarItemVerticalState with _$BazaarItemVerticalState;

abstract class _BazaarItemVerticalState with Store {
  @observable
  bool liked = false;

  @action
  void toggleLiked() {
    liked = !liked;
  }
}
