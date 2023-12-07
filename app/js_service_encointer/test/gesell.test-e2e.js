/**
 * @jest-environment jsdom
 */

'use strict';

import account from '../src/service/account';
import { u8aToHex } from '@polkadot/util';
import { gesellNetwork } from './testUtils/networks';

import { testSetup } from './testUtils/testSetup';
import { beforeAll, describe, expect, it } from '@jest/globals';

describe('encointer', () => {
  const network = gesellNetwork();
  let api;
  beforeAll(async () => {
    const setup = await testSetup(network);
    api = setup.api;
  }, 90000);

  describe('init api', () => {
    it('should get gesell genesis hash', async () => {
      console.log('genesis hash: ' + api.genesisHash);
      expect(u8aToHex(api.genesisHash)).toBe(network.genesisHash);
    });
  });

  // Tests if the runtime is able to correctly interpret the extrinsic
  describe('get tx fee estimate', () => {
    it('should get fees for register_participant', async () => {
      const txInfo = {
        module: 'encointerCeremonies',
        call: 'registerParticipant',
        address: '5DPgv6nn4R1Gi1MUiAnzFDPaKF56SYKD9Zq4Q6REUGLhUZk1',
        pubKey: '0x3ab6baa11d0fcb81ae3e838e263de9524d7c64bb88d99629af68749d6a7ac023',
        password: '123qwe'
      };
      const param = ['0xf26bfaa0feee0968ec0637e1933e64cd1947294d3b667d43b76b3915fc330b53', null];

      const res = await account.txFeeEstimate(txInfo, param);
      expect(res.weight).toBeDefined();
    });
  });

  describe('can transform problematic location', () => {
    it('should be defined', async () => {
      const loc_js = {
        lat: '0x000000000000001987d96638433d0000',
        lon: '0xffffffffffffffe72ff3493858360000'
      };

      const loc = await api.createType('Location', loc_js);

      console.log(`Loc Object ${loc}`);

      expect(loc).toBeDefined();
    });
  });
});
