// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointerAccountStore.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerAccountStore _$EncointerAccountStoreFromJson(Map<String, dynamic> json) {
  return EncointerAccountStore(
    json['network'] as String,
    json['address'] as String,
  )..balanceEntries = json['balanceEntries'] != null
      ? ObservableMap<String, BalanceEntry>.of((json['balanceEntries'] as Map<String, dynamic>).map(
          (k, e) => MapEntry(k, e == null ? null : BalanceEntry.fromJson(e as Map<String, dynamic>)),
        ))
      : null;
}

Map<String, dynamic> _$EncointerAccountStoreToJson(EncointerAccountStore instance) => <String, dynamic>{
      'network': instance.network,
      'address': instance.address,
      'balanceEntries': instance.balanceEntries?.map((k, e) => MapEntry(k, e?.toJson())),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EncointerAccountStore on _EncointerAccountStore, Store {
  final _$balanceEntriesAtom = Atom(name: '_EncointerAccountStore.balanceEntries');

  @override
  ObservableMap<String, BalanceEntry> get balanceEntries {
    _$balanceEntriesAtom.reportRead();
    return super.balanceEntries;
  }

  @override
  set balanceEntries(ObservableMap<String, BalanceEntry> value) {
    _$balanceEntriesAtom.reportWrite(value, super.balanceEntries, () {
      super.balanceEntries = value;
    });
  }

  final _$_EncointerAccountStoreActionController = ActionController(name: '_EncointerAccountStore');

  @override
  void addBalanceEntry(CommunityIdentifier cid, BalanceEntry balanceEntry) {
    final _$actionInfo =
        _$_EncointerAccountStoreActionController.startAction(name: '_EncointerAccountStore.addBalanceEntry');
    try {
      return super.addBalanceEntry(cid, balanceEntry);
    } finally {
      _$_EncointerAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
balanceEntries: ${balanceEntries}
    ''';
  }
}
