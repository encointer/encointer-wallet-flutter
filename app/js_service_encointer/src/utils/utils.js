import { bnToU8a } from '@polkadot/util';
import { stringToEncointerBalance } from '@encointer/types';

export function applyDemurrage(balanceEntry, latestBlockNumber, demurrageRate) {
  const elapsed = latestBlockNumber - balanceEntry.lastUpdate;
  const exponent = -demurrageRate * elapsed
  return balanceEntry.principal * Math.pow(Math.E, exponent);
}

export function stringNumberToEncointerBalanceU8(balance) {
  return bnToU8a(stringToEncointerBalance(balance), 128, true);
}
