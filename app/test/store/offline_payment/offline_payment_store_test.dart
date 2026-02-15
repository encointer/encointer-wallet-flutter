import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';

void main() {
  group('OfflinePaymentRecord', () {
    final testRecord = OfflinePaymentRecord(
      proofBase64: 'dGVzdA==',
      senderAddress: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
      recipientAddress: '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty',
      cidFmt: 'sqm1v79dF6b',
      amount: 1.5,
      nullifierHex: 'ab' * 32,
      commitmentHex: 'cd' * 32,
      role: OfflinePaymentRole.sender,
      createdAt: DateTime.utc(2025, 1, 15, 10, 30),
    );

    test('toJson serializes all fields', () {
      final json = testRecord.toJson();

      expect(json['proofBase64'], 'dGVzdA==');
      expect(json['senderAddress'], '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
      expect(json['recipientAddress'], '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty');
      expect(json['cidFmt'], 'sqm1v79dF6b');
      expect(json['amount'], 1.5);
      expect(json['nullifierHex'], 'ab' * 32);
      expect(json['commitmentHex'], 'cd' * 32);
      expect(json['role'], 'sender');
      expect(json['status'], 'pending');
      expect(json['createdAt'], '2025-01-15T10:30:00.000Z');
    });

    test('fromJson deserializes all fields', () {
      final json = testRecord.toJson();
      final deserialized = OfflinePaymentRecord.fromJson(json);

      expect(deserialized.proofBase64, testRecord.proofBase64);
      expect(deserialized.senderAddress, testRecord.senderAddress);
      expect(deserialized.recipientAddress, testRecord.recipientAddress);
      expect(deserialized.cidFmt, testRecord.cidFmt);
      expect(deserialized.amount, testRecord.amount);
      expect(deserialized.nullifierHex, testRecord.nullifierHex);
      expect(deserialized.commitmentHex, testRecord.commitmentHex);
      expect(deserialized.role, testRecord.role);
      expect(deserialized.status, testRecord.status);
      expect(deserialized.createdAt, testRecord.createdAt);
    });

    test('JSON round-trip preserves all statuses', () {
      for (final status in OfflinePaymentStatus.values) {
        final record = OfflinePaymentRecord(
          proofBase64: 'test',
          senderAddress: 'sender',
          recipientAddress: 'recipient',
          cidFmt: 'cid',
          amount: 1.0,
          nullifierHex: 'nullifier',
          commitmentHex: 'commitment',
          role: OfflinePaymentRole.receiver,
          createdAt: DateTime.utc(2025, 1, 1),
          status: status,
        );

        final deserialized = OfflinePaymentRecord.fromJson(record.toJson());
        expect(deserialized.status, status);
      }
    });

    test('JSON round-trip preserves both roles', () {
      for (final role in OfflinePaymentRole.values) {
        final record = OfflinePaymentRecord(
          proofBase64: 'test',
          senderAddress: 'sender',
          recipientAddress: 'recipient',
          cidFmt: 'cid',
          amount: 1.0,
          nullifierHex: 'nullifier',
          commitmentHex: 'commitment',
          role: role,
          createdAt: DateTime.utc(2025, 1, 1),
        );

        final deserialized = OfflinePaymentRecord.fromJson(record.toJson());
        expect(deserialized.role, role);
      }
    });
  });
}
