/**
 * @jest-environment jsdom
 */

'use strict';

import account from '../src/service/account';
import { u8aToHex } from '@polkadot/util';
import { gesellNetwork } from './testUtils/networks';

import { testSetup } from './testUtils/testSetup';
import {
  getAllFaucetAccounts,
  getAllFaucetsWithAccount,
  getFaucetFor,
  hasCommittedFor
} from '../src/service/faucet.js';
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

  describe('accountgetBalances method', () => {
    it('should return balances', async () => {
      const address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
      const balances = await account.getBalance(address);
      console.log(balances);
      expect(balances.availableBalance.gtn(1));
    });
  });

  describe('sendFaucetTx method', () => {
    it('should send balance', async () => {
      const address = '5DPgv6nn4R1Gi1MUiAnzFDPaKF56SYKD9Zq4Q6REUGLhUZk1';
      const Ert001 = 1000000000;
      const result = await account.sendFaucetTx(address, Ert001);
      console.log(result);
      expect(result).toBeDefined();
    }, 90000);
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

  describe('encointerFaucet', () => {
    it('Should get faucet accounts', async () => {
      const accounts = await getAllFaucetAccounts();
      expect(accounts.toString()).toBe('5CTxhG3NJjhwti8kQRR9FYTT53Jq41We3MHdoJZa4RymAKhq,5Dq3XugU1atZM8QGHxg2KfZahm2CzuBUDp8XyxL9wn8Q8Yx3');
    });

    it('Should get faucet for a faucet account', async () => {
      const accounts = await getAllFaucetAccounts();
      console.log(`Faucet ${accounts}`);

      const faucet = await getFaucetFor(accounts[0]);
      console.log(`Faucet ${faucet.toString()}`);

      const expectedFaucet = {
        creator: '5HdLw7t5LjjZ9vSeFiYRbcJf6uFX9xqzv3QappFBy9P8pR9e',
        dripAmount: 5000000000000,
        name: '0x466175636574466f724d7942756464696573',
        purposeId: 1,
        whitelist: [{
          digest: '0xbaa9744a',
          geohash: '0x6535647674'
        }, {
          digest: '0x2b2f978b',
          geohash: '0x6470636d35'
        }]
      };

      expect(faucet.toJSON()).toStrictEqual(expectedFaucet);
    });

    it('Should get all faucets', async () => {
      const wellKnownFaucetAccount = '5CTxhG3NJjhwti8kQRR9FYTT53Jq41We3MHdoJZa4RymAKhq';
      const wellKnownFaucet = {
        creator: '5HdLw7t5LjjZ9vSeFiYRbcJf6uFX9xqzv3QappFBy9P8pR9e',
        dripAmount: 5000000000000,
        name: '0x466175636574466f724d7942756464696573',
        purposeId: 1,
        whitelist: [{
          digest: '0xbaa9744a',
          geohash: '0x6535647674'
        }, {
          digest: '0x2b2f978b',
          geohash: '0x6470636d35'
        }]
      };

      const faucets = await getAllFaucetsWithAccount();
      console.log(`faucets ${JSON.stringify(faucets)}`);

      expect(faucets[wellKnownFaucetAccount].toJSON()).toStrictEqual(wellKnownFaucet);
    });

    it('Should confirm no commitment', async () => {
      const someAccount = '5CTxhG3NJjhwti8kQRR9FYTT53Jq41We3MHdoJZa4RymAKhq';
      const someCid = '0xf26bfaa0feee0968ec0637e1933e64cd1947294d3b667d43b76b3915fc330b53';
      const hasCommitted = await hasCommittedFor(someCid, 0, 0, someAccount);
      expect(hasCommitted).toBeFalsy();
    });

    it.skip('Should confirm commitment', async () => {
      // before this test we need to actually have unused reputation for tha testCIndex.
      const alpha = '5FyWbcwN1TGPdyzRzoEeem3MUcc7jXRs7ZoftZkAQLV47nS7';
      const adriana = { geohash: '0x7372637134', digest: '0xabb12168' };
      const testCIndex = 187;
      const testPurposeId = 0;
      const hasCommitted = await hasCommittedFor(adriana, testCIndex, testPurposeId, alpha);
      expect(hasCommitted).toBeTruthy();
    });
  });
});
