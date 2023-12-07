// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChainStore on _ChainStore, Store {
  Computed<Uint8List?>? _$latestHashComputed;

  @override
  Uint8List? get latestHash =>
      (_$latestHashComputed ??= Computed<Uint8List?>(() => super.latestHash, name: '_ChainStore.latestHash')).value;
  Computed<int?>? _$latestHeaderNumberComputed;

  @override
  int? get latestHeaderNumber => (_$latestHeaderNumberComputed ??=
          Computed<int?>(() => super.latestHeaderNumber, name: '_ChainStore.latestHeaderNumber'))
      .value;

  late final _$latestHeaderAtom = Atom(name: '_ChainStore.latestHeader', context: context);

  @override
  Header? get latestHeader {
    _$latestHeaderAtom.reportRead();
    return super.latestHeader;
  }

  @override
  set latestHeader(Header? value) {
    _$latestHeaderAtom.reportWrite(value, super.latestHeader, () {
      super.latestHeader = value;
    });
  }

  late final _$latestHashHexAtom = Atom(name: '_ChainStore.latestHashHex', context: context);

  @override
  String? get latestHashHex {
    _$latestHashHexAtom.reportRead();
    return super.latestHashHex;
  }

  @override
  set latestHashHex(String? value) {
    _$latestHashHexAtom.reportWrite(value, super.latestHashHex, () {
      super.latestHashHex = value;
    });
  }

  late final _$_ChainStoreActionController = ActionController(name: '_ChainStore', context: context);

  @override
  void setLatestHeaderHash(String latestHash) {
    final _$actionInfo = _$_ChainStoreActionController.startAction(name: '_ChainStore.setLatestHeaderHash');
    try {
      return super.setLatestHeaderHash(latestHash);
    } finally {
      _$_ChainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLatestHeader(Header latest) {
    final _$actionInfo = _$_ChainStoreActionController.startAction(name: '_ChainStore.setLatestHeader');
    try {
      return super.setLatestHeader(latest);
    } finally {
      _$_ChainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
latestHeader: ${latestHeader},
latestHashHex: ${latestHashHex},
latestHash: ${latestHash},
latestHeaderNumber: ${latestHeaderNumber}
    ''';
  }
}
