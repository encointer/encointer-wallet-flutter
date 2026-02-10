import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:ew_log/ew_log.dart';

part 'offline_payment_store.g.dart';

enum OfflinePaymentRole { sender, receiver }

enum OfflinePaymentStatus { pending, submitted, confirmed, failed }

@JsonSerializable()
class OfflinePaymentRecord {
  OfflinePaymentRecord({
    required this.proofBase64,
    required this.senderAddress,
    required this.recipientAddress,
    required this.cidFmt,
    required this.amount,
    required this.nullifierHex,
    required this.commitmentHex,
    required this.role,
    required this.createdAt,
    this.status = OfflinePaymentStatus.pending,
  });

  factory OfflinePaymentRecord.fromJson(Map<String, dynamic> json) => _$OfflinePaymentRecordFromJson(json);
  Map<String, dynamic> toJson() => _$OfflinePaymentRecordToJson(this);

  final String proofBase64;
  final String senderAddress;
  final String recipientAddress;
  final String cidFmt;
  final double amount;
  final String nullifierHex;
  final String commitmentHex;
  final OfflinePaymentRole role;
  final DateTime createdAt;
  OfflinePaymentStatus status;
}

class OfflinePaymentStore extends _OfflinePaymentStore with _$OfflinePaymentStore {
  OfflinePaymentStore(super.rootStore);
}

abstract class _OfflinePaymentStore with Store {
  _OfflinePaymentStore(this.rootStore);

  final AppStore rootStore;

  static const String _cacheKey = 'offline-payments';

  @observable
  ObservableList<OfflinePaymentRecord> payments = ObservableList<OfflinePaymentRecord>();

  @computed
  List<OfflinePaymentRecord> get pendingPayments =>
      payments.where((p) => p.status == OfflinePaymentStatus.pending).toList();

  @action
  Future<void> addPayment(OfflinePaymentRecord record) async {
    payments.add(record);
    await _writeCache();
  }

  @action
  Future<void> updateStatus(String nullifierHex, OfflinePaymentStatus status) async {
    final index = payments.indexWhere((p) => p.nullifierHex == nullifierHex);
    if (index >= 0) {
      payments[index].status = status;
      // Trigger MobX reactivity by reassigning the element.
      payments[index] = payments[index];
      await _writeCache();
    }
  }

  @action
  Future<void> loadCache() async {
    try {
      final cached = await rootStore.loadObject(_cacheKey) as List<dynamic>?;
      if (cached != null) {
        payments = ObservableList.of(
          cached.map((e) => OfflinePaymentRecord.fromJson(e as Map<String, dynamic>)),
        );
        Log.d('Loaded ${payments.length} offline payments from cache', 'OfflinePaymentStore');
      }
    } catch (e, s) {
      Log.e('Failed to load offline payments cache: $e', 'OfflinePaymentStore', s);
    }
  }

  Future<void> _writeCache() {
    return rootStore.cacheObject(_cacheKey, payments.map((p) => p.toJson()).toList());
  }
}
