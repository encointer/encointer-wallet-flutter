// ignore_for_file: no_leading_underscores_for_library_prefixes
import '../types/encointer_runtime/origin_caller.dart' as _i3;
import '../types/encointer_runtime/runtime_call.dart' as _i1;
import '../types/pallet_utility/pallet/call.dart' as _i2;
import '../types/sp_weights/weight_v2/weight.dart' as _i4;

class Txs {
  const Txs();

  /// See [`Pallet::batch`].
  _i1.RuntimeCall batch({required List<_i1.RuntimeCall> calls}) {
    final _call = _i2.Call.values.batch(calls: calls);
    return _i1.RuntimeCall.values.utility(_call);
  }

  /// See [`Pallet::as_derivative`].
  _i1.RuntimeCall asDerivative({
    required int index,
    required _i1.RuntimeCall call,
  }) {
    final _call = _i2.Call.values.asDerivative(
      index: index,
      call: call,
    );
    return _i1.RuntimeCall.values.utility(_call);
  }

  /// See [`Pallet::batch_all`].
  _i1.RuntimeCall batchAll({required List<_i1.RuntimeCall> calls}) {
    final _call = _i2.Call.values.batchAll(calls: calls);
    return _i1.RuntimeCall.values.utility(_call);
  }

  /// See [`Pallet::dispatch_as`].
  _i1.RuntimeCall dispatchAs({
    required _i3.OriginCaller asOrigin,
    required _i1.RuntimeCall call,
  }) {
    final _call = _i2.Call.values.dispatchAs(
      asOrigin: asOrigin,
      call: call,
    );
    return _i1.RuntimeCall.values.utility(_call);
  }

  /// See [`Pallet::force_batch`].
  _i1.RuntimeCall forceBatch({required List<_i1.RuntimeCall> calls}) {
    final _call = _i2.Call.values.forceBatch(calls: calls);
    return _i1.RuntimeCall.values.utility(_call);
  }

  /// See [`Pallet::with_weight`].
  _i1.RuntimeCall withWeight({
    required _i1.RuntimeCall call,
    required _i4.Weight weight,
  }) {
    final _call = _i2.Call.values.withWeight(
      call: call,
      weight: weight,
    );
    return _i1.RuntimeCall.values.utility(_call);
  }
}

class Constants {
  Constants();

  /// The limit on the number of batched calls.
  final int batchedCallsLimit = 10922;
}
