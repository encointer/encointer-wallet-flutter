import { createType } from '@polkadot/types';
import * as bs58 from 'bs58';
import { createTrustedCall } from '../../src/service/account';

export function getTrustedCall (sender, registry, network) {
  const cidTyped = createType(registry, 'CurrencyIdentifier', bs58.decode(network.chosenCid));
  const proof = createType(registry, 'Option<ProofOfAttendance<MultiSignature, AccountId>>');

  return createTrustedCall(
    sender,
    cidTyped,
    'ceremonies_register_participant',
    (sender.publicKey, cidTyped, proof)
  );
}
