'use strict';

import { getCurrencyIdentifiers } from '../src/service/encointer';
import account, { _sendTrustedTx } from '../src/service/account';
import { bufferToU8a, compactAddLength, hexToU8a, u8aToHex } from '@polkadot/util';
import { Keyring } from '@polkadot/api';
import '@babel/polyfill';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import { useWorker } from '../src/service/worker';
import settings from '../src/service/settings';
import * as bs58 from 'bs58';
import { createType } from '@polkadot/types';
import { getTrustedCall } from './testUtils/helpers';
import { beforeAll, describe, it, jest } from '@jest/globals';
import { cantillonNetwork, localDockerNetwork } from './testUtils/networks';
import { CustomTypes } from '../src/config/types';

describe('cantillon', () => {
  const network = localDockerNetwork();
  let keyring;
  let registry;

  beforeAll(async () => {
    jest.setTimeout(9000);
    window.send = (_, data) => console.log(data);
    keyring = new Keyring({ type: 'sr25519' });
    const customTypes = Object.assign({}, CustomTypes, network.customTypes);
    await settings.connect(network.chain, customTypes);
    registry = window.api.registry;
    await settings.setWorkerEndpoint(network.worker);
  });

  describe('on-chain', () => {
    describe('init api', () => {
      it('should get cantillon genesis hash', async () => {
        console.log('genesis hash: ' + api.genesisHash);
        expect(u8aToHex(api.genesisHash)).toBe(network.genesisHash);
      });
    });

    describe('getCurrencyIdentifiers method', () => {
      it('should return value', async () => {
        const result = await getCurrencyIdentifiers();
        const cidsBase58 = result.cids.map((cid) => bs58.encode(hexToU8a(cid.toString())));
        console.log(cidsBase58);
        expect(cidsBase58).toBeDefined();
      });
    });

    describe('accountgetBalances method', () => {
      it('should return balances', async () => {
        const address = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';
        const balances = await account.getBalance(address);
        console.log('Available Balance' + balances.availableBalance.toBigInt());
        expect(balances.availableBalance.toBigInt()).toBeGreaterThan(1);
      });
    });

    describe('sendFaucetTx method', () => {
      it('should send balance', async () => {
        jest.setTimeout(90000);
        const address = '5DPgv6nn4R1Gi1MUiAnzFDPaKF56SYKD9Zq4Q6REUGLhUZk1';
        const Ert001 = 1000000000;
        const result = await account.sendFaucetTx([address, Ert001]);
        console.log(result);
        expect(result).toBeDefined();
      });
    });
  });

  describe('worker', () => {
    describe('getWorkerPubKey method', () => {
      it('should return value', async () => {
        const result = await useWorker(network.worker).getShieldingKey();
        expect(result).toBeDefined();
      });
    });

    describe('substratee call_worker', () => {
      it('registerParticipant works', async () => {
        await cryptoWaitReady();
        // const result = await encointer.getCurrentPhase();
        // assert(result.phase.isRegistering);

        const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
        const callEncoded = getTrustedCall(alice, registry, network).toArray();
        expect(callEncoded.length).toBeLessThan(window.workerShieldingKey.getMaxMessageSize());

        const cypherTextBuffer = window.workerShieldingKey.encrypt(callEncoded);
        console.log('cyphertext buffer:\n ' + bufferToU8a(cypherTextBuffer));

        const c = createType(registry, 'Vec<u8>', compactAddLength(cypherTextBuffer));
        console.log('cyphertext:\n  ' + c);
        console.log('cypherU8a: (first two bytes belong to the type registry) \n  ' + c.toU8a());

        const txRes = await _sendTrustedTx(alice, network.chosenCid, c);
        console.log(txRes);

        const participantIndex = await useWorker(window.workerEndpoint).getRegistration(alice, network.chosenCid);
        expect(participantIndex.toNumber()).toBeGreaterThan(0);
      });

      describe('getParticipantCount method', () => {
        it('should return value', async () => {
          const result = await useWorker(network.worker).getParticipantCount(network.chosenCid);
          expect(result.toNumber()).toBe(0);
        });
      });
    });
  });
});
