import 'package:mobx/mobx.dart';

import 'BusinessFormState.dart';

part 'BazaarMyBusinessesState.g.dart';

class BazaarMyBusinessesState = _BazaarMyBusinessesState with _$BazaarMyBusinessesState;

abstract class _BazaarMyBusinessesState with Store {
  final businessFormState = BusinessFormState();
}
