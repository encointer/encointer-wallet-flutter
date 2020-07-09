import '../';
import { CustomTypes } from '../config/types';
import { useWorker } from './worker';
import { TypeRegistry } from '@polkadot/types/create/registry';
import { Keyring } from '@polkadot/api';
import { cryptoWaitReady } from '@polkadot/util-crypto';

describe('worker', () => {
  const WORKER_URL = 'wss://substratee03.scs.ch';
  let keyring;
  let registry;
  beforeAll(async () => {
    jest.setTimeout(90000);
    keyring = new Keyring({ type: 'sr25519' });
    registry = new TypeRegistry();
    registry.register(CustomTypes);
    const query = {
      encointerScheduler: {
        currentPhase: jest.fn().mockImplementation(() => Promise.resolve(123))
      }
    };
    window.api = { registry, query };
  });

  describe('getTotalIssuance method', () => {
    it('should return value', async () => {
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const result = await useWorker(WORKER_URL).getTotalIssuance(cid);
      console.log('getTotalIssuance', result);
      expect(result).toBeDefined();
    });
  });

  describe('getBalance method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker(WORKER_URL).getBalance(bob, cid);
      console.log('getBalance', result);
      expect(result).toBeDefined();
    });
  });

  describe('getRegistration method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker(WORKER_URL).getRegistration(bob, cid);
      console.log('getRegistration', result);
      expect(result).toBeDefined();
    });
  });

  describe('getMeetupIndexTimeAndLocation method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker('wss://substratee03.scs.ch').getMeetupIndexTimeAndLocation(bob, cid);
      console.log('getMeetupIndexTimeAndLocation', result);
      expect(result).toBeDefined();
    });
  });

  describe('getAttestations method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker('wss://substratee03.scs.ch').getAttestations(bob, cid);
      console.log(result);
      expect(result).toBeDefined();
    });
  });
});
