// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chain.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChainStore on _ChainStore, Store {
  final _$latestHeadAtom = Atom(name: '_ChainStore.latestHead');

  @override
  Header get latestHead {
    _$latestHeadAtom.reportRead();
    return super.latestHead;
  }

  @override
  set latestHead(Header value) {
    _$latestHeadAtom.reportWrite(value, super.latestHead, () {
      super.latestHead = value;
    });
  }

  @override
  String toString() {
    return '''
latestHead: ${latestHead}
    ''';
  }
}
