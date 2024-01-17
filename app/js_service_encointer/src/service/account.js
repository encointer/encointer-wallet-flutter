import { cryptoWaitReady, mnemonicGenerate } from '@polkadot/util-crypto';
import {
  hexToU8a,
  u8aToHex,
} from '@polkadot/util';
import BN from 'bn.js';
import { Keyring } from '@polkadot/keyring';
import { communityIdentifierFromString } from '@encointer/util';
import {
  encointerBalances,
  transfer
} from '../config/consts.js';
import { extractEvents } from '@encointer/node-api';
import { stringNumberToEncointerBalanceU8a } from '../utils/utils.js';

export const keyring = new Keyring({ ss58Format: 0, type: 'sr25519' });

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
      }
    } catch (err) {
      resolve({ error: err.message });
    }
    if (keyPair.address) {
      const json = keyPair.toJson();
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

export async function txFeeEstimate (txInfo, paramList) {
  if (txInfo.module === 'encointerBalances' && txInfo.call === 'transfer') {
    paramList[1] = communityIdentifierFromString(api.registry, paramList[1]);
    paramList[2] = stringNumberToEncointerBalanceU8a(paramList[2]);
  }

  return api.tx[txInfo.module][txInfo.call](...paramList)
    .paymentInfo(txInfo.address);
}
export function sendTx (txInfo, paramList) {
  const keyPair = keyring.getPair(hexToU8a(txInfo.pubKey));
  return sendTxWithPair(keyPair, txInfo, paramList);
}

/**
 *  SendTx function that accepts a ready to sign keypair.
 */
export function sendTxWithPair (keyPair, txInfo, paramList) {
  let balanceHuman;

  if (txInfo.module === encointerBalances && txInfo.call === transfer) {
    balanceHuman = paramList[2];
  }

  return _getXt(keyPair, txInfo, paramList)
    .then(function (tx) {
      // The promise syntax is necessary because we need fine-grained control over when the overarching
      // future returns based on what happens within the `onStatusChange` callback. I could not find another
      // solution.
      return new Promise((resolve) => {
        let unsub = () => {};
        const onStatusChange = (result) => {
          if (result.status.isInBlock || result.status.isFinalized) {
            const {
              success,
              error
            } = extractEvents(api, result);
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

        tx.send(onStatusChange)
          .then((res) => {
            unsub = res;
          })
          .catch((err) => {
            resolve({ error: err.message });
          });
      });
    }).catch((err) => {
      return { error: err.message };
    });
}

export async function getXt (txInfo, paramList){
  const keyPair = keyring.getPair(hexToU8a(txInfo.pubKey));
  // The dart<>JS interface expects a map.
  return { xt: await _getXt(keyPair, txInfo, paramList) };
}

/**
 *  Creates an extrinsic and signs it if the txInfo says so.
 */
export async function _getXt (keyPair, txInfo, paramList) {
  if (txInfo.module === encointerBalances && txInfo.call === transfer) {
    paramList[2] = stringNumberToEncointerBalanceU8a(paramList[2]);
  }

  console.log(`[js-account/getMaybeSignedXt]: txInfo ${JSON.stringify(txInfo)}`);
  console.log(`[js-account/getMaybeSignedXt]: Params ${JSON.stringify(paramList)}`);

  const tx = api.tx[txInfo.module][txInfo.call](...paramList);

  if (txInfo.isUnsigned) {
    return tx;
  }

  console.log(`[js-account/getMaybeSignedXt]: Adding tip: ${txInfo.tip}`);
  const signerOptions = {
    tip: new BN(txInfo.tip || 0, 10)
  };

  console.log(`[js-account/getMaybeSignedXt]: Adding payment asset ${JSON.stringify(txInfo.txPaymentAsset)}`);
  if (txInfo.txPaymentAsset != null) {
    signerOptions.assetId = api.createType(
      'Option<CommunityIdentifier>', txInfo.txPaymentAsset
    );
  }

  console.log(`[js-account/getMaybeSignedXt]: ${JSON.stringify(txInfo)}`);
  console.log(`[js-account/getMaybeSignedXt]: ${JSON.stringify(signerOptions)}`);

  return tx.signAsync(keyPair, signerOptions);
}

export default {
  initKeys,
  recover,
  txFeeEstimate,
  sendTx,
  sendTxWithPair,
  getXt,
};
