import '../';
import { CustomTypes } from '../config/types';
import encointer, { getProofOfAttendance } from './encointer';
import { cryptoWaitReady, signatureVerify } from '@polkadot/util-crypto';
import { Keyring } from '@polkadot/api';
import * as types from '@polkadot/types';
import { createType } from '@polkadot/types';

describe('fetchCurrentPhase', () => {
  const apiMock = {
    query: {
      encointerScheduler: {
        currentPhase: jest.fn().mockImplementation(() => Promise.resolve(123))
      }
    }
  };

  it('should return promise', async () => {
    const result = await encointer.fetchCurrentPhase(apiMock);
    expect(result).toEqual({ phase: 123 });
  });
});

describe('getProofOfAttendance', () => {
  const registry = new types.TypeRegistry();
  const keyring = new Keyring({ type: 'sr25519' });
  registry.register(CustomTypes);
  const api = { registry };

  it('should be defined', () => {
    expect(encointer.getProofOfAttendance).toBeDefined();
    expect(getProofOfAttendance).toBeDefined();
  });

  it('should return Promise rejected without arguments', async () => {
    const promise = getProofOfAttendance();
    await expect(promise).rejects.toThrow('No api provided');
  });

  it('should return Promise rejected with incorrect arguments', async () => {
    await expect(getProofOfAttendance({})).rejects.toThrow('api has no registry');
    await expect(getProofOfAttendance(api)).rejects.toThrow('Invalid attendee');
    await expect(getProofOfAttendance(api, { address: '//Bob' })).rejects.toThrow('Attendee should have sign method');
    await expect(getProofOfAttendance(api, { address: '//Bob', sign: jest.fn() })).rejects.toThrow('Invalid Currency Identifier');
    await expect(getProofOfAttendance(api, { address: '//Bob', sign: jest.fn() }, 'test')).rejects.toThrow('Invalid Ceremony index');
    await expect(getProofOfAttendance(api, { address: '//Bob', sign: jest.fn() }, 'test', 0)).rejects.toThrow('Invalid Ceremony index');
  });

  it('should return proof object', async () => {
    await cryptoWaitReady();
    const attendee = keyring.addFromUri('//Alice', { name: 'Alice default' });
    const cid = '0x22c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d3';

    const optionProof = await getProofOfAttendance(api, attendee, cid, 2);
    const proof = optionProof.unwrap();
    expect(proof).toBeDefined();
    expect(proof.ceremony_index.toNumber()).toBe(2);
    expect(proof.currency_identifier.toString()).toBe(cid);
    expect(proof.attendee_public.toString()).toBe(attendee.address.toString());
    expect(proof.prover_public.toString()).toBe(attendee.address.toString());
  });

  it('proof should be valid', async () => {
    await cryptoWaitReady();
    const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' });
    const cid = '0x22c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d3';
    const cindex = 1;
    const optionProof = await getProofOfAttendance(api, attendee, cid, cindex);
    const proof = optionProof.unwrap();
    // Check message constructed from proof
    const msg = createType(registry, '(AccountId,CeremonyIndexType)', [proof.attendee_public, proof.ceremony_index]);
    expect(
      signatureVerify(
        msg.toU8a(),
        proof.attendee_signature,
        proof.attendee_public
      )
    ).toBeTruthy();
  });
});
