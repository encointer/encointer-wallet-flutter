import { u8aToBuffer } from '@polkadot/util';
import NodeRSA from 'node-rsa';

function nodeRsaParseRawJsonKey (keyJson) {
  keyJson.n = u8aToBuffer(keyJson.n).reverse();
  keyJson.e = u8aToBuffer(keyJson.e).reverse();
  const key = new NodeRSA();
  setKeyOpts(key);
  key.importKey({
    n: keyJson.n,
    e: keyJson.e
  }, 'components-public');
  return key;
}

function setKeyOpts (key) {
  key.setOptions(
    {
      encryptionScheme: {
        scheme: 'pkcs1_oaep',
        hash: 'sha256',
        label: ''
      }
    }
  );
}

export default {
  nodeRsaParseRawJsonKey,
  setKeyOpts
};
