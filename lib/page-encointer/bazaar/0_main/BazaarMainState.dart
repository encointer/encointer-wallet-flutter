import 'package:mobx/mobx.dart';

import '../1_home/BazaarHomeState.dart';
import '../2_offerings/BazaarOfferingsState.dart';
import '../3_businesses/BazaarBusinessesState.dart';
import '../4_favorites/BazaarFavoritesState.dart';
import '../menu/1_my_offerings/BazaarMyOfferingsState.dart';
import '../menu/2_my_businesses/BazaarMyBusinessesState.dart';

part 'BazaarMainState.g.dart';

class BazaarMainState = _BazaarMainState with _$BazaarMainState;

abstract class _BazaarMainState with Store {
  final bazaarHomeState = BazaarHomeState();
  final bazaarOfferingsState = BazaarOfferingsState();
  final bazaarBusinessesState = BazaarBusinessesState();
  final bazaarFavoritesState = BazaarFavoritesState();
  final bazaarMyOfferingsState = BazaarMyOfferingsState();
  final bazaarMyBusinessesState = BazaarMyBusinessesState();
}
