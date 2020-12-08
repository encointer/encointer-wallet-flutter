'use strict';

import '../../../src';

import NodeRSA from 'node-rsa';
import rsa from '../../../src/utils/rsa';
import { getTrustedCall, localDockerNetwork } from '../../testHelpers';
import { Keyring } from '@polkadot/api';
import settings from '../../../src/service/settings';
import { beforeAll, describe, it, jest } from '@jest/globals';
import { bufferToU8a } from '@polkadot/util';

describe('rsa', () => {
  const network = localDockerNetwork();
  let keyring;
  let registry;

  beforeAll(async () => {
    jest.setTimeout(9000);
    window.send = (_, data) => console.log(data);
    keyring = new Keyring({ type: 'sr25519' });
    await settings.connect(network.chain);
    registry = window.api.registry;
    await settings.setWorkerEndpoint(network.worker);
  });

  describe('nodersa', () => {
    it('create and save key', () => {
      const key = new NodeRSA({ b: 3072, e: 16777217 });
      rsa.setKeyOpts(key);
      const keyPemPriv = key.exportKey('private');
      const keyPemPub = key.exportKey('public');
      rsa.writePrivKey(keyPemPriv);
      rsa.writePubKey(keyPemPub);
    });

    it('encrypt trusted call', () => {
      /// After running this test, you should be able to decrypt the output file with:
      /// openssl pkeyutl -in cypher -decrypt -inkey priv -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256
      ///
      const pubKey = rsa.nodeRsaPubKeyFromFile();
      console.log('pubkey' + pubKey);
      const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const call = getTrustedCall(alice, registry, network).toArray();

      const cypherText = pubKey.encrypt(call);
      console.log('cyphertext: ' + cypherText);
      console.log('cyphertext: ' + cypherText.length);
      rsa.writeCypherText(bufferToU8a(cypherText));
    });
  });
});
