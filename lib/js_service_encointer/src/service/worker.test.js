import '../';
import { CustomTypes } from '../config/types';
import { useWorker } from './worker';
import { TypeRegistry } from '@polkadot/types/create/registry';
import { Keyring } from '@polkadot/api';
import { cryptoWaitReady } from '@polkadot/util-crypto';

describe('worker', () => {
  let keyring;
  let registry;
  beforeAll(async () => {
    jest.setTimeout(45000);
    keyring = new Keyring({ type: 'sr25519' });
    registry = new TypeRegistry();
    registry.register(CustomTypes);
    const query = {
      encointerScheduler: {
        currentPhase: jest.fn().mockImplementation(() => Promise.resolve(123))
      }
    };
    window.api = { registry, query };
    window.workerApi = useWorker('wss://substratee03.scs.ch');
  });

  describe('getters', () => {
    it('should getTotalIssuance', async () => {
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const result = await window.workerApi.getTotalIssuance(cid);
      expect(result).toBeDefined();
    });
  });

  it('should getBalance', async () => {
    await cryptoWaitReady();
    const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
    const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
    const result = await window.workerApi.getBalance(bob, cid);
    console.log(result);
    expect(result).toBeDefined();
  });

  it('should getRegistration', async () => {
    await cryptoWaitReady();
    const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
    const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
    const result = await window.workerApi.getRegistration(bob, cid);
    console.log(result);
    expect(result).toBeDefined();
  });

  it('should getMeetupIndexTimeAndLocation', async () => {
    await cryptoWaitReady();
    const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
    const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
    const result = await window.workerApi.getMeetupIndexTimeAndLocation(bob, cid);
    console.log(result);
    expect(result).toBeDefined();
  });

  it('should getAttestations', async () => {
    await cryptoWaitReady();
    const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
    const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
    const result = await window.workerApi.getAttestations(bob, cid);
    console.log(result);
    expect(result).toBeDefined();
  });
});
