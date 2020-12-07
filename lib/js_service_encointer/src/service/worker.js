import { createType, U32 } from '@polkadot/types';
import WS from 'websocket';
import { assert, hexToU8a, u8aToBn, u8aToBuffer, u8aToHex, u8aToU8a } from '@polkadot/util';
import * as bs58 from 'bs58';
import { CustomTypes } from '../config/types';
import * as fixPoint from '../utils/fixpointUtil';
import NodeRSA from 'node-rsa';

import { keyring } from './account';
import { parseI64F64 } from '../utils/fixpointUtil';

const { w3cwebsocket: WebSocket } = WS;
const _workers = new Map();

const RQ_TRUSTED_GETTER_NAMES = Object.keys(CustomTypes.TrustedGetter._enum);

export const createTyped = (type, data) =>
  createType(api.registry, type, hexToU8a('0x'.concat(data)));

const parseBalance = data => {
  const balanceEntry = createType(api.registry, 'BalanceEntry<u32>', unpack(data));
  console.log('BalanceEntry: ' + balanceEntry);
  return {
    principal: parseI64F64(balanceEntry.principal),
    last_update: balanceEntry.last_update.toNumber()
  };
};

const parseU64 = data => {
  return createType(api.registry, 'u64', unpack(data));
};

const parseU32 = data => {
  return createType(api.registry, 'u32', unpack(data));
};

const parseBalanceType = data => {
  return fixPoint.parseI64F64(u8aToBn(unpack(data)));
};

const parseParticipantIndex = data => {
  return createType(api.registry, 'ParticipantIndexType', unpack(data));
};

const parseMoment = data => {
  return createType(api.registry, 'Moment', unpack(data));
};

const parseAttestations = data => {
  return createType(api.registry, 'Vec<Attestation>', unpack(data));
};

const parseMeetupAssignment = data => {
  return createType(api.registry, '(MeetupIndexType, Option<Location>)', unpack(data));
};

const crypt = require('crypto');

/**
 * Same implementation as node-rsa's but with a hardcoded hashFunction (SHA1) as node-rsa uses always the same
 * hashFunction for the mfg1 digest as for the encryption, which sgx might not do (unsure about this).
 * @param seed
 * @param maskLength
 * @param hashFunction
 * @returns {Buffer}
 */
function mfg1Sha1 (seed, maskLength, hashFunction) {
  console.log('[Worker]: In custom mfg1Sha1');
  hashFunction = 'sha1';
  var hLen = 20;
  var count = Math.ceil(maskLength / hLen);
  var T = Buffer.alloc(hLen * count);
  var c = Buffer.alloc(4);
  for (let i = 0; i < count; ++i) {
    const hash = crypt.createHash(hashFunction);
    hash.update(seed);
    c.writeUInt32BE(i, 0);
    hash.update(c);
    hash.digest().copy(T, i * hLen);
  }
  return T.slice(0, maskLength);
}

const parseWorkerPubKey = data => {
  const keyJson = JSON.parse(data);
  console.log('KeyJson Raw: { \nn: ' + keyJson.n + '\ne: ' + keyJson.e + '\n}');
  keyJson.n = u8aToBuffer(keyJson.n);
  keyJson.e = u8aToBuffer(keyJson.e);
  console.log(keyJson);
  const key = new NodeRSA();
  key.setOptions({
    encryptionScheme: {
      scheme: 'pkcs1_oaep',
      hash: 'sha256',
      label: '',
      mgf: mfg1Sha1
    }
  });
  key.importKey({
    n: keyJson.n,
    e: keyJson.e
  }, 'components-public');
  console.log(key);
  return key;
};

/// Unpacks the value that is wrapped in all the Options and encoding from the worker.
/// Defaults to return `[]`, which is fine as `createType(api.registry, <type>, [])`
/// instantiates the <type> with its default value.
function unpack (packedValue) {
  const dataTyped = createTyped('Option<Vec<u8>>', packedValue)
    .unwrapOrDefault(); // (Option<Value.enc>.enc+whitespacePad)
  const trimmed = trimWhiteSpace(u8aToHex(dataTyped));
  return createType(api.registry, 'Option<Vec<u8>>', hexToU8a(trimmed))
    .unwrapOrDefault();
}

function trimWhiteSpace (data) {
  return data.replace(/(20)+$/, '');
}

function requestParams (address, shard) {
  return createType(api.registry, '(AccountId, CurrencyIdentifier)', [address, shard]);
}

function clientRequestGetter (cid, request) {
  const cidBin = u8aToHex(bs58.decode(cid));
  const getter = createType(api.registry, 'PublicGetter', {
    [request]: cidBin
  });
  const clientRq = createType(api.registry, 'ClientRequest', {
    StfState: [{ public: getter }, cidBin]
  });
  return clientRq.toU8a();
}

function clientRequestTrustedGetter (account, cid, request) {
  assert(RQ_TRUSTED_GETTER_NAMES.indexOf(request) !== -1, `Unknown request: ${request}`);
  const address = account.address;
  const cidBin = u8aToHex(bs58.decode(cid));
  const getter = createType(api.registry, 'TrustedGetter', {
    [request]: requestParams(address, cidBin)
  });
  const signature = account.sign(getter.toU8a());
  const clientRq = createType(api.registry, 'ClientRequest', {
    StfState: [
      {
        trusted: {
          getter,
          signature
        }
      },
      cidBin
    ]
  });
  return clientRq.toU8a();
}

export class Worker {
  constructor (url) {
    this.wsPromise = new Promise((resolve, reject) => {
      this.ws = new WebSocket(url);
      this.ws.onopen = () => resolve(this.ws);
      this.ws.onerror = () => reject(this.ws);
      this.ws.onclose = () => {
        this.ws.onclose = null;
        this.ws.onerror = null;
        this.ws.onopen = null;
        this.ws.onmessage = null;
      };
      this.pubKey = null;
    });
  }

  isClosed () {
    return this.ws.readyState === this.ws.CLOSED || this.ws.readyState === this.ws.CLOSING;
  }

  isReady () {
    return new Promise((resolve, reject) => {
      if (this.ws.readyState === this.ws.CONNECTING) {
        this.wsPromise
          .then(ws => resolve(ws.readyState === ws.OPEN))
          .catch(ws => {
            const reason = ws.CLOSING ? 'ws closing' : 'ws closed';
            reject(reason);
          });
      } else {
        resolve(this.ws.readyState === this.ws.OPEN);
      }
    });
  }

  sendRequest (requestData, parse) {
    return new Promise((resolve, reject) => {
      const handleSuccess = resp => {
        if (resp.data === 'Could not decode request') {
          reject(resp.data);
        } else {
          resolve(parse(resp.data));
        }
        this.ws.onmessage = null;
        this.ws.onerror = null;
      };
      const handleError = err => {
        this.ws.onmessage = null;
        this.ws.onerror = null;
        reject(err);
      };
      this.ws.onmessage = handleSuccess;
      this.ws.onerror = handleError;

      this.wsPromise
        .then(ws => {
          ws.send(requestData);
        })
        .catch(reject);
    });
  }

  getShieldingKey () {
    const clientRq = createType(api.registry, 'ClientRequest', {
      PubKeyWorker: null
    });
    return this.sendRequest(clientRq.toU8a(), parseWorkerPubKey);
  }

  getTotalIssuance (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'total_issuance'), parseBalance);
  }

  getParticipantCount (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'participant_count'), parseU64);
  }

  getMeetupCount (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'meetup_count'), parseU64);
  }

  getCeremonyReward (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'ceremony_reward'), parseBalanceType);
  }

  getLocationTolerance (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'location_tolerance'), parseU32);
  }

  getTimeTolerance (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'time_tolerance'), parseMoment);
  }

  getBalance (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'balance'), parseBalance);
  }

  getRegistration (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'registration'), parseParticipantIndex);
  }

  getMeetupIndexAndLocation (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'meetup_index_and_location'), parseMeetupAssignment);
  }

  getAttestations (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'attestations'), parseAttestations);
  }
}

export function useWorker (node) {
  let worker = _workers.get(node);
  if (!worker || worker.isClosed()) {
    worker = new Worker(node);
    _workers.set(node, worker);
  }
  return worker;
}

// wrappers to fetch account from keyring
export async function getBalance (pubKey, cid, password) {
  const keyPair = keyring.getPair(hexToU8a(pubKey));
  try {
    keyPair.decodePkcs8(password);
  } catch (err) {
    return new Promise((resolve, reject) => {
      resolve({ error: 'password check failed' });
    });
  }
  return useWorker(window.workerEndpoint).getBalance(keyPair, bs58.encode(hexToU8a(cid)));
}

// wrappers to fetch account from keyring
export async function getParticipantIndex (pubKey, cid, password) {
  const keyPair = keyring.getPair(hexToU8a(pubKey));
  try {
    keyPair.decodePkcs8(password);
  } catch (err) {
    return new Promise((resolve, reject) => {
      resolve({ error: 'password check failed' });
    });
  }
  return useWorker(window.workerEndpoint).getRegistration(keyPair, bs58.encode(hexToU8a(cid)));
}

export default {
  useWorker,
  getBalance,
  getParticipantIndex,
  createTyped
};
