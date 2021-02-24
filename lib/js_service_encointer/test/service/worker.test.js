import '../../src';
import { Keyring } from '@polkadot/api';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import { createType, TypeRegistry } from '@polkadot/types';
import { hexToU8a, u8aToBn } from '@polkadot/util';
import { parseI64F64 } from '@encointer/util';
import { localDockerNetwork } from '../testUtils/networks';
import { EncointerWorker } from '@encointer/worker-api';
import WS from 'websocket';

const { w3cwebsocket: WebSocket } = WS;

describe('worker', () => {
  const network = localDockerNetwork();
  let keyring;
  let registry;
  let worker;
  beforeAll(async () => {
    jest.setTimeout(90000);
    window.send = (_, data) => console.log(data);
    keyring = new Keyring({ type: 'sr25519' });
    registry = new TypeRegistry();
    worker = new EncointerWorker(network.worker, {
      createWebSocket: (url) => new WebSocket(url)
    });
  });

  describe('getWorkerPubKey method', () => {
    it('should return value', async () => {
      // Todo: `getShieldingKey` does not exist
      const result = await worker.getShieldingKey();
      expect(result).toBeDefined();
    });
  });

  describe('getTotalIssuance method', () => {
    it('should return value', async () => {
      const result = await worker.getTotalIssuance(network.chosenCid);
      console.log('getTotalIssuance', result);
      expect(result).toBeDefined();
    });
  });

  describe('getParticipantCount method', () => {
    it('should return value', async () => {
      const result = await worker.getParticipantCount(network.chosenCid);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getMeetupCount method', () => {
    it('should return value', async () => {
      const result = await worker.getMeetupCount(network.chosenCid);
      console.log('getMeetupCount', result);
      expect(result).toBe(0);
    });
  });

  describe('getCeremonyReward method', () => {
    it('should return value', async () => {
      const result = await worker.getCeremonyReward(network.chosenCid);
      console.log('ceremonyReward', result);
      expect(result).toBe(1);
    });
  });

  describe('getLocationTolerance method', () => {
    it('should return value', async () => {
      const result = await worker.getLocationTolerance(network.chosenCid);
      expect(result).toBe(1000);
    });
  });

  describe('getTimeTolerance method', () => {
    it('should return value', async () => {
      const result = await worker.getTimeTolerance(network.chosenCid);
      expect(result.toNumber()).toBe(600000);
    });
  });

  describe('getSchedulerState method', () => {
    it('should return value', async () => {
      const result = await worker.getSchedulerState(network.chosenCid);
      console.log('schedulerStateResult', result);
      expect(result).toBeDefined();
    });
  });

  describe('getBalance method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await worker.getBalance(bob, network.chosenCid);
      console.log('getBalance', result);
      expect(result).toBeDefined();
    });
  });

  describe('getRegistration method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      // Todo: worker error: `Cannot map Enum JSON, unable to find 'registration' in balance, participant_index, meetup_index, attestations, meetup_registry`
      const result = await worker.getRegistration(bob, network.chosenCid);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getMeetupIndex method', () => {
    it('should return value', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      // Todo: `getMeetupIndex` does not exist in worker
      const result = await worker.getMeetupIndex(bob, network.chosenCid);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getAttestations method', () => {
    it('should be empty', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const result = await worker.getAttestations(bob, network.chosenCid);
      expect(result.toJSON()).toStrictEqual([]);
    });
  });

  describe('getMeetupRegistry method', () => {
    it('should be empty', async () => {
      await cryptoWaitReady();
      const bob = keyring.addFromUri('//Bob', { name: 'Bob default' });
      // Todo: `getMeetupRegistry` does not exist in worker
      const result = await worker.getMeetupRegistry(bob, network.chosenCid);
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
