import 'dart:async';
import 'dart:typed_data';

import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show ExtrinsicStatus, Provider;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProvider extends Mock implements Provider {}

/// Subclass that returns a controlled stream instead of hitting the network.
class _TestAuthorApi extends EWAuthorApi<Provider> {
  _TestAuthorApi(this.controller) : super(MockProvider());

  final StreamController<ExtrinsicStatus> controller;

  @override
  Future<StreamSubscription<ExtrinsicStatus>> submitAndWatchExtrinsic(
    OpaqueExtrinsic extrinsic,
    dynamic Function(ExtrinsicStatus) onData,
  ) async {
    return controller.stream.listen(onData);
  }
}

void main() {
  final dummyExtrinsic = OpaqueExtrinsic(Uint8List.fromList([0, 1, 2, 3]));
  const shortTimeout = Duration(milliseconds: 100);

  group('submitAndWatchExtrinsicWithReport', () {
    test('throws on timeout when stream never emits inBlock/finalized', () async {
      final controller = StreamController<ExtrinsicStatus>();
      final api = _TestAuthorApi(controller);

      await expectLater(
        api.submitAndWatchExtrinsicWithReport(dummyExtrinsic, timeout: shortTimeout),
        throwsA(
          isA<Exception>().having((e) => e.toString(), 'message', contains('timed out')),
        ),
      );

      await controller.close();
    });

    test('throws when stream closes before finalization', () async {
      final controller = StreamController<ExtrinsicStatus>();
      final api = _TestAuthorApi(controller);

      final future = api.submitAndWatchExtrinsicWithReport(dummyExtrinsic, timeout: shortTimeout);

      // Close the stream without emitting inBlock/finalized.
      await controller.close();

      await expectLater(
        future,
        throwsA(
          isA<Exception>().having((e) => e.toString(), 'message', contains('closed before finalization')),
        ),
      );
    });

    test('throws when stream emits an error', () async {
      final controller = StreamController<ExtrinsicStatus>();
      final api = _TestAuthorApi(controller);

      final future = api.submitAndWatchExtrinsicWithReport(dummyExtrinsic, timeout: shortTimeout);

      controller.addError('WebSocket disconnected');

      await expectLater(
        future,
        throwsA(
          isA<Exception>().having((e) => e.toString(), 'message', contains('subscription error')),
        ),
      );

      await controller.close();
    });
  });
}
