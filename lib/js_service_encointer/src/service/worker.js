import { createType } from '@polkadot/types';
import WS from 'websocket';
import { assert, hexToU8a, u8aToBn, u8aToHex } from '@polkadot/util';
import * as bs58 from 'bs58';
import { CustomTypes } from '../config/types';
import * as fixPoint from '../utils/fixpointUtil';

import { Keyring } from '@polkadot/keyring';
const keyring = new Keyring({ ss58Format: 0, type: 'sr25519' });

const { w3cwebsocket: WebSocket } = WS;
const _workers = new Map();

const RQ_NAMES = Object.keys(CustomTypes.TrustedGetter._enum);

export const createTyped = (type, data) =>
  createType(api.registry, type, hexToU8a('0x'.concat(data)));

const parseBalance = data => {
  const balanceEntry = createType(api.registry, 'BalanceEntry<u32>', unpack(data));
  console.log('BalanceEntry: ' + balanceEntry);
  // const balance = api.createType('Option<Vec<u8>>', dataTyped.unwrap()).unwrap();
  // Todo: apply demurrage
  return fixPoint.parseI64F64(balanceEntry.principal);
};

const parseU64 = data => {
  return createType(api.registry, 'u64', unpack(data));
};

const parseBalanceType = data => {
  return fixPoint.parseI64F64(u8aToBn(unpack(data)));
};

const parseParticipantIndex = data => {
  const dataTyped = createTyped('Option<ParticipantIndexType>', data)
    .unwrapOrDefault(0);
  return dataTyped.toNumber();
};

const parseAttestations = data => {
  const dataTyped = createTyped('Option<Vec<Attestation>>', data)
    .unwrapOrDefault([0]);
  return dataTyped.toJSON();
};

const parseMeetupAssignment = data => {
  const dataTyped = createTyped('Option<(MeetupIndexType, Option<Location>, Option<Moment>)>', data)
    .unwrapOrDefault();
  return dataTyped.toJSON();
};

/// Unpacks the value that is wrapped in all the options and encoding from the worker
function unpack (packedValue) {
  const dataTyped = createTyped('Option<Vec<u8>>', packedValue)
    .unwrap(); // (Option<Value.enc>.enc+whitespacePad)
  const trimmed = trimWhiteSpace(u8aToHex(dataTyped));
  console.log(trimmed);
  return createType(api.registry, 'Option<Vec<u8>>', hexToU8a(trimmed))
    .unwrap();
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
  assert(RQ_NAMES.indexOf(request) !== -1, `Unknown request: ${request}`);
  const address = account.address;
  const cidBin = u8aToHex(bs58.decode(cid));
  const getter = createType(api.registry, 'TrustedGetter', {
    [request]: requestParams(address, cidBin)
  });
  const signature = account.sign(getter.toU8a());
  const clientRq = createType(api.registry, 'ClientRequest', {
    StfState: [
      {
        trusted: { getter, signature }
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
    if (this.ws.onmessage) {
      return Promise.reject(new Error('worker can\'t handle parallel requests. please call getters sequentially'));
    } else {
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
  }

  getTotalIssuance (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'total_issuance'), parseBalance);
  }

  getParticipantCount (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'participant_count'), parseU64);
  }

  getCeremonyReward (cid) {
    return this.sendRequest(clientRequestGetter(cid, 'ceremony_reward'), parseBalanceType);
  }

  getBalance (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'balance'), parseBalance);
  }

  getRegistration (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'registration'), parseParticipantIndex);
  }

  getMeetupIndexTimeAndLocation (account, cid) {
    return this.sendRequest(clientRequestTrustedGetter(account, cid, 'meetup_index_time_and_location'), parseMeetupAssignment);
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
export function getBalance (pubKey, cid, password) {
  const keyPair = keyring.getPair(hexToU8a(pubKey));
  try {
    keyPair.decodePkcs8(password);
  } catch (err) {
    return new Promise((resolve, reject) => {
      resolve({ error: 'password check failed' });
    });
  }
  return useWorker(window.workerEndpoint).getBalance(keyPair, cid);
}

export default {
  useWorker,
  getBalance,
  createTyped
};
