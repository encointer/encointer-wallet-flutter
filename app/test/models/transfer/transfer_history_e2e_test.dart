import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/transfer/transfer_history.dart';
import 'package:ew_http/ew_http.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_tags.dart';
import '../../utils/test_utils.dart';

void main() {
  test(
    'tx-history API returns valid transactions for Alice on LEU Kusama',
    () async {
      final ewHttp = EwHttp();
      final kusamaAlice = AddressUtils.transformPrefix(aliceAddress, 2);
      final url = getTransactionHistoryUrl('u0qj944rhWE', kusamaAlice);

      final result = await ewHttp.getTypeList<Transaction>(url, fromJson: Transaction.fromJson);

      result.fold(
        (error) => fail('tx-history API returned error: $error'),
        (transactions) {
          expect(transactions, isA<List<Transaction>>());
          expect(transactions, isNotEmpty);
        },
      );
    },
    timeout: const Timeout(Duration(seconds: 15)),
    tags: productionE2E,
  );
}
