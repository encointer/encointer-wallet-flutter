import { cryptoWaitReady, mnemonicGenerate } from '@polkadot/util-crypto';
import {
  hexToU8a,
  u8aToHex,
  hexToString,
  assert,
  u8aToBuffer,
  bufferToU8a,
  compactAddLength,
  bnToU8a
} from '@polkadot/util';
import BN from 'bn.js';
import { Keyring } from '@polkadot/keyring';
import { createType } from '@polkadot/types';
import { communityIdentifierFromString } from '@encointer/util';
import { TrustedCallMap } from '../config/trustedCall.js';
import { base58Decode } from '@polkadot/util-crypto/base58/bs58';
import {
  callWorker,
  claimRewards,
  encointerBalances,
  encointerCeremonies, parachainSpecName, solochainSpecName,
  substrateeRegistry,
  transfer
} from '../config/consts.js';
import { unsubscribe } from '../utils/unsubscribe.js';
import settings from './settings.js';
import { stringToEncointerBalance } from '@encointer/types';
import { extractEvents } from '@encointer/node-api';

export const keyring = new Keyring({ ss58Format: 0, type: 'sr25519' });

async function gen () {
  await cryptoWaitReady();
  return new Promise((resolve) => {
    const key = mnemonicGenerate();
    resolve({
      mnemonic: key
    });
  });
}

async function recover (keyType, cryptoType, key, password) {
  await cryptoWaitReady();
  return new Promise((resolve, reject) => {
    let keyPair = {};
    let mnemonic = '';
    let rawSeed = '';
    try {
      switch (keyType) {
        case 'mnemonic':
          keyPair = keyring.addFromMnemonic(key, {}, cryptoType);
          mnemonic = key;
          break;
        case 'rawSeed':
          keyPair = keyring.addFromUri(key, {}, cryptoType);
          rawSeed = key;
          break;
        case 'keystore':
          const keystore = JSON.parse(key);
          keyPair = keyring.addFromJson(keystore);
          try {
            keyPair.decodePkcs8(password);
          } catch (err) {
            resolve(null);
          }
          resolve({
            pubKey: u8aToHex(keyPair.publicKey),
            ...keyPair.toJson(password)
          });
          break;
      }
    } catch (err) {
      resolve({ error: err.message });
    }
    if (keyPair.address) {
      const json = keyPair.toJson(password);
      keyPair.lock();
      // try add to keyring again to avoid no encrypted data bug
      keyring.addFromJson(json);
      resolve({
        pubKey: u8aToHex(keyPair.publicKey),
        mnemonic,
        rawSeed,
        ...json
      });
    } else {
      resolve(null);
    }
  });
}

/**
 * Import accounts in to the `keyring` that can be used to
 * sign extrinsics from then on.
 *
 * @param {List<Keystore>} accounts
 */
async function initKeys (accounts) {
  await cryptoWaitReady();
  accounts.forEach((i) => keyring.addFromJson(i));
}

async function addressFromUri(uri) {
  const voucherPair = keyring.createFromUri(uri);
  const pubKey = voucherPair.publicKey;
  const ss58 = api.registry.getChainProperties().ss58Format

  console.log(`[AddressFromUri] uri: ${uri}`);
  console.log(`[AddressFromUri] ss58: ${ss58}`);

  return keyring.encodeAddress(pubKey, ss58);
}

/**
 * get ERT balance of an address
 * @param {String} address
 * @returns {String} balance
 */
async function getBalance (address) {
  const all = await api.derive.balances.all(address);
  const lockedBreakdown = all.lockedBreakdown.map((i) => {
    return {
      ...i,
      use: hexToString(i.id.toHex())
    };
  });
  return {
    ...all,
    lockedBreakdown
  };
}

/**
 * subscribes to ERT balance of an address
 * @param msgChannel channel that the message handler uses on the dart side
 * @param {String} address
 * @returns {String} balance
 */
async function subscribeBalance (msgChannel, address) {
  return await api.derive.balances.all(address, (all) => {
    const lockedBreakdown = all.lockedBreakdown.map((i) => {
      return {
        ...i,
        use: hexToString(i.id.toHex())
      };
    });
    send(msgChannel, {
      ...all,
      lockedBreakdown
    });
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

function getBlockTime (blocks) {
  return new Promise((resolve) => {
    const res = [];
    Promise.all(
      blocks.map((i) => {
        res[res.length] = { id: i };
        return api.rpc.chain.getBlockHash(i);
      })
    )
      .then((hashs) =>
        Promise.all(
          hashs.map((i, index) => {
            res[index].hash = i.toHex();
            return api.query.timestamp.now.at(i.toHex());
          })
        )
      )
      .then((times) => {
        times.forEach((i, index) => {
          res[index].timestamp = i.toNumber();
        });
        resolve(JSON.stringify(res));
      });
  });
}

export async function txFeeEstimate (txInfo, paramList) {
  if (txInfo.module === 'encointerBalances' && txInfo.call === 'transfer') {
    paramList[1] = communityIdentifierFromString(api.registry, paramList[1]);
    paramList[2] = bnToU8a(stringToEncointerBalance(paramList[2]), 128, true);
  }

  let dispatchInfo;
  if (settings.connectedToTeeProxy() && TrustedCallMap[txInfo.module][txInfo.call] !== null) {
    if (isTcIsRegisterAttestations(txInfo)) {
      // todo: in a meetup with more than 3 people this is longer. calculate actual size based on message length.
      dispatchInfo = dispatchInfo = api.tx[substrateeRegistry][callWorker](new Array(768))
        .paymentInfo(txInfo.address);
    } else {
      dispatchInfo = api.tx[substrateeRegistry][callWorker](new Array(384))
        .paymentInfo(txInfo.address);
    }
  } else {
    dispatchInfo = await api.tx[txInfo.module][txInfo.call](...paramList)
      .paymentInfo(txInfo.address);
  }
  return dispatchInfo;
}

function isTcIsRegisterAttestations (txInfo) {
  return TrustedCallMap[txInfo.module][txInfo.call] === 'ceremonies_register_attestations';
}

export function sendTx (txInfo, paramList) {
  const keyPair = keyring.getPair(hexToU8a(txInfo.pubKey));
  try {
    keyPair.decodePkcs8(txInfo.password);
  } catch (err) {
    return new Promise((resolve, reject) => {
      resolve({ error: 'password check failed' });
    });
  }

  if (settings.connectedToTeeProxy() && TrustedCallMap[txInfo.module][txInfo.call] !== null) {
    return _sendTrustedTx(keyPair, txInfo, paramList);
  }

  return sendTxWithPair(keyPair, txInfo, paramList);
}

/**
 *  SendTx function that accepts a ready to sign keypair.
 */
export function sendTxWithPair (keyPair, txInfo, paramList) {
  return new Promise((resolve) => {
    let unsub = () => {};
    let balanceHuman;

    if (txInfo.module === encointerBalances && txInfo.call === transfer) {
      balanceHuman = paramList[2];
      paramList[2] = bnToU8a(stringToEncointerBalance(paramList[2]), 128, true);
    }

    const tx = api.tx[txInfo.module][txInfo.call](...paramList);
    const onStatusChange = (result) => {
      if (result.status.isInBlock || result.status.isFinalized) {
        const { success, error } = extractEvents(api, result);
        if (success) {
          if (txInfo.module === encointerBalances && txInfo.call === transfer) {
            // make transfer amount human-readable again
            paramList[2] = balanceHuman;
          }

          resolve({
            hash: tx.hash.toString(),
            time: new Date().getTime(),
            params: paramList
          });
        }
        if (error) {
          resolve({ error });
        }
        unsub();
      } else {
        window.send('txStatusChange', result.status.type);
      }
    };
    if (txInfo.isUnsigned) {
      tx.send(onStatusChange)
        .then((res) => {
          unsub = res;
        })
        .catch((err) => {
          resolve({ error: err.message });
        });
      return;
    }

    const signerOptions = {
      tip: new BN(txInfo.tip, 10)
    }

    if (txInfo.txPaymentAsset != null) {
      signerOptions.assetId = api.createType(
        'Option<CommunityIdentifier>', txInfo.txPaymentAsset
        )
    }

    console.log(`[js-account/sendTx]: ${JSON.stringify(txInfo)}`)
    console.log(`[js-account/sendTx]: ${JSON.stringify(signerOptions)}`)

    tx.signAndSend(keyPair, signerOptions, onStatusChange)
      .then((res) => {
        unsub = res;
      })
      .catch((err) => {
        resolve({ error: err.message });
      });
  });
}

export function _sendTrustedTx (keyPair, txInfo, paramList) {
  const cid = api.createType('CommunityIdentifier', txInfo.cid);
  window.send('js-trustedTx', 'sending trusted tx for cid: ' + cid);

  const mrenclave = api.createType('Hash', base58Decode(window.mrenclave));

  const nonce = api.createType('u32', 0);
  const call = createTrustedCall(
    keyPair,
    cid,
    mrenclave,
    nonce,
    TrustedCallMap[txInfo.module][txInfo.call],
    [keyPair.publicKey, ...paramList]
  );

  const cypherTextBuffer = window.workerShieldingKey.encrypt(u8aToBuffer(call.toU8a()));
  const cypherArray = bufferToU8a(cypherTextBuffer);
  const c = api.createType('Vec<u8>', compactAddLength(cypherArray));
  console.log('Encrypted trusted call. Length: ' + cypherArray.length);

  const txParams = [api.createType('Request', {
    shard: api.createType('ShardIdentifier', txInfo.cid),
    cyphertext: c
  })];

  console.log('txParams: ' + txParams);
  const txInfoCallWorker = {
    module: substrateeRegistry,
    call: callWorker,
    tip: 0
  };
  return sendTxWithPair(keyPair, txInfoCallWorker, txParams);
}

export function createTrustedCall (account, cid, mrenclave, nonce, trustedCall, params) {
  const tCallType = api.registry.knownTypes.types.TrustedCall._enum[trustedCall];
  assert(tCallType !== undefined, `Unknown trusted call: ${trustedCall}`);

  console.log(`TrustedCall: ${tCallType}`);

  const call = createType(api.registry, 'TrustedCall', {
    [trustedCall]: createType(api.registry, tCallType, params)
  });

  const payload = [...call.toU8a(), ...nonce.toU8a(), ...mrenclave.toU8a(), ...cid.toU8a()];

  return createType(api.registry, 'TrustedCallSigned', {
    call: call,
    nonce: nonce,
    signature: account.sign(payload)
  });
}

export function sendFaucetTx (address, amount) {
  const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
  const paramList = [address, amount];
  const txInfo = {
    module: 'balances',
    call: 'transfer',
    tip: 0
  };
  return sendTxWithPair(alice, txInfo, paramList);
}

function checkPassword (pubKey, pass) {
  return new Promise((resolve) => {
    const keyPair = keyring.getPair(hexToU8a(pubKey));
    try {
      if (!keyPair.isLocked) {
        keyPair.lock();
      }
      keyPair.decodePkcs8(pass);
    } catch (err) {
      resolve(null);
    }
    resolve({ success: true });
  });
}

function changePassword (pubKey, passOld, passNew) {
  const u8aKey = hexToU8a(pubKey);
  return new Promise((resolve) => {
    const keyPair = keyring.getPair(u8aKey);
    try {
      if (!keyPair.isLocked) {
        keyPair.lock();
      }
      keyPair.decodePkcs8(passOld);
    } catch (err) {
      resolve(null);
    }
    const json = keyPair.toJson(passNew);
    keyring.removePair(u8aKey);
    keyring.addFromJson(json);
    resolve({
      pubKey: u8aToHex(keyPair.publicKey),
      ...json
    });
  });
}

export default {
  initKeys,
  addressFromUri,
  gen,
  recover,
  getBalance,
  subscribeBalance,
  getBlockTime,
  txFeeEstimate,
  sendTx,
  sendTxWithPair,
  sendFaucetTx,
  checkPassword,
  changePassword,
};
