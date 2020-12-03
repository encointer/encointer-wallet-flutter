'use strict';

import { CustomTypes } from './config/types';
import encointer, { getCurrencyIdentifiers } from './service/encointer';
import account, { _sendTrustedTx, createTrustedCall } from './service/account';
import { assert, hexToU8a, u8aToHex } from '@polkadot/util';
import { ApiPromise, Keyring } from '@polkadot/api';
import { WsProvider } from '@polkadot/rpc-provider';
import '@babel/polyfill';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import worker, { useWorker } from './service/worker';
import * as bs58 from 'bs58';
import { createType } from '@polkadot/types';

const cantillonNetwork = () => {
  return {
    chain: 'wss://cantillon.encointer.org',
    worker: 'wss://substratee03.scs.ch',
    genesisHash: '0x2b673afeff4a17e65fb3248fe9ac2a74998508a5c434f79a722af4fa8ab7470f',
    chosenCid: '3rk5pLBVZsWesSD4buAkZ4meguYKTpK8bKAA9MjtxPDe'
  };
};

const chainbrickNetwork = () => {
  return {
    chain: 'ws://chainbrick.encointer.org:9944',
    worker: 'ws://chainbrick.encointer.org:2000',
    genesisHash: '0x2b673afeff4a17e65fb3248fe9ac2a74998508a5c434f79a722af4fa8ab7470f',
    chosenCid: '3rk5pLBVZsWesSD4buAkZ4meguYKTpK8bKAA9MjtxPDe'
  };
};

const localDockerNetwork = () => {
  return {
    chain: 'ws://127.0.0.1:9979',
    worker: 'ws://127.0.0.1:2079',
    genesisHash: '0xa9aa009b2c17430aa0e995dfa9db51b219802d3c2209ce39b0e277ac49b59827',
    chosenCid: '4oyxCDvpG6oZ93VmB73rE6P6enfdDZ9PvEvw9eRoqdeM'
  };
};

describe('encointer', () => {
  const network = localDockerNetwork();
  let keyring;
  let registry;
  beforeAll(async () => {
    jest.setTimeout(9000);
    keyring = new Keyring({ type: 'sr25519' });
    await connect(network.chain);
    registry = window.api.registry;
    // await setWorkerEndpoint(network.worker);
    window.send = data => console.log(data);
  });

  describe('init api', () => {
    it('should get cantillon genesis hash', async () => {
      console.log('genesis hash: ' + api.genesisHash);
      expect(u8aToHex(api.genesisHash)).toBe(network.genesisHash);
      // assert(true);
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

  describe('substratee call_worker', () => {
    it('registerParticipant works', async () => {
      await cryptoWaitReady();
      // const result = await encointer.getCurrentPhase();
      // assert(result.phase.isRegistering);

      const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const cidTyped = createType(registry, 'CurrencyIdentifier', bs58.decode(network.chosenCid));

      const call = createTrustedCall(
        alice,
        cidTyped,
        'ceremonies_register_participant',
        (alice.publicKey, cidTyped, createType(registry, '(AccountId, CurrencyIdentifier, Option<ProofOfAttendance<MultiSignature, AccountId>>)'))
      );

      const cypherText = window.workerShieldingKey.encrypt(call.toU8a(), 'hex');
      console.log('cyphertext' + cypherText);
      const txRes = await _sendTrustedTx(alice, network.chosenCid, cypherText);
      console.log(txRes);

      const participantIndex = await useWorker(window.workerEndpoint).getRegistration(alice, network.chosenCid);
      expect(participantIndex.toNumber()).toBeGreaterThan(0);
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
      await provider.disconnect();
      resolve(null);
    }
  });
}

async function setWorkerEndpoint (endpoint) {
  return new Promise(async (resolve, reject) => {
    window.workerEndpoint = endpoint;
    window.workerShieldingKey = await useWorker(endpoint).getShieldingKey();
    resolve(endpoint);
  });
}
