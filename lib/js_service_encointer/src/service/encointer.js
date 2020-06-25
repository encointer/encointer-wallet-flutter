import { assert, hexToU8a, u8aToHex } from '@polkadot/util';
import BN from 'bn.js';
import { cryptoWaitReady, encodeAddress } from '@polkadot/util-crypto';
import { createType } from '@polkadot/types';
import * as bs58 from 'bs58';
import { parseI32F32, toI32F32 } from '../utils/fixpointUtil';

import { Keyring } from '@polkadot/keyring';
const keyring = new Keyring({ ss58Format: 0, type: 'sr25519' });

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
    send(msgChannel, moment);
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
  // cids.map((cid) => bs58.decode(cid));
  return {
    cids
  };
}

export async function fetchCurrentCeremonyIndex () {
  return await api.query.encointerScheduler.currentCeremonyIndex();
}

export async function fetchMeetupIndex (cid, cIndex, address) {
  return await api.query.encointerCeremonies.meetupIndex([cid, cIndex], address);
}

export async function fetchParticipantIndex (cid, cIndex, address) {
  send('log', `Fetching participant index for Cid: ${cid}, cIndex: ${cIndex} and address: ${address}`);
  const pIndex = await api.query.encointerCeremonies.participantIndex([cid, cIndex], address);
  send('log', `Participant index: ${pIndex}`);
  return pIndex;
}

export async function fetchParticipantCount (cid, cIndex) {
  send('log', `Fetching participant cound for Cid: ${cid} and cIndex: ${cIndex}`);
  return await api.query.encointerCeremonies.participantCount([cid, cIndex]);
}

export async function fetchNextMeetupTime (cid, location) {
  send('log', `Fetching next meetup time for Cid ${cid} and location: ${location.lat}, ${location.lat}`);
  const phase = await api.query.encointerScheduler.currentPhase();
  send('log', `CurrentPhase: ${phase}`);
  const duration = await api.query.encointerScheduler.phaseDurations(phase);
  send('log', `Duration: ${duration}`);
  const nextPhase = await api.query.encointerScheduler.nextPhaseTimestamp();
  // const momentsPerDay = await api.query.encointerCeremonies.momentsPerDay();
  // const per_degree = moments_per_day / 360;
  // send('log', `moments per day: ${momentsPerDay}`);
  return nextPhase - duration;
}

/**
 * 'api.query.encointerCurrencies.locations(cid)' returns an Array
 * EncointerLocations =  { lat: I32F32, long: I32F32 }
 * @param cid CurrencyIdentifier
 * @param mIndex MeetupIndex
 * @param address
 * @returns {Promise<{lon: number, lat: number}>}
 */
export async function fetchNextMeetupLocation (cid, mIndex, address) {
  // assert(m_index !== 0, "Meetup index is null, hence no meetup was found")
  send('log', `Meetup Index: ${mIndex}`);
  const locations = await api.query.encointerCurrencies.locations(cid);
  send('log', `Locations: ${locations}`);
  assert(mIndex <= locations.length);
  const _loc = locations[mIndex - 1];
  return createType(api.registry, 'Location', {
    lat: toI32F32(_loc.lat),
    lon: toI32F32(_loc.lon)
  });
}

function unsubscribe (unsub, msgChannel) {
  const unsubFuncName = `unsub${msgChannel}`;
  window[unsubFuncName] = unsub;
  return {};
}

/**
 * Produce Proof of Attendance to register a participant.
 * In order to create properly formatted SCALE encoded proof following arguments
 * required: attendee account with address and sign method, currency identifier
 * as a string, past ceremony index.
 * Currently SINGLE account passed to this function in order derive:
 * a) ATTENDEE account that participated in past ceremony cindex, returned as
 *    attendee_public property, and to sign payload which should contain PROVER
 * b) PROVER address returned as prover_public property and in signature payload
 * in future release this function should receive two accounts.
 * @param {account} attendee
 * @param {CurrencyIdentifier} cid
 * @param {CeremonyIndexType} cindex
 * @returns {Option<ProofOfAttendance>} proofOfAttendance
 */
export async function getProofOfAttendance (attendee, cid, cindex) {
  await cryptoWaitReady();
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
 * @returns {ClaimOfAttendance} claim
 * @param claim
 */
export function getClaimOfAttendance (claim) {
  send('log', `creating location from Json: ${claim}`);
  const claimJson = JSON.parse(claim);
  send('log', `lcation: ${claimJson.location.lat}, ${claimJson.location.lon}`);

  const loc = {
    lat: toI32F32(claimJson.location.lat),
    lon: toI32F32(claimJson.location.lon)
  };
  // const claimObj = createType(api.registry, 'ClaimOfAttendance', claim);
  send('log', `created loc: ${loc.lat}, ${loc.lon}`);
  const claimObj = createType(api.registry, 'ClaimOfAttendance', {
    claimant_public: claimJson.claimant_public,
    ceremony_index: claimJson.ceremony_index,
    currency_identifier: claimJson.currency_identifier,
    meetup_index: claimJson.meetup_index,
    location: loc,
    time: claimJson.timestamp,
    number_of_participants_confirmed: claimJson.number_of_participants_confirmed
  });
  send('log', `claim: ${claimObj}`);
  // The Dart api needs to get a Promise back for some reason
  return new Promise((resolve, reject) => {
    resolve(u8aToHex(claimObj.toU8a()));
  });
}

/**
 * Parse Claim Of Attendance type
 * @param {Hex} claimHex
 * @return {Object} claim
 */
export function parseClaimOfAttendance (claimHex) {
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
 * @param {Hex} claimHex
 * @param {AccountId} account
 * @return {U8a} attest
 */
export function attestClaimOfAttendance (claimHex, account) {
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
  attestClaimOfAttendance,
  fetchCurrentCeremonyIndex,
  fetchNextMeetupLocation,
  fetchNextMeetupTime,
  fetchMeetupIndex,
  fetchParticipantIndex,
  fetchParticipantCount
};
