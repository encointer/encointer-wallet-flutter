import 'package:ew_keyring/ew_keyring.dart' show KeyringAccount, Sr25519KeyPair;
import 'package:ew_polkadart/encointer_types.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_core/crypto/account_id32.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/multi_signature.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/substrate_fixed/fixed_i128.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/substrate_fixed/fixed_u128.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/tuples.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';

extension KeyringAccountMultiAddressExt on KeyringAccount {
  MultiAddress multiAddress() {
    return MultiAddress.values.id(pubKey);
  }
}

extension KeyringAccountDataMultiAddressExt on Sr25519KeyPair {
  MultiAddress multiAddress() {
    return MultiAddress.values.id(publicKey.bytes);
  }
}

FixedI128 fixedI128FromDouble(double value) {
  return FixedI128(bits: u64F64Util.toFixed(value));
}

FixedU128 fixedU128FromDouble(double value) {
  return FixedU128(bits: u64F64Util.toFixed(value));
}

abstract class LocationFactory {
  static Location fromDouble({
    required double lat,
    required double lon,
  }) {
    return Location(
      lat: fixedI128FromDouble(lat),
      lon: fixedI128FromDouble(lon),
    );
  }
}

abstract class ProofOfAttendanceFactory {
  static ProofOfAttendance signed({
    required AccountId32 proverPublic,
    required int ceremonyIndex,
    required CommunityIdentifier communityIdentifier,
    required Sr25519KeyPair attendee,
  }) {
    final msg = ProverCeremonyIndexTuple(proverPublic, ceremonyIndex);

    return ProofOfAttendance(
      proverPublic: proverPublic,
      ceremonyIndex: ceremonyIndex,
      communityIdentifier: communityIdentifier,
      attendeePublic: attendee.publicKey.bytes,
      attendeeSignature: const $MultiSignature().sr25519(
        attendee.sign(proverCeremonyIndexTupleCodec.encode(msg)),
      ),
    );
  }
}

typedef ProverCeremonyIndexTuple = Tuple2<AccountId32, int>;

typedef ProverCeremonyIndexTupleCodecType = Tuple2Codec<AccountId32, int>;

const proverCeremonyIndexTupleCodec = ProverCeremonyIndexTupleCodecType(AccountId32Codec(), U32Codec.codec);
