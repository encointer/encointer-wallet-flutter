// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BazaarOfferingsState.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BazaarOfferingsState on _BazaarOfferingsState, Store {
  final _$categoriesAtom = Atom(name: '_BazaarOfferingsState.categories');

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

  final _$offeringsAtom = Atom(name: '_BazaarOfferingsState.offerings');

  @override
  ObservableList<BazaarOfferingData> get offerings {
    _$offeringsAtom.reportRead();
    return super.offerings;
  }

  @override
  set offerings(ObservableList<BazaarOfferingData> value) {
    _$offeringsAtom.reportWrite(value, super.offerings, () {
      super.offerings = value;
    });
  }

  @override
  String toString() {
    return '''
categories: ${categories},
offerings: ${offerings}
    ''';
  }
}
