// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<BiometricAuthState?>? _$getBiometricAuthStateComputed;

  @override
  BiometricAuthState? get getBiometricAuthState =>
      (_$getBiometricAuthStateComputed ??= Computed<BiometricAuthState?>(() => super.getBiometricAuthState,
              name: '_LoginStoreBase.getBiometricAuthState'))
          .value;

  late final _$biometricAuthStateAtom = Atom(name: '_LoginStoreBase.biometricAuthState', context: context);

  @override
  BiometricAuthState? get biometricAuthState {
    _$biometricAuthStateAtom.reportRead();
    return super.biometricAuthState;
  }

  @override
  set biometricAuthState(BiometricAuthState? value) {
    _$biometricAuthStateAtom.reportWrite(value, super.biometricAuthState, () {
      super.biometricAuthState = value;
    });
  }

  late final _$loadingAtom = Atom(name: '_LoginStoreBase.loading', context: context);

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

  late final _$setBiometricAuthStateAsyncAction =
      AsyncAction('_LoginStoreBase.setBiometricAuthState', context: context);

  @override
  Future<void> setBiometricAuthState(BiometricAuthState value) {
    return _$setBiometricAuthStateAsyncAction.run(() => super.setBiometricAuthState(value));
  }

  @override
  String toString() {
    return '''
biometricAuthState: ${biometricAuthState},
loading: ${loading},
getBiometricAuthState: ${getBiometricAuthState}
    ''';
  }
}
