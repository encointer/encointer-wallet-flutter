import 'package:encointer_wallet/service/substrate_api/encointer/encointer_api.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/test_tags.dart';

void main() {
  group('encointerDartApi', () {
    test('gets aggregated account data', () async {
      final photo = await getIpfsPhoto(EwHttp(), 'Qmb3mJYRKI6nwf3MXULPRHAQHAfkGs38UJ7voXLPN9gngqa');

      // ignore: avoid_print
      print('data: $photo');
    }, tags: productionE2E);
  });
}
