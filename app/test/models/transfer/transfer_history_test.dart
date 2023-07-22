import 'package:encointer_wallet/models/transfer/transfer_history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final list = [
    {
      'blockNumber': '2596427',
      'timestamp': '1680176568449',
      'counterParty': 'CwrkHS59rd9UDw2T9oykwzX3LrnKUoctS8LFffe2R2W56ia',
      'amount': 0.8571145999707728
    },
    {
      'blockNumber': '2596434',
      'timestamp': '1680176658628',
      'counterParty': 'CwrkHS59rd9UDw2T9oykwzX3LrnKUoctS8LFffe2R2W56ia',
      'amount': -0.82
    },
    {
      'blockNumber': '3180008',
      'timestamp': '1687435062444',
      'counterParty': 'DyeMQe8B5b2PpCUirfaheKEEsk1nJCpNbuvykQBDbrK5TWt',
      'amount': 2
    }
  ];
  final incomingTxs = [
    {
      'blockNumber': '2596427',
      'timestamp': '1680176568449',
      'counterParty': 'CwrkHS59rd9UDw2T9oykwzX3LrnKUoctS8LFffe2R2W56ia',
      'amount': 0.8571145999707728
    },
  ];
  final outgoingTxs = [
    {
      'blockNumber': '2596427',
      'timestamp': '1680176568449',
      'counterParty': 'CwrkHS59rd9UDw2T9oykwzX3LrnKUoctS8LFffe2R2W56ia',
      'amount': -0.82
    },
  ];

  group('Transaction Model', () {
    test('fromJson() should return a SingleBusiness object', () {
      for (final element in list) {
        final tx = Transaction.fromJson(element);
        expect(tx, isA<Transaction>());
      }
    });

    test('fromJson() should return `amount` equal to 0.8571', () {
      for (final element in incomingTxs) {
        final tx = Transaction.fromJson(element);
        expect(tx.amount, equals(0.8571));
      }
    });

    test('fromJson() should return correct transaction type', () {
      for (final element in outgoingTxs) {
        final tx = Transaction.fromJson(element);
        expect(tx.type, equals(TransactionType.outgoing));
      }

      for (final element in incomingTxs) {
        final tx = Transaction.fromJson(element);
        expect(tx.type, equals(TransactionType.incoming));
      }
    });

    test('fromJson() should return `DateTime` equal to  DateTime.fromMillisecondsSinceEpoch(int.parse(1680176568449))',
        () {
      for (final element in outgoingTxs) {
        final tx = Transaction.fromJson(element);
        expect(tx.dateTime, equals(DateTime.fromMillisecondsSinceEpoch(int.parse('1680176568449'))));
      }
    });
  });
}
