import '../';
import {CustomTypes} from '../config/types';
import encointer, { getProofOfAttendance } from './encointer';

import { u8aToHex, u8aToBn, u8aToString } from '@polkadot/util';
import { cryptoWaitReady, signatureVerify,schnorrkelVerify } from '@polkadot/util-crypto';
import { Keyring } from '@polkadot/api';
import { ApiPromise } from "@polkadot/api";
import * as types from "@polkadot/types";
import { createType } from '@polkadot/types';

describe('fetchCurrentPhase', () => {
  const apiMock = {
    query: {
      encointerScheduler: {
        currentPhase: jest.fn().mockImplementation(() => Promise.resolve(123))
      }
    }
  };

  it('should return promise', () => {
   const result = encointer.fetchCurrentPhase(apiMock);
    expect(result).toBeDefined();
    expect(result).resolves.toEqual({phase: 123});
  })

})

describe('getProofOfAttendance', () => {
    const registry = new types.TypeRegistry()
    const keyring = new Keyring({ type: 'sr25519' });
    registry.register(CustomTypes);
    const api = { registry };
  
  it('should be defined', () => {
    expect(encointer.getProofOfAttendance).toBeDefined();
    expect(getProofOfAttendance).toBeDefined();
  });

  it('should return Promise rejected without arguments', () => {
    const promise = getProofOfAttendance();
    expect(promise).rejects.toThrow('No api provided');
  });

  it('should return Promise rejected with incorrect arguments', () => {
    expect(getProofOfAttendance({})).rejects.toThrow('api has no registry');
    expect(getProofOfAttendance(api)).rejects.toThrow('Invalid attendee');
    expect(getProofOfAttendance(api, {address:'//Bob'})).rejects.toThrow('Attendee should have sign method');
    expect(getProofOfAttendance(api, {address:'//Bob', sign: jest.fn()})).rejects.toThrow('Invalid Currency Identifier');
    expect(getProofOfAttendance(api, {address:'//Bob', sign: jest.fn()}, 'test')).rejects.toThrow('Invalid Ceremony index');
    expect(getProofOfAttendance(api, {address:'//Bob', sign: jest.fn()}, 'test', 0)).rejects.toThrow('Invalid Ceremony index');
  });
  
  it('should return proof object', async () => {
    await cryptoWaitReady();
    const attendee = keyring.addFromUri('//Alice', { name: 'Alice default' });
    const cid = '0x22c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d3'

    let proof = await getProofOfAttendance(api, attendee, cid, 2)
    expect(proof.unwrap()).toBeDefined();
  });
  it('testdata', () => {
    const optionProof = new Uint8Array([0x1, 0x8e, 0xaf, 0x4, 0x15, 0x16, 0x87, 0x73, 0x63, 0x26, 0xc9, 0xfe, 0xa1, 0x7e, 0x25, 0xfc, 0x52, 0x87, 0x61, 0x36, 0x93, 0xc9, 0x12, 0x90, 0x9c, 0xb2, 0x26, 0xaa, 0x47, 0x94, 0xf2, 0x6a, 0x48, 0x2, 0x0, 0x0, 0x0, 0x22, 0xc5, 0x1e, 0x6a, 0x65, 0x6b, 0x19, 0xdd, 0x1e, 0x34, 0xc6, 0x12, 0x6a, 0x75, 0xb8, 0xaf, 0x2, 0xb3, 0x8e, 0xed, 0xbe, 0xec, 0x51, 0x86, 0x50, 0x63, 0xf1, 0x42, 0xc8, 0x3d, 0x40, 0xd3, 0x8e, 0xaf, 0x4, 0x15, 0x16, 0x87, 0x73, 0x63, 0x26, 0xc9, 0xfe, 0xa1, 0x7e, 0x25, 0xfc, 0x52, 0x87, 0x61, 0x36, 0x93, 0xc9, 0x12, 0x90, 0x9c, 0xb2, 0x26, 0xaa, 0x47, 0x94, 0xf2, 0x6a, 0x48, 0x1, 0x70, 0xd2, 0xa6, 0x8a, 0x9b, 0xa8, 0xb2, 0x62, 0x20, 0x75, 0x97, 0xb9, 0x6f, 0xdc, 0x15, 0xd9, 0xa4, 0x26, 0x4a, 0x1e, 0x91, 0xd3, 0x3e, 0x83, 0xeb, 0x8e, 0xb2, 0xa6, 0xec, 0x16, 0x59, 0x61, 0xbb, 0xff, 0x10, 0x9a, 0x73, 0x99, 0x76, 0xba, 0x9f, 0x1b, 0x9d, 0x60, 0x9d, 0xca, 0xf2, 0x7a, 0x7, 0xc9, 0xf2, 0x4c, 0x87, 0x3, 0x12, 0x96, 0x51, 0x95, 0x93, 0x48, 0xfc, 0x72, 0x35, 0x8e])
    const p = (new types.Option(registry, 'ProofOfAttendance', optionProof)).value;
    const msg = createType(registry, '(AccountId, CeremonyIndexType)', [p.attendee_public, p.ceremony_index]);    
    console.log(p.toJSON())
    console.log('signature valid:',
      schnorrkelVerify(
        msg.toU8a(),
        p.attendee_signature,
        p.attendee_public),
    );
    
  })
});  
