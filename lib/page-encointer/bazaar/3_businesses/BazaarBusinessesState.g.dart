// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BazaarBusinessesState.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BazaarBusinessesState on _BazaarBusinessesState, Store {
  final _$categoriesAtom = Atom(name: '_BazaarBusinessesState.categories');

  @override
  ObservableList<Object> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<Object> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  final _$businessesAtom = Atom(name: '_BazaarBusinessesState.businesses');

  @override
  ObservableList<BazaarBusinessData> get businesses {
    _$businessesAtom.reportRead();
    return super.businesses;
  }

  @override
  set businesses(ObservableList<BazaarBusinessData> value) {
    _$businessesAtom.reportWrite(value, super.businesses, () {
      super.businesses = value;
    });
  }

  @override
  String toString() {
    return '''
categories: ${categories},
businesses: ${businesses}
    ''';
  }
}
