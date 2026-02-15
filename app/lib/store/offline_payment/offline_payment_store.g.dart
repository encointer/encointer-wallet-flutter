// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_payment_store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfflinePaymentRecord _$OfflinePaymentRecordFromJson(
        Map<String, dynamic> json) =>
    OfflinePaymentRecord(
      proofBase64: json['proofBase64'] as String,
      senderAddress: json['senderAddress'] as String,
      recipientAddress: json['recipientAddress'] as String,
      cidFmt: json['cidFmt'] as String,
      amount: (json['amount'] as num).toDouble(),
      nullifierHex: json['nullifierHex'] as String,
      commitmentHex: json['commitmentHex'] as String,
      role: $enumDecode(_$OfflinePaymentRoleEnumMap, json['role']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status:
          $enumDecodeNullable(_$OfflinePaymentStatusEnumMap, json['status']) ??
              OfflinePaymentStatus.pending,
    );

Map<String, dynamic> _$OfflinePaymentRecordToJson(
        OfflinePaymentRecord instance) =>
    <String, dynamic>{
      'proofBase64': instance.proofBase64,
      'senderAddress': instance.senderAddress,
      'recipientAddress': instance.recipientAddress,
      'cidFmt': instance.cidFmt,
      'amount': instance.amount,
      'nullifierHex': instance.nullifierHex,
      'commitmentHex': instance.commitmentHex,
      'role': _$OfflinePaymentRoleEnumMap[instance.role]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$OfflinePaymentStatusEnumMap[instance.status]!,
    };

const _$OfflinePaymentRoleEnumMap = {
  OfflinePaymentRole.sender: 'sender',
  OfflinePaymentRole.receiver: 'receiver',
};

const _$OfflinePaymentStatusEnumMap = {
  OfflinePaymentStatus.pending: 'pending',
  OfflinePaymentStatus.submitted: 'submitted',
  OfflinePaymentStatus.confirmed: 'confirmed',
  OfflinePaymentStatus.failed: 'failed',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OfflinePaymentStore on _OfflinePaymentStore, Store {
  Computed<List<OfflinePaymentRecord>>? _$pendingPaymentsComputed;

  @override
  List<OfflinePaymentRecord> get pendingPayments =>
      (_$pendingPaymentsComputed ??= Computed<List<OfflinePaymentRecord>>(
              () => super.pendingPayments,
              name: '_OfflinePaymentStore.pendingPayments'))
          .value;
  Computed<List<OfflinePaymentRecord>>? _$unsettledPaymentsComputed;

  @override
  List<OfflinePaymentRecord> get unsettledPayments =>
      (_$unsettledPaymentsComputed ??= Computed<List<OfflinePaymentRecord>>(
              () => super.unsettledPayments,
              name: '_OfflinePaymentStore.unsettledPayments'))
          .value;

  late final _$paymentsAtom =
      Atom(name: '_OfflinePaymentStore.payments', context: context);

  @override
  ObservableList<OfflinePaymentRecord> get payments {
    _$paymentsAtom.reportRead();
    return super.payments;
  }

  @override
  set payments(ObservableList<OfflinePaymentRecord> value) {
    _$paymentsAtom.reportWrite(value, super.payments, () {
      super.payments = value;
    });
  }

  late final _$addPaymentAsyncAction =
      AsyncAction('_OfflinePaymentStore.addPayment', context: context);

  @override
  Future<void> addPayment(OfflinePaymentRecord record) {
    return _$addPaymentAsyncAction.run(() => super.addPayment(record));
  }

  late final _$updateStatusAsyncAction =
      AsyncAction('_OfflinePaymentStore.updateStatus', context: context);

  @override
  Future<void> updateStatus(String nullifierHex, OfflinePaymentStatus status) {
    return _$updateStatusAsyncAction
        .run(() => super.updateStatus(nullifierHex, status));
  }

  late final _$loadCacheAsyncAction =
      AsyncAction('_OfflinePaymentStore.loadCache', context: context);

  @override
  Future<void> loadCache() {
    return _$loadCacheAsyncAction.run(() => super.loadCache());
  }

  @override
  String toString() {
    return '''
payments: ${payments},
pendingPayments: ${pendingPayments},
unsettledPayments: ${unsettledPayments}
    ''';
  }
}
