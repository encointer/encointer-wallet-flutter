'use strict';

import '@babel/polyfill';

import { beforeAll, describe, it, jest } from '@jest/globals';
import { cantillonNetwork } from '../testUtils/networks';
import { CustomTypes } from '../../src/config/types';
import settings from '../../src/service/settings';
import substratee from '../../src/service/substratee';
import { bs58 } from '@polkadot/util-crypto/base58/bs58';

describe('substratee', () => {
  const network = cantillonNetwork();
  beforeAll(async () => {
    jest.setTimeout(9000);
    window.send = (_, data) => console.log(data);
    const customTypes = Object.assign({}, CustomTypes, network.customTypes);
    await settings.connect(network.chain, customTypes);
  });

  it('getEnclave works ', async () => {
    // remember: indexes start at one on-chain
    const enclave = await substratee.getEnclave(1);
    expect(enclave.timestamp.toNumber()).toBeGreaterThan(0);
  });

  it('getEnclaveCount works', async () => {
    const count = await substratee.getEnclaveCount();
    expect(count.toNumber()).toBeGreaterThan(0);
  });

  it('getEnclaveIndex works', async () => {
    const enclave = await substratee.getEnclave(1);
    const count = await substratee.getEnclaveIndex(enclave.pubkey);
    expect(count.toNumber()).toBe(1);
  });

  it('getLatestIpfsHash works', async () => {
    const hash = await substratee.getLatestIpfsHash(bs58.decode(network.chosenCid));
    console.log(hash);
    expect(hash.length).toBeGreaterThan(0);
  });

  it('getWorkerIndexForShard works', async () => {
    const wIndex = await substratee.getWorkerIndexForShard(bs58.decode(network.chosenCid));
    console.log(wIndex);
    expect(wIndex.toNumber()).toBeGreaterThan(0);
  });
});
