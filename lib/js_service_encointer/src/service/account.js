import { cryptoWaitReady, mnemonicGenerate } from '@polkadot/util-crypto';
import {
  hexToU8a,
  u8aToHex,
  hexToString,
} from '@polkadot/util';
import { ss58Decode } from 'oo7-substrate/src/ss58.js';
import { unsubscribe } from '../utils/unsubscribe.js';
import { keyring, devKeyring} from './keyrings.js';
import { sendFaucetTx, sendTx, sendTxWithPair, txFeeEstimate } from './extrinsics.js';

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

async function addToDevKeyring (keyType, cryptoType, seedOrMnemonic) {
  await cryptoWaitReady();
  return new Promise((resolve, reject) => {
    let keyPair = {};
    let mnemonic = '';
    let rawSeed = '';
    try {
      switch (keyType) {
        case 'mnemonic':
          keyPair = devKeyring.addFromMnemonic(seedOrMnemonic, {}, cryptoType);
          mnemonic = seedOrMnemonic;
          break;
        case 'rawSeed':
          keyPair = devKeyring.addFromUri(seedOrMnemonic, {}, cryptoType);
          rawSeed = seedOrMnemonic;
          break;
      }
    } catch (err) {
      resolve({ error: err.message });
    }
    if (keyPair.address) {
      resolve({
        pubKey: u8aToHex(keyPair.publicKey),
        mnemonic,
        rawSeed,
      });
    } else {
      resolve(null);
    }
  });
}


/**
 * Add user's accounts to keyring,
 * so user can use them to sign txs with password.
 * We use a list of ss58Formats to encode the accounts
 * into different address formats for different networks.
 *
 * @param {List<Keystore>} accounts
 * @param {List<int>} ss58Formats
 * @returns {Map<String, String>} pubKeyAddressMap
 */
async function initKeys (accounts, ss58Formats) {
  await cryptoWaitReady();
  return _initKeys(keyring, accounts, ss58Formats)
}

async function initKeysDev (accounts, ss58Formats) {
  await cryptoWaitReady();
  return _initKeys(devKeyring, accounts, ss58Formats)
}

function _initKeys(keyring, accounts, ss58Formats) {
  const res = {};
  ss58Formats.forEach((ss58) => {
    res[ss58] = {};
  });

  accounts.forEach((i) => {
    // import account to keyring
    const keyPair = keyring.addFromJson(i);
    // then encode address into different ss58 formats
    ss58Formats.forEach((ss58) => {
      const pubKey = u8aToHex(keyPair.publicKey);
      res[ss58][pubKey] = keyring.encodeAddress(keyPair.publicKey, ss58);
    });
  });
  return res;
}

/**
 * Decode address to it's publicKey
 * @param {List<String>} addresses
 * @returns {Map<String, String>} pubKeyAddressMap
 */
async function decodeAddress (addresses) {
  await cryptoWaitReady();
  try {
    const res = {};
    addresses.forEach((i) => {
      const pubKey = u8aToHex(keyring.decodeAddress(i));
      res[pubKey] = i;
    });
    return res;
  } catch (err) {
    send('log', { error: err.message });
    return null;
  }
}

/**
 * encode pubKey to addresses with different prefixes
 * @param {List<String>} pubKeys
 * @returns {Map<String, String>} pubKeyAddressMap
 */
async function encodeAddress (pubKeys, ss58Formats) {
  await cryptoWaitReady();
  const res = {};
  ss58Formats.forEach((ss58) => {
    res[ss58] = {};
    pubKeys.forEach((i) => {
      res[ss58][i] = keyring.encodeAddress(hexToU8a(i), ss58);
    });
  });
  return res;
}

async function addressFromUri(uri) {
  const voucherPair = keyring.createFromUri(uri);
  const pubKey = voucherPair.publicKey;
  const ss58 = api.registry.getChainProperties().ss58Format

  console.log(`[AddressFromUri] uri: ${uri}`);
  console.log(`[AddressFromUri] ss58: ${ss58}`);

  return keyring.encodeAddress(pubKey, ss58);
}

async function queryAddressWithAccountIndex (accIndex, ss58) {
  const num = ss58Decode(accIndex, ss58).toJSON();
  const res = await api.query.indices.accounts(num.data);
  return res;
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

function getAccountIndex (addresses) {
  return api.derive.accounts.indexes().then((res) => {
    return Promise.all(addresses.map((i) => api.derive.accounts.info(i)));
  });
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
  initKeysDev,
  addToDevKeyring,
  addressFromUri,
  encodeAddress,
  decodeAddress,
  queryAddressWithAccountIndex,
  gen,
  recover,
  getBalance,
  subscribeBalance,
  getAccountIndex,
  checkPassword,
  changePassword,
  txFeeEstimate,
  sendTx,
  sendTxWithPair,
  sendFaucetTx,
};
