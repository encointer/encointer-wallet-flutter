import { assert, bnToU8a, hexToU8a } from '@polkadot/util';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import { createType } from '@polkadot/types';
import { parseEncointerBalance, stringToDegree } from '@encointer/types';
import { keyring, sendTxWithPair } from './account.js';
import { pallets, parachainSpecName, solochainSpecName } from '../config/consts.js';
import { unsubscribe } from '../utils/unsubscribe.js';
import { communityIdentifierToString } from '@encointer/util';
import {
  getMeetupIndex as _getMeetupIndex,
  getMeetupLocation,
  getMeetupParticipants,
  getParticipantIndex as _getParticipantIndex,
  getNextMeetupTime as _getNextMeetupTime,
  getDemurrage as _getDemurrage, submitAndWatchTx,
} from '@encointer/node-api';
import { locationFromJson } from '../utils/location-from-json.js';
import { getFinalizedHeader } from './chain.js';
import { applyDemurrage } from '../utils/apply-demurrage.js';
import { Keyring } from '@polkadot/keyring';

export async function getCurrentPhase () {
  return api.query.encointerScheduler.currentPhase();
}

export async function getNextPhaseTimestamp () {
  return api.query.encointerScheduler.nextPhaseTimestamp();
}

/**
 * Gets all phase durations to cache them on the dart side to speedup `getNextMeetupTime` request.
 */
export async function getPhaseDurations () {
  const [registering, assigning, attesting] = await Promise.all([
    api.query.encointerScheduler.phaseDurations('Registering'),
    api.query.encointerScheduler.phaseDurations('Attesting'),
    api.query.encointerScheduler.phaseDurations('Assigning')
  ]);
  return {
    Registering: registering,
    Attesting: assigning,
    Assigning: attesting
  };
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

/**
 * Subscribes to the currencies registry
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeCommunityIdentifiers (msgChannel) {
  return await api.query[pallets.encointerCommunities.name][pallets.encointerCommunities.calls.communityIdentifiers]((cids) => {
    send(msgChannel, cids);
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

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

  console.log(`[reapVoucher] after demurrage ${balance}`);

  // keep enough balance for the recipientAddress to pay the fees
  const transferAmount = applyDemurrage(balanceEntry, finalizedHeader.number, demurrage) - 0.02;

  console.log(`[encointer/reapVoucher] transfer from voucher ${transferAmount} to ${recipientAddress}`);

  if (transferAmount < 0) {
    return new Promise((resolve, _reject) => {
      resolve({ error: 'the voucher does not have enough balance left.' });
    });
  }

  return encointerTransfer(voucherPair, recipientAddress, cid, transferAmount.toString());
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

/**
 * Subscribes to the balance of a given cid
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeBalance (msgChannel, cid, address) {
  return await api.query.encointerBalances.balance(cid, address, (b) => {
    const balance = parseEncointerBalance(b.principal.bits);
    send(msgChannel, {
      principal: balance,
      lastUpdate: b.lastUpdate.toNumber()
    });
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

/**
 * Subscribes to the business registry of a given cid
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeBusinessRegistry (msgChannel, cid) {
  return await api.query.encointerBazaar.businessRegistry(cid, (businesses) => {
    send(msgChannel, businesses);
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

export async function getParticipantIndex (cid, cIndex, address) {
  const cidT = api.createType('CommunityIdentifier', cid);
  const cIndexT = api.createType('CeremonyIndexType', cIndex);
  send('js-getParticipantIndex', `Getting participant index for Cid: ${communityIdentifierToString(cidT)}, cIndex: ${cIndex} and address: ${address}`);
  return _getParticipantIndex(api, cidT, cIndexT, address);
}

export async function getParticipantReputation (cid, cIndex, address) {
  const cidT = api.createType('CommunityIdentifier', cid);
  send('js-getParticipantReputation', `Getting participant reputation for Cid: ${communityIdentifierToString(cidT)}, cIndex: ${cIndex} and address: ${address}`);
  const reputation = await api.query.encointerCeremonies.participantReputation([cid, cIndex], address);
  send('js-getParticipantReputation', `Participant reputation: ${reputation}`);
  return reputation;
}

// returns a list of prefixed hex strings
export async function getCommunityIdentifiers () {
  const pallet = pallets.encointerCommunities;
  const cids = await api.query[pallet.name][pallet.calls.communityIdentifiers]();
  return {
    cids
  };
}

export async function getBootstrappers (cid) {
  const cidT = api.createType('CommunityIdentifier', cid);

  return await api.query.encointerCommunities.bootstrappers(cidT);
}

export async function remainingNewbieTickets (cid, ceremonyIndex, pubkey) {
  const cidT = api.createType('CommunityIdentifier', cid);
  window.send('js-remainingNewbieTickets', `cid: ${communityIdentifierToString(cidT)}, cIndex: ${ceremonyIndex} and address: ${pubkey}`);

  // Wrapping it in a promise all speeds up the process as we can await multiple futures at the same time.
  const [burnedTickets, ticketsPerReputation] = await Promise.all([
    api.query.encointerCeremonies.burnedReputableNewbieTickets([cid, ceremonyIndex], pubkey),
    api.query.encointerCeremonies.endorsementTicketsPerReputable(),
  ]).catch((e) => console.log(`js-remainingNewbieTickets error ${e}`));

  window.send('js-remainingNewbieTickets', `ticketsPerReputation ${ticketsPerReputation}`);
  window.send('js-remainingNewbieTickets', `burnedTickets ${burnedTickets}`);

  return ticketsPerReputation - burnedTickets;
}

export async function getCommunityMetadata (cid) {
  const pallet = pallets.encointerCommunities;
  const meta = await api.query[pallet.name][pallet.calls.communityMetadata](cid);

  // `toU8a` is necessary. Otherwise, the metadata's fields are represented as hex-strings if the community was
  // registered via polkadot-js/apps and.
  return api.createType('CommunityMetadataType', meta.toU8a());
}

export async function getDemurrage (cid) {
  const cidT = api.createType('CommunityIdentifier', cid);

  return _getDemurrage(api, cidT).then((demBits) => parseEncointerBalance(demBits));
}

export async function communitiesGetAll () {
  return await api.rpc.encointer.getAllCommunities();
}

export async function getCurrentCeremonyIndex () {
  return await api.query.encointerScheduler.currentCeremonyIndex();
}

export async function getMeetupIndex (cid, cIndex, address) {
  const cidT = api.createType('CommunityIdentifier', cid);
  const cIndexT = api.createType('CeremonyIndexType', cIndex);

  return _getMeetupIndex(api, cidT, cIndexT, address);
}

export async function getMeetupRegistry (cid, cIndex, mIndex) {
  const cidT = api.createType('CommunityIdentifier', cid);
  const cIndexT = api.createType('CeremonyIndexType', cIndex);
  const mIndexT = api.createType('MeetupIndexType', mIndex);

  return getMeetupParticipants(api, cidT, cIndexT, mIndexT);
}

/**
 * Gets the meetup time for a location.
 *
 * @param location Meetup location with fields as numbers, e.g. 35.153215322
 * @returns {Promise<Moment>}
 */
export async function getNextMeetupTime (location) {
  const locT = api.createType('Location', {
    lat: stringToDegree(location.lat),
    lon: stringToDegree(location.lon),
  });

  return _getNextMeetupTime(api, locT);
}

/**
 *
 * @param cid CommunityIdentifier
 * @param cIndex CurrentCeremonyIndex
 * @param mIndex MeetupIndex
 * @param address
 * @returns {Promise<Location>} with number format '35.123412341234'
 */
export async function getNextMeetupLocation (cid, cIndex, mIndex, address) {
  const cidT = api.createType('CommunityIdentifier', cid);
  const cIndexT = api.createType('CeremonyIndexType', cIndex);
  const mIndexT = api.createType('MeetupIndexType', mIndex);

  return getMeetupLocation(api, cidT, cIndexT, mIndexT);
}

/**
 * Get all meetup locations for cid.
 */
export async function getAllMeetupLocations (cid) {
  const cidT = api.createType('CommunityIdentifier', cid);

  return api.rpc.encointer.getLocations(cidT);
}

/**
 * Get all reputations for an account in all communities.
 */
export async function getReputations (account) {
  console.log(`[JS] getting reputations for ${account}`);

  return api.rpc.encointer.getReputations(account);
}

/**
 * Checks if the ceremony rewards has been issued.
 *
 * @param cid CommunityIdentifier
 * @param cIndex CeremonyIndexType
 * @param address
 * @returns {Promise<boolean>}
 */
export async function hasPendingIssuance (cid, cIndex, address) {
  const cidT = api.createType('CommunityIdentifier', cid);
  const cIndexT = api.createType('CeremonyIndexType', cIndex);

  const mIndex = await getMeetupIndex(cidT, cIndexT, address);

  if (mIndex.eq(0)) {
    return false;
  }

  if (hasNewIssuedRewardsStorage()) {
    console.log('js-hasPendingIssuance', `Has IssuedRewards storage v2`);

    try {
      const alreadyIssued = await api.query.encointerCeremonies.issuedRewards([cidT, cIndexT], mIndex)
        .then((maybeResult) => api.createType('Option<MeetupResult>', maybeResult));
      console.log('js-hasPendingIssuance', `MeetupResult: ${alreadyIssued.toJSON()}`);

      // None means that the meetup has not been evaluated.
      return alreadyIssued.isNone;
    } catch (e) {
      console.log('js-hasPendingIssuance', `Error: ${e.toString()}`);
    }
  } else {
    console.log('js-hasPendingIssuance', `Has IssuedRewards storage v1`);
    return hasPendingIssuanceOld(cidT, cIndexT, mIndex);
  }
}

async function hasPendingIssuanceOld(cidT, cIndexT, mIndexT) {
  // We need to fetch the keys here, as the storage map is (CurrencyCeremony, MeetupIndex) => ().
  // The default value for type '()' is ''. Hence, we can't identify if the key exists by looking at the value
  // because polkadot-js returns the default value for a nonexistent key.
  const alreadyIssued = await api.query.encointerCeremonies.issuedRewards.keys([cidT, cIndexT])
    .then((keys) => keys.map(({ args: [_currencyCeremony, mIndex] }) => mIndex.toNumber()));

  console.log('js-hasPendingIssuance', `already issued meetups: ${alreadyIssued}`);

  // `toNumber` is necessary; polkadot-js objects to not overwrite object equality.
  return !alreadyIssued.includes(mIndexT.toNumber());
}

/**
 * The old version just had `HashMap<MeetupIndex,()`. If the key was present, the meetup has been evaluated.
 *
 * The new one contains a `HashMap<MeetupIndex, MeetupResult>`.
 * @returns {boolean}
 */
function hasNewIssuedRewardsStorage() {
  console.log(`Api:Runtime Spec Name: ${api.runtimeVersion.specName}`);
  console.log(`Api:Runtime Spec version: ${api.runtimeVersion.specVersion}`);

  return (api.runtimeVersion.specName.toString() === parachainSpecName && api.runtimeVersion.specVersion >= 9) ||
    (api.runtimeVersion.specName.toString() === solochainSpecName && api.runtimeVersion.specVersion >= 20);
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
  try {
    attendee.decodePkcs8(password);
  } catch (err) {
    return new Promise((resolve, reject) => {
      resolve({ error: 'password check failed' });
    });
  }
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
 * @param {json} claimJson
 * @param {string} password
 */
export async function signClaimOfAttendance (claimJson, password) {
  await cryptoWaitReady();
  const claimant = keyring.getPair(hexToU8a(claimJson.claimantPublic));
  try {
    claimant.decodePkcs8(password);
  } catch (err) {
    return new Promise((resolve, reject) => {
      resolve({ error: 'password check failed' });
    });
  }
  return _signClaimOfAttendance(claimant, claimJson);
}

export async function _signClaimOfAttendance (claimant, claimJson) {
  await cryptoWaitReady();

  send('js-signClaimOfAttendance', `claimJson: ${JSON.stringify(claimJson)}`);

  let claim = {
    ...claimJson,
    location: locationFromJson(api, claimJson.location),
  };

  const payload = api.createType('ClaimOfAttendanceSigningPayload', {
    ...claim,
    location: {
      // scale-codec is LE, hence we need to sign the LE encoded payload, which is not the default for `i128`, otherwise
      // we get a signature error in the runtime. See: https://github.com/polkadot-js/api/issues/4313
      lat: claim.location.lat.toHex(true),
      lon: claim.location.lon.toHex(true),
    }
  });

  const signature = claimant.sign(payload.toU8a(), { withType: true });

  return api.createType('ClaimOfAttendance', {
    ...claim,
    claimantSignature: api.createType('MultiSignature', signature) // js can implicitly create `Option<Type> iff `Type` is already a registry object.
  });
}

export async function getBusinessRegistry (cid) {
  return await api.query.encointerBazaar.businessRegistry(cid);
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
  getCurrentPhase,
  getNextPhaseTimestamp,
  getPhaseDurations,
  getCommunityIdentifiers,
  getParticipantReputation,
  getBootstrappers,
  subscribeCurrentPhase,
  subscribeBalance,
  subscribeCommunityIdentifiers,
  subscribeBusinessRegistry,
  getProofOfAttendance,
  signClaimOfAttendance,
  getCurrentCeremonyIndex,
  getNextMeetupLocation,
  getNextMeetupTime,
  getDemurrage,
  getCommunityMetadata,
  getAllMeetupLocations,
  communitiesGetAll,
  getMeetupIndex,
  getParticipantIndex,
  getMeetupRegistry,
  hasPendingIssuance,
  getBalance,
  getBusinessRegistry,
  getReputations,
  sendNextPhaseTx,
  reapVoucher,
  remainingNewbieTickets,
};
