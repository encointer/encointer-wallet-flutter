import '../../src';
import { CustomTypes } from '../../src/config/types';
import { useWorker } from '../../src/service/worker';
import { TypeRegistry } from '@polkadot/types/create/registry';
import { Keyring } from '@polkadot/api';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import { createType } from '@polkadot/types';
import { hexToU8a, u8aToBn } from '@polkadot/util';
import { parseI64F64 } from '../../src/utils/fixpointUtil';
import { cantillonNetwork } from '../utils';

describe('worker', () => {
  const network = cantillonNetwork();
  let keyring;
  let registry;
  beforeAll(async () => {
    jest.setTimeout(90000);
    window.send = (_, data) => console.log(data);
    keyring = new Keyring({ type: 'sr25519' });
    registry = new TypeRegistry();
    registry.register(CustomTypes);
    window.api = { registry };
    window.workerEndpoint = network.worker;
  });

  describe('getWorkerPubKey method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getShieldingKey();
      expect(result).toBeDefined();
    });
  });

  describe('getTotalIssuance method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getTotalIssuance(network.chosenCid);
      console.log('getTotalIssuance', result);
      expect(result).toBeDefined();
    });
  });

  describe('getParticipantCount method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getParticipantCount(network.chosenCid);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getMeetupCount method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getMeetupCount(network.chosenCid);
      console.log('getMeetupCount', result);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getCeremonyReward method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getCeremonyReward(network.chosenCid);
      console.log('ceremonyReward', result);
      expect(result).toBe(1);
    });
  });

  describe('getLocationTolerance method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getLocationTolerance(network.chosenCid);
      expect(result.toNumber()).toBe(1000);
    });
  });

  describe('getTimeTolerance method', () => {
    it('should return value', async () => {
      const result = await useWorker(network.worker).getTimeTolerance(network.chosenCid);
      expect(result.toNumber()).toBe(600000);
    });
  });

  describe('getBalance method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker(network.worker).getBalance(bob, network.chosenCid);
      console.log('getBalance', result);
      expect(result).toBeDefined();
    });
  });

  describe('getRegistration method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker(network.worker).getRegistration(bob, network.chosenCid);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getMeetupIndexAndLocation method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker(network.worker).getMeetupIndexAndLocation(bob, network.chosenCid);
      expect(result.toJSON()).toStrictEqual([0, null]);
    });
  });

  describe('getAttestations method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await useWorker(network.worker).getAttestations(bob, network.chosenCid);
      expect(result.toJSON()).toStrictEqual([]);
    });
  });

  describe('parsesBalanceType', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const balanceEnc = '0x014000000000000000000100000000000000';
      const balance = createType(registry, 'Option<Vec<u8>>', hexToU8a(balanceEnc)).unwrap();
      expect(parseI64F64(u8aToBn(balance))).toBe(1);
    });
  });
});
