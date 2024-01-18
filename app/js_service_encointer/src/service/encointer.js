import { keyring, sendTxWithPair } from './account.js';
import { submitAndWatchTx } from '@encointer/node-api';
import { Keyring } from '@polkadot/keyring';
import { parseEncointerBalance } from '@encointer/types';

export async function getBalance (cid, address) {
  const balanceEntry = await api.query.encointerBalances.balance(cid, address);
  return {
    principal: parseEncointerBalance(balanceEntry.principal.bits),
    lastUpdate: balanceEntry.lastUpdate.toNumber()
  };
}

/***
 * Reaps the voucher and transfers all funds to `recipientAddress`
 */
export async function reapVoucher (voucherUri, recipientAddress, cid) {

  const voucherPair = keyring.createFromUri(voucherUri);

  console.log(`[reapVoucher] voucherUri: ${voucherUri}`);
  console.log(`[reapVoucher] generated voucher address: ${voucherPair.address}`);

  return encointerTransferAll(voucherPair, recipientAddress, cid);
}

export function encointerTransfer (fromPair, recipientAddress, cid, amount) {

  const paramList = [recipientAddress, cid, amount];
  const txInfo = {
    module: 'encointerBalances',
    call: 'transfer',
    tip: 0,
    txPaymentAsset: cid, // As the sender has CC, we imply that we pay with it.
  };

  return sendTxWithPair(fromPair, txInfo, paramList);
}

export function encointerTransferAll (fromPair, recipientAddress, cid) {

  const paramList = [recipientAddress, cid];
  const txInfo = {
    module: 'encointerBalances',
    call: 'transferAll',
    tip: 0,
    txPaymentAsset: cid, // As the sender has CC, we imply that we pay with it.
  };

  return sendTxWithPair(fromPair, txInfo, paramList);
}

/**
 * Calls next phase with Alice.
 *
 * This will only work on the local-dev network.
 */
export async function sendNextPhaseTx() {
  const keyring = new Keyring({type: 'sr25519'});
  const alice = keyring.addFromUri('//Alice', {name: 'Alice default'});

  const tx = api.tx.sudo.sudo(
    api.tx.encointerScheduler.nextPhase()
  );

  const result = await submitAndWatchTx(api, alice, tx);

  return new Promise((resolve, _reject) => {
    if (result.error !== undefined) {
      resolve({ error: result.error });
    } else {
      resolve("Successfully called next phase.");
    }
  });
}

export default {
  getBalance,
  sendNextPhaseTx,
  reapVoucher,
};
