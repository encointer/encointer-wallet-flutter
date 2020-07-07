'use strict';

import { CustomTypes } from './config/types';
import encointer, {
  getProofOfAttendance,
  getClaimOfAttendance,
  parseClaimOfAttendance,
  parseAttestation
} from './service/encointer';
import { hexToU8a, u8aToHex } from '@polkadot/util';
import { ApiPromise, Keyring } from '@polkadot/api';
import * as types from '@polkadot/types';
import { createType } from '@polkadot/types';
import * as bs58 from 'bs58';
import { WsProvider } from '@polkadot/rpc-provider';
import '@babel/polyfill';

describe('encointer', () => {
  let keyring;
  let registry;
  beforeAll(async () => {
    keyring = new Keyring({ type: 'sr25519' });
    registry = new types.TypeRegistry();
    registry.register(CustomTypes);
    await connect('wss://gesell.encointer.org');
  });

  describe('init api', () => {
    it('should fetch gesell genesis hash', async () => {
      console.log('genesis hash: ' + api.genesisHash);
      const gesellGenesisHash = '0x5accb06aae14470d4f0e8ecd7330350ed5d14262e54770bbd548b87ff90b8cef';
      expect(u8aToHex(api.genesisHash)).toBe(gesellGenesisHash);
      // assert(true);
    });
  });
});

/**
 * Same as index.js
 * @param endpoint
 * @returns {Promise<unknown>}
 */
async function connect (endpoint) {
  return new Promise(async (resolve, reject) => {
    const provider = new WsProvider(endpoint);
    try {
      window.api = await ApiPromise.create({
        provider,
        types: CustomTypes
      });
      console.log(`${endpoint} wss connected success`);
      resolve(endpoint);
    } catch (err) {
      console.error(`${endpoint} wss connected failed`);
      provider.disconnect();
      resolve(null);
    }
  });
}
