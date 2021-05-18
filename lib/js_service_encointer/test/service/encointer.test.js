import '../../src';
import encointer, {
  getProofOfAttendance,
  getClaimOfAttendance,
  parseClaimOfAttendance,
  _getProofOfAttendance,
  _signClaimOfAttendance
} from '../../src/service/encointer';
import { _attestClaimOfAttendance } from '../../src/service/account';
import { cryptoWaitReady, signatureVerify } from '@polkadot/util-crypto';
import { ApiPromise, Keyring } from '@polkadot/api';
import * as bs58 from 'bs58';
import { WsProvider } from '@polkadot/rpc-provider';
import { localDockerNetwork } from '../testUtils/networks';
import { beforeAll, describe, it, jest } from '@jest/globals';
import { options } from '@encointer/node-api';
import { pallets } from '../../src/config/consts';

describe('encointer', () => {
  const network = localDockerNetwork();
  let keyring;
  beforeAll(async () => {
    jest.setTimeout(90000);
    window.send = (_, data) => console.log(data);
    keyring = new Keyring({ type: 'sr25519' });
    const provider = new WsProvider(network.chain);
    try {
      window.api = await ApiPromise.create({
        ...options({
          types: network.customTypes
        }),
        provider: provider
      });
      Object.assign(pallets, network.palletOverrides);
      send('log', `${network.chain} wss connected success`);
    } catch (err) {
      send('log', `connect ${network.chain} failed`);
      await provider.disconnect();
    }
  });

  describe('getCurrentPhase', () => {
    it('should return promise', async () => {
      const result = await encointer.getCurrentPhase();
      console.log(result);
      expect(result).toBeDefined();
    });
  });

  describe('subscribeParticipantIndex', () => {
    it('should return promise', async () => {
      await cryptoWaitReady();
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' }).address;
      const result = await encointer.subscribeParticipantIndex('log', cid, 1, attendee);
      expect(result).toStrictEqual({});
    });
  });

  describe('getParticipantReputation', () => {
    it('should return promise', async () => {
      await cryptoWaitReady();
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' }).address;
      const result = await encointer.getParticipantReputation(cid, 1, attendee);
      expect(result.isUnverified);
    });
  });

  describe('getParticipantCount', () => {
    it('should return promise', async () => {
      await cryptoWaitReady();
      const cid = '0x4a577b9854e8f491c52876f712b1d930351fff583a12535fa47cb0a5731ad105';
      // const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' }).address;
      const result = await encointer.getParticipantCount(cid, 3);
      console.log(result);
      expect(result.toNumber()).toBe(0);
    });
  });

  describe('getParticipantReputation2', () => {
    it('should return promise', async () => {
      await cryptoWaitReady();
      const cid = '0x4a577b9854e8f491c52876f712b1d930351fff583a12535fa47cb0a5731ad105';
      // const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' }).address;
      const result = await encointer.getParticipantReputation(cid, 3, '0xf4577adda8c5bda374fb86d42aed35eb171a949c7b52202806cd137795d5567a');
      expect(result.isUnverified);
    });
  });

  describe('getProofOfAttendance', () => {
    it('should be defined', () => {
      expect(encointer.getProofOfAttendance).toBeDefined();
      expect(getProofOfAttendance).toBeDefined();
    });

    it('should return Promise rejected without arguments', async () => {
      const promise = _getProofOfAttendance();
      await expect(promise).rejects.toThrow('Invalid attendee');
    });

    it('should return Promise rejected with incorrect arguments', async () => {
      await expect(_getProofOfAttendance({ address: '//Bob' })).rejects.toThrow('Attendee should have sign method');
      await expect(_getProofOfAttendance({
        address: '//Bob',
        sign: jest.fn()
      })).rejects.toThrow('Invalid Community Identifier');
      await expect(_getProofOfAttendance({
        address: '//Bob',
        sign: jest.fn()
      }, 'test')).rejects.toThrow('Invalid Ceremony index');
      await expect(_getProofOfAttendance({
        address: '//Bob',
        sign: jest.fn()
      }, 'test', 0)).rejects.toThrow('Invalid Ceremony index');
    });

    it('should return proof object', async () => {
      await cryptoWaitReady();
      const attendee = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const optionProof = await _getProofOfAttendance(attendee, cid, 2);
      const proof = optionProof.unwrap();
      expect(proof).toBeDefined();
      expect(proof.ceremony_index.toNumber()).toBe(2);
      expect(bs58.encode(proof.community_identifier)).toBe(cid);
      expect(proof.attendee_public.toString()).toBe(attendee.address.toString());
      expect(proof.prover_public.toString()).toBe(attendee.address.toString());
    });

    it('proof should be valid', async () => {
      await cryptoWaitReady();
      const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const cid = '3LjCHdiNbNLKEtwGtBf6qHGZnfKFyjLu9v3uxVgDL35C';
      const cindex = 1;
      const optionProof = await _getProofOfAttendance(attendee, cid, cindex);
      const proof = optionProof.unwrap();
      // Check message constructed from proof
      const msg = api.createType('(AccountId,CeremonyIndexType)', [proof.attendee_public, proof.ceremony_index]);
      expect(
        signatureVerify(
          msg.toU8a(),
          proof.attendee_signature,
          proof.attendee_public
        )
      ).toBeTruthy();
    });
  });

  describe('getClaimOfAttendance', () => {
    it('should be defined', () => {
      expect(encointer.getClaimOfAttendance).toBeDefined();
      expect(getClaimOfAttendance).toBeDefined();
    });

    it('creates valid claim', async () => {
      await cryptoWaitReady();
      const claimant = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const cid = '0x22c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d3';

      const claim = `{
          "claimant_public" : "${claimant.address}",
          "ceremony_index"  : 63,
          "community_identifier" : "${cid}",
          "meetup_index" : 1,
          "location": { "lat": 3548415638 , "lon": 18543548584 },
          "timestamp" : 1592719549549,
          "number_of_participants_confirmed" : 3,
          "claimant_signature" : null
          }`;

      const claimJson = JSON.parse(claim);
      const payload = window.api.createType('ClaimOfAttendanceSigningPayload', claimJson);
      const signedClaim = await _signClaimOfAttendance(claimant, claimJson);
      expect(signedClaim).toBeDefined();

      expect(
        signatureVerify(
          payload.toU8a(),
          signedClaim.claimant_signature.unwrap().toU8a(),
          claimant.publicKey
        )
      ).toBeTruthy();
    });
  });

  describe('parseClaimOfAttendance', () => {
    it('should be defined', () => {
      expect(parseClaimOfAttendance).toBeDefined();
      expect(encointer.parseClaimOfAttendance).toBeDefined();
    });

    it('should return value', async () => {
      const claim = await parseClaimOfAttendance('0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d3f00000022c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d301000000000000002aacf17b230000000000268b120000006da47bd57201000003000000');
      expect(claim).toBeDefined();
      expect(claim).toEqual(
        {
          claimant_public: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
          ceremony_index: 63,
          community_identifier: '0x22c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d3',
          meetup_index: 1,
          location: {
            lat: '0x000000237bf1ac2a',
            lon: '0x000000128b260000'
          },
          timestamp: 1592719549549,
          number_of_participants_confirmed: 3
        }
      );
    });
  });
});
