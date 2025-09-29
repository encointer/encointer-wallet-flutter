import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_core/crypto/account_id32.dart';

XcmLocation encointerAddressOnAHK(String ss58Address) {
  final accountId = AddressUtils.addressToPubKey(ss58Address);
  return encointerAccountOnAHK(accountId);
}

XcmLocation encointerAccountOnAHK(AccountId32 accountId) {
  return XcmLocation(parents: 1, interior: X2([Parachain(BigInt.from(1001)), XcmAccountId32(id: accountId)]));
}

class LocationToAccountApi {
  LocationToAccountApi(this.provider);

  final Provider provider;

  Future<AccountId32> locationToAccountId(XcmLocation location) async {
    final api = StateApi(provider);
    final result = await api.call('LocationToAccountApi_convert_location', LocationV5(location).encode());

    if (result.isEmpty || result[0] == 1) {
      // Unfortunately, we do not have the type to decode the error message.
      // But the first byte being 1 indicates an error, and the second by
      // being 0 indicates "Unsupported".
      throw Exception('Failed to convert location to account ID: $result');
    }

    return const AccountId32Codec().decode(Input.fromBytes(result.sublist(1)));
  }
}
