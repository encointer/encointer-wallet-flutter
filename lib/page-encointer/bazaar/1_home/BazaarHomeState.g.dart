// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BazaarHomeState.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BazaarHomeState on _BazaarHomeState, Store {
  final _$newInBazaarAtom = Atom(name: '_BazaarHomeState.newInBazaar');

  @override
  ObservableList<BazaarItemData> get newInBazaar {
    _$newInBazaarAtom.reportRead();
    return super.newInBazaar;
  }

  @override
  set newInBazaar(ObservableList<BazaarItemData> value) {
    _$newInBazaarAtom.reportWrite(value, super.newInBazaar, () {
      super.newInBazaar = value;
    });
  }

  final _$businessesInVicinityAtom = Atom(name: '_BazaarHomeState.businessesInVicinity');

  @override
  ObservableList<BazaarBusinessData> get businessesInVicinity {
    _$businessesInVicinityAtom.reportRead();
    return super.businessesInVicinity;
  }

  @override
  set businessesInVicinity(ObservableList<BazaarBusinessData> value) {
    _$businessesInVicinityAtom.reportWrite(value, super.businessesInVicinity, () {
      super.businessesInVicinity = value;
    });
  }

  final _$lastVisitedAtom = Atom(name: '_BazaarHomeState.lastVisited');

  @override
  ObservableList<BazaarItemData> get lastVisited {
    _$lastVisitedAtom.reportRead();
    return super.lastVisited;
  }

  @override
  set lastVisited(ObservableList<BazaarItemData> value) {
    _$lastVisitedAtom.reportWrite(value, super.lastVisited, () {
      super.lastVisited = value;
    });
  }

  @override
  String toString() {
    return '''
newInBazaar: ${newInBazaar},
businessesInVicinity: ${businessesInVicinity},
lastVisited: ${lastVisited}
    ''';
  }
}
