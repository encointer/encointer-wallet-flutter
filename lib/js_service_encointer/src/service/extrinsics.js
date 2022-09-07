import {
  hexToU8a,
  assert,
  u8aToBuffer,
  bufferToU8a,
  compactAddLength,
  bnToU8a
} from '@polkadot/util';
import BN from 'bn.js';
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
import settings from './settings.js';
import { stringToEncointerBalance } from '@encointer/types';
import { extractEvents } from '@encointer/node-api';

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
  let keyPair = keyring.getPair(hexToU8a(txInfo.pubKey));
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

    if (txInfo.module === encointerCeremonies && txInfo.call === claimRewards && hasNewClaimRewardsExtrinsic()) {
      // add meetup index none to params for compatibility with newer runtimes
      paramList[1] = null;
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

function hasNewClaimRewardsExtrinsic() {
  console.log(`Api:Runtime Spec Name: ${api.runtimeVersion.specName}`);
  console.log(`Api:Runtime Spec version: ${api.runtimeVersion.specVersion}`);

  return (api.runtimeVersion.specName.toString() === parachainSpecName && api.runtimeVersion.specVersion >= 8) ||
    (api.runtimeVersion.specName.toString() === solochainSpecName && api.runtimeVersion.specVersion >= 18);
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
