// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectivityStore on _ConnectivityStoreBase, Store {
  Computed<bool>? _$isConnectedToNetworkComputed;

  @override
  bool get isConnectedToNetwork => (_$isConnectedToNetworkComputed ??=
          Computed<bool>(() => super.isConnectedToNetwork, name: '_ConnectivityStoreBase.isConnectedToNetwork'))
      .value;

  late final _$connectionStateAtom = Atom(name: '_ConnectivityStoreBase.connectionState', context: context);

  @override
  ConnectivityResult get connectionState {
    _$connectionStateAtom.reportRead();
    return super.connectionState;
  }

  @override
  set connectionState(ConnectivityResult value) {
    _$connectionStateAtom.reportWrite(value, super.connectionState, () {
      super.connectionState = value;
    });
  }

  late final _$_ConnectivityStoreBaseActionController =
      ActionController(name: '_ConnectivityStoreBase', context: context);

  @override
  void listen() {
    final _$actionInfo = _$_ConnectivityStoreBaseActionController.startAction(name: '_ConnectivityStoreBase.listen');
    try {
      return super.listen();
    } finally {
      _$_ConnectivityStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
connectionState: ${connectionState},
isConnectedToNetwork: ${isConnectedToNetwork}
    ''';
  }
}
