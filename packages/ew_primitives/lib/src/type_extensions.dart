import 'package:ew_polkadart/encointer_types.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/substrate_fixed/fixed_i128.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';

abstract class LocationFactory {
  static Location fromDouble({
    required double lat,
    required double lon,
  }) {
    return Location(
      lat: FixedI128(bits: u64F64Util.toFixed(lat)),
      lon: FixedI128(bits: u64F64Util.toFixed(lat)),
    );
  }
}
