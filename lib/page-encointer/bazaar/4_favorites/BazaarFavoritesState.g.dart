// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BazaarFavoritesState.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BazaarFavoritesState on _BazaarFavoritesState, Store {
  final _$bazaarItemsAtom = Atom(name: '_BazaarFavoritesState.bazaarItems');

  @override
  ObservableList<BazaarItemData> get bazaarItems {
    _$bazaarItemsAtom.reportRead();
    return super.bazaarItems;
  }

  @override
  set bazaarItems(ObservableList<BazaarItemData> value) {
    _$bazaarItemsAtom.reportWrite(value, super.bazaarItems, () {
      super.bazaarItems = value;
    });
  }

  @override
  String toString() {
    return '''
bazaarItems: ${bazaarItems}
    ''';
  }
}
