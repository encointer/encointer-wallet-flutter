/**
 * @jest-environment jsdom
 */

// import '../../src';
import { Keyring } from '@polkadot/api';
import { Keyrings, unableToRetrieveKeyPairException } from '../../src/service/keyrings.js';
import { cryptoWaitReady } from '@polkadot/util-crypto';

describe('keyring', () => {
  beforeAll(async () => {
    await cryptoWaitReady();
  });

  it('throws on nonexistent keyring', async () => {
    const keyring = new Keyring({ type: 'sr25519' });

    try {
      keyring.getPair("5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY")
    } catch (e) {
      expect(e.toString()).toBe(unableToRetrieveKeyPairException('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY'));
    }
  });

  it('getPair falls back to dev keyring', async () => {
    const keyrings = new Keyrings(
      new Keyring({ type: 'sr25519' }),
      new Keyring({ type: 'sr25519' })
    )

    const alice = keyrings.devKeyring.addFromUri('//Alice', { name: 'Alice default' });

    expect(
      keyrings.getPair("5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY").address,
    ).toBe(alice.address)
  });

});

