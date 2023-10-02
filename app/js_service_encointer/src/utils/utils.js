import { bnToU8a } from '@polkadot/util';
import { stringToEncointerBalance } from '@encointer/types';

export function applyDemurrage (balanceEntry, latestBlockNumber, demurrageRate) {
  const elapsed = latestBlockNumber - balanceEntry.lastUpdate;
  const exponent = -demurrageRate * elapsed;
  return balanceEntry.principal * Math.pow(Math.E, exponent);
}

/**
 * Encodes a string representing a decimal number to a scale encoded U8a array that
 * can be put as is into an extrinsic.
 */
export function stringNumberToEncointerBalanceU8a (balance) {
  return bnToU8a(stringToEncointerBalance(balance), {
    bitLength: 128,
    isLe: true
  });
}
