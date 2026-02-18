import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() => integrationDriver(
      responseDataCallback: (data) async {
        if (data != null && data.containsKey('qr_payload')) {
          await File('build/alice_qr_payload.b64').writeAsString(data['qr_payload']! as String);
        }
      },
    );
