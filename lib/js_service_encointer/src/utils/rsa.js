import { u8aToBuffer } from '@polkadot/util';
import NodeRSA from 'node-rsa';

const crypt = require('crypto');

const digestLength = {
  md4: 16,
  md5: 16,
  ripemd160: 20,
  rmd160: 20,
  sha1: 20,
  sha224: 28,
  sha256: 32,
  sha384: 48,
  sha512: 64
};

/**
 * Same implementation as node-rsa's but with a hardcoded hashFunction as node-rsa uses always the same
 * hashFunction for the mfg1 digest as for the encryption, which sgx might not do (unsure about this).
 * @param seed
 * @param maskLength
 * @param hashFunction
 * @returns {Buffer}
 */
export function mgf1 (seed, maskLength, hashFunction) {
  hashFunction = 'sha1';
  const hLen = digestLength[hashFunction];
  console.log('[Worker/mgf1]: Using hash: ' + hashFunction);
  console.log('[Worker/mgf1]: Hash length: ' + hLen);
  console.log('[Worker/mgf1]: Mask length: ' + maskLength);

  const count = Math.ceil(maskLength / hLen);
  const T = Buffer.alloc(hLen * count);
  const c = Buffer.alloc(4);
  for (let i = 0; i < count; ++i) {
    const hash = crypt.createHash(hashFunction);
    hash.update(seed);
    c.writeUInt32BE(i, 0);
    hash.update(c);
    hash.digest().copy(T, i * hLen);
  }
  return T.slice(0, maskLength);
}

export function nodeRsaParseRawJsonKey (keyJson) {
  keyJson.n = u8aToBuffer(keyJson.n);
  keyJson.e = u8aToBuffer(keyJson.e);
  console.log(keyJson);
  const key = new NodeRSA();
  key.setOptions({
    encryptionScheme: {
      scheme: 'pkcs1_oaep',
      hash: 'sha256',
      label: '',
      mgf: mgf1
    }
  });
  key.importKey({
    n: keyJson.n,
    e: keyJson.e
  }, 'components-public');
  return key;
}
