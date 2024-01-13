import { assert, hexToU8a } from '@polkadot/util';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import { createType } from '@polkadot/types';
import { parseEncointerBalance } from '@encointer/types';
import { keyring, sendTxWithPair } from './account.js';
import { communityIdentifierToString } from '@encointer/util';
import {
  getDemurrage as _getDemurrage, submitAndWatchTx,
} from '@encointer/node-api';
import { getFinalizedHeader } from './chain.js';
import { applyDemurrage } from '../utils/utils.js';
import { Keyring } from '@polkadot/keyring';

export async function getBalance (cid, address) {
  const balanceEntry = await api.query.encointerBalances.balance(cid, address);
  return {
    principal: parseEncointerBalance(balanceEntry.principal.bits),
    lastUpdate: balanceEntry.lastUpdate.toNumber()
  };
}

/***
 * Reaps the voucher and transfers all funds to `recipientAddress`
 *
 * Todo: Use `transferAll` once it is in the runtime.
 */
export async function reapVoucher (voucherUri, recipientAddress, cid) {

  const voucherPair = keyring.createFromUri(voucherUri);

  console.log(`[reapVoucher] voucherUri: ${voucherUri}`);
  console.log(`[reapVoucher] generated voucher address: ${voucherPair.address}`);

  // This will be replaced after `transferAll` is implemented.
  const [balanceEntry, finalizedHeader, demurrage] = await Promise.all([
    getBalance(cid, voucherPair.address),
    getFinalizedHeader(),
    getDemurrage(cid),
  ]);

  console.log(`[reapVoucher] voucher balanceEntry: ${JSON.stringify(balanceEntry)}`);

  const balance = applyDemurrage(balanceEntry, finalizedHeader.number, demurrage);
  console.log(`[encointer/reapVoucher] transfer from voucher ${balance} to ${recipientAddress}`);

  // 0.04: less doesn't make any sense. The voucher of the recipient won't even
  // be able to pay a transaction with it.
  if (balance < 0.04) {
    return new Promise((resolve, _reject) => {
      resolve({ error: 'the voucher does not have enough balance left.' });
    });
  }

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

export async function getDemurrage (cid) {
  const cidT = api.createType('CommunityIdentifier', cid);

  return _getDemurrage(api, cidT).then((demBits) => parseEncointerBalance(demBits));
}

/**
 * Produce Proof of Attendance to register a participant.
 * In order to create properly formatted SCALE encoded proof following arguments
 * required: attendee account with address and sign method, community identifier
 * as a string, past ceremony index.
 * Currently SINGLE account passed to this function in order derive:
 * a) ATTENDEE account that participated in past ceremony cIndex, returned as
 *    attendee_public property, and to sign payload which should contain PROVER
 * b) PROVER address returned as prover_public property and in signature payload
 * in future release this function should receive two accounts.
 * @param {String} attendeePubKey
 * @param {CommunityIdentifier} cid
 * @param {CeremonyIndexType} cIndex
 * @param password to unlock privKey
 * @returns {Option<ProofOfAttendance>} proofOfAttendance
 */
export async function getProofOfAttendance (attendeePubKey, cid, cIndex, password) {
  const cidT = api.createType('CommunityIdentifier', cid);
  window.send('js-getProofOfAttendance', `getting PoA for  Cid: ${communityIdentifierToString(cidT)}, cIndex: ${cIndex} and address: ${attendeePubKey}`);
  const attendee = keyring.getPair(hexToU8a(attendeePubKey));
  return _getProofOfAttendance(attendee, cid, cIndex);
}

export async function _getProofOfAttendance (attendee, cid, cindex) {
  await cryptoWaitReady();
  const registry = api.registry;
  assert((attendee && attendee.address), 'Invalid attendee');
  assert(attendee.sign, 'Attendee should have sign method');
  assert(cid, 'Invalid Community Identifier');
  assert(cindex > 0, 'Invalid Ceremony index');
  const attendeePublic = createType(registry, 'AccountId', attendee.address).toU8a();
  // !Prover has same address as attendee, will be changed in future!
  const proverPublic = attendeePublic;
  const communityIdentifier = createType(registry, 'CommunityIdentifier', cid);
  const msg = createType(registry, '(AccountId, CeremonyIndexType)', [proverPublic, cindex]);
  const signature = attendee.sign(msg.toU8a(), { withType: true });
  const proof = createType(registry, 'ProofOfAttendance', {
    proverPublic: proverPublic,
    ceremonyIndex: cindex,
    communityIdentifier: communityIdentifier,
    attendeePublic: attendeePublic,
    attendeeSignature: signature
  });
  return createType(registry, 'Option<ProofOfAttendance>', proof);
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
  getProofOfAttendance,
  getBalance,
  sendNextPhaseTx,
  reapVoucher,
};
