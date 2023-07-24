// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keep_your_phrase_safe_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$KeppYourPhraseSaveViewStore on _KeppYourPhraseSaveViewStoreBase, Store {
  late final _$loadingAtom = Atom(name: '_KeppYourPhraseSaveViewStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$seedAtom = Atom(name: '_KeppYourPhraseSaveViewStoreBase.seed', context: context);

  @override
  String? get seed {
    _$seedAtom.reportRead();
    return super.seed;
  }

  @override
  set seed(String? value) {
    _$seedAtom.reportWrite(value, super.seed, () {
      super.seed = value;
    });
  }

  late final _$errorAtom = Atom(name: '_KeppYourPhraseSaveViewStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$isCheckedAtom = Atom(name: '_KeppYourPhraseSaveViewStoreBase.isChecked', context: context);

  @override
  bool get isChecked {
    _$isCheckedAtom.reportRead();
    return super.isChecked;
  }

  @override
  set isChecked(bool value) {
    _$isCheckedAtom.reportWrite(value, super.isChecked, () {
      super.isChecked = value;
    });
  }

  @override
  String toString() {
    return '''
loading: ${loading},
seed: ${seed},
error: ${error},
isChecked: ${isChecked}
    ''';
  }
}
