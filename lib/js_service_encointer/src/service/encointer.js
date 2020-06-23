import { assert, bnToBn, hexToU8a, u8aToHex } from '@polkadot/util';
import BN from 'bn.js';
import { encodeAddress, cryptoWaitReady } from '@polkadot/util-crypto';
import { createType } from '@polkadot/types';
import * as bs58 from 'bs58';
import { parseI32F32, toI32F32 } from '../utils/fixpointUtil';

const divisor = new BN('1'.padEnd(18 + 1, '0'));

function balanceToNumber (amount) {
  return (
    amount
      .muln(1000)
      .div(divisor)
      .toNumber() / 1000
  );
}

export async function fetchCurrentPhase () {
  const phase = await api.query.encointerScheduler.currentPhase();
  return {
    phase
  };
}

/**
 * Mainly debug method introduced to test subscriptions. Subscribes to the timestamp of the last block
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeTimestamp (msgChannel) {
  await api.query.timestamp.now((moment) => {
    send(msgChannel, `timestamp: ${moment}`);
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

/**
 * Subscribes to the current ceremony phase
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeCurrentPhase (msgChannel) {
  return await api.query.encointerScheduler.currentPhase((phase) => {
    send(msgChannel, phase);
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

export async function fetchCurrencyIdentifiers () {
  const cids = await api.query.encointerCurrencies.currencyIdentifiers();
  return {
    cids
  };
}

function unsubscribe (unsub, msgChannel) {
  const unsubFuncName = `unsub${msgChannel}`;
  window[unsubFuncName] = unsub;
  return {};
}

/**
 * Produce Proof of Attendance to register a participant.
 * In order to create properly formatted SCALE encoded proof following arguments
 * required: Polkadot API object with type registry, attendee account with
 * address and sign method, currency identifier as a string, past ceremony index
 * Currently SINGLE account passed to this function in order derive:
 * a) ATTENDEE account that participated in past ceremony cindex, returned as
 *    attendee_public property, and to sign payload which should contain PROVER
 * b) PROVER address returned as prover_public property and in signature payload
 * in future release this function should receive two accounts.
 * @param {Api} api
 * @param {account} attendee
 * @param {CurrencyIdentifier} cid
 * @param {CeremonyIndexType} cindex
 * @returns {Option<ProofOfAttendance>} proofOfAttendance
 */
export async function getProofOfAttendance (api, attendee, cid, cindex) {
  await cryptoWaitReady();

  assert(api, 'No api provided');
  assert((api && api.registry), 'api has no registry');
  const registry = api.registry;

  assert((attendee && attendee.address), 'Invalid attendee');
  assert(attendee.sign, 'Attendee should have sign method');
  assert(cid, 'Invalid Currency Identifier');
  assert(cindex > 0, 'Invalid Ceremony index');
  const attendeePublic = createType(registry, 'AccountId', attendee.address).toU8a();
  // !Prover has same address as attendee, will be changed in future!
  const proverPublic = attendeePublic;
  const currencyIdentifier = createType(registry, 'CurrencyIdentifier', bs58.decode(cid));
  const msg = createType(registry, '(AccountId, CeremonyIndexType)', [proverPublic, cindex]);
  const signature = attendee.sign(msg.toU8a());
  const proof = createType(registry, 'ProofOfAttendance', {
    prover_public: proverPublic,
    ceremony_index: cindex,
    currency_identifier: currencyIdentifier,
    attendee_public: attendeePublic,
    attendee_signature: signature
  });
  return createType(registry, 'Option<ProofOfAttendance>', proof);
}

/**
 * Produce Claim Of Attendance type
 * @param {Api} api
 * @param {AccountId} accountid
 * @param {CurrencyIdentifier} cid
 * @param {number} cindex
 * @param {number} mindex
 * @param {Location} location
 * @param {number} time
 * @param {number} participants
 * @returns {ClaimOfAttendance} claim
 */
export function getClaimOfAttendance (api, accountid, cindex, cid, mindex, location, timestamp, participants) {
  assert(api, 'No api provided');
  assert((api && api.registry), 'api has no registry');
  assert(accountid, 'No accountid provided');
  assert(cindex, 'No cindex provided');
  assert(cid, 'No cid provided');
  assert(mindex, 'No mindex provided');
  assert(location, 'No location provided');
  assert(timestamp, 'No timestamp provided');
  assert(participants, 'No participants provided');
  const registry = api.registry;
  const calimantPublic = createType(registry, 'AccountId', accountid).toU8a();
  const currencyIdentifier = createType(registry, 'CurrencyIdentifier', bs58.decode(cid));
  const loc = createType(registry, 'Location', {
    lat: toI32F32(location.lat),
    lon: toI32F32(location.lon)
  });
  const claim = createType(registry, 'ClaimOfAttendance', {
    claimant_public: calimantPublic,
    ceremony_index: cindex,
    currency_identifier: currencyIdentifier,
    meetup_index: mindex,
    location: loc,
    timestamp,
    number_of_participants_confirmed: participants
  });
  return claim;
}

/**
 * Parse Claim Of Attendance type
 * @param {Api} api
 * @param {Hex} claimHex
 * @return {Object} claim
 */
export function parseClaimOfAttendance (api, claimHex) {
  assert(api, 'No api provided');
  assert((api && api.registry), 'api has no registry');
  const claim = createType(api.registry, 'ClaimOfAttendance', claimHex);
  return {
    ...claim.toJSON(),
    claimant_public: encodeAddress(claim.claimant_public),
    currency_identifier: bs58.encode(claim.currency_identifier),
    location: {
      lat: parseI32F32(claim.location.lat),
      lon: parseI32F32(claim.location.lon)
    }
  };
}

/**
 * Attest Claim Of Attendance with signature
 * @param {Api} api
 * @param {Hex} claimHex
 * @param {AccountId} account
 * @return {U8a} attest
 */
export function attestClaimOfAttendance (api, claimHex, account) {
  assert(api, 'No api provided');
  assert((api && api.registry), 'api has no registry');
  const registry = api.registry;
  const claim = createType(registry, 'ClaimOfAttendance', claimHex);
  const publicKey = createType(registry, 'AccountId', account.address).toU8a();
  const attest = createType(api.registry, 'Attestation', {
    claim,
    signature: account.sign(claim.toU8a()),
    public: publicKey
  });
  return attest.toU8a();
}

export default {
  fetchCurrentPhase,
  fetchCurrencyIdentifiers,
  subscribeTimestamp,
  subscribeCurrentPhase,
  getProofOfAttendance,
  getClaimOfAttendance,
  parseClaimOfAttendance,
  attestClaimOfAttendance
};
