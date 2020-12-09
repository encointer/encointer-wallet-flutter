'use strict';

import '../../../src';

import NodeRSA from 'node-rsa';
import rsa from '../../../src/utils/rsa';
import { describe, it } from '@jest/globals';
import { bufferToU8a } from '@polkadot/util';
import io from '../../testUtils/io';

// note: for some reason the whole rsa section must be run to be able perform file io
describe('rsa', () => {
  describe('nodersa', () => {
    it('create key and encrypt', () => {
      /// After running this test, you should be able to decrypt the output file with:
      /// openssl pkeyutl -in cypher -decrypt -inkey priv -pkeyopt rsa_padding_mode:oaep -pkeyopt rsa_oaep_md:sha256 -pkeyopt rsa_mgf1_md:sha256
      ///
      /// Fixme: Using the same code to encrypt fails at decrypting inside the enclave with sgx_crypto_helpers
      const key = new NodeRSA({ b: 3072, e: 16777217 });
      key.setOptions(
        {
          encryptionScheme: {
            scheme: 'pkcs1_oaep',
            hash: 'sha256',
            label: ''
          }
        }
      );

      const keyPemPriv = key.exportKey('private');
      const keyPemPub = key.exportKey('public');
      io.writePrivKeyToFile(keyPemPriv);
      io.writePubKeyToFile(keyPemPub);

      const pubKey = rsa.nodeRsaPubKeyFromFile();
      const cypherText = pubKey.encrypt('hello_world');
      io.writeCypherTextToFile(bufferToU8a(cypherText));
    });
  });
});
