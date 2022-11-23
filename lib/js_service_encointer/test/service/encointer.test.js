/**
 * @jest-environment jsdom
 */

import '../../src';
import encointer, {
  getProofOfAttendance,
  _getProofOfAttendance,
  _signClaimOfAttendance, reapVoucher, encointerTransfer, getBalance, hasPendingIssuance
} from '../../src/service/encointer';
import { cryptoWaitReady, signatureVerify } from '@polkadot/util-crypto';
import { localDockerNetwork } from '../testUtils/networks';
import { beforeAll, describe, expect, it, jest } from '@jest/globals';
import { parseI64F64, communityIdentifierFromString } from '@encointer/util';
import { testSetup } from '../testUtils/testSetup';
import { Keyring } from '@polkadot/api';

describe('encointer', () => {
  const network = localDockerNetwork();
  let keyring;
  beforeAll(async () => {
    await testSetup(network);
    keyring = new Keyring({ type: 'sr25519' });
  }, 90000);

  describe('getCurrentPhase', () => {
    it('should return promise', async () => {
      const result = await encointer.getCurrentPhase();
      console.log(result);
      expect(result).toBeDefined();
    });
  });

  describe('getDemurrage', () => {
    it('should return default', async () => {
      const cid = communityIdentifierFromString(api.registry, 'gbsuv7YXq9G');
      const result = await encointer.getDemurrage(cid);
      console.log(result);
      expect(result).toBe(1.1267607882072287e-7);
    });
  });

  describe('getParticipantReputation', () => {
    it('should return promise', async () => {
      await cryptoWaitReady();
      const cid = communityIdentifierFromString(api.registry, 'gbsuv7YXq9G');
      const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' }).address;
      const result = await encointer.getParticipantReputation(cid, 1, attendee);
      expect(result.isUnverified).toBeTruthy();
    });
  });

  describe('getParticipantReputation2', () => {
    it('should return promise', async () => {
      await cryptoWaitReady();
      const cid = communityIdentifierFromString(api.registry, 'gbsuv7YXq9G');
      // const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' }).address;
      const result = await encointer.getParticipantReputation(cid, 3, '0xf4577adda8c5bda374fb86d42aed35eb171a949c7b52202806cd137795d5567a');
      expect(result.isUnverified).toBeTruthy();
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
      const cid = communityIdentifierFromString(api.registry, 'gbsuv7YXq9G');
      const proof = await _getProofOfAttendance(attendee, cid, 2).then((p) => p.unwrap());

      expect(proof).toBeDefined();
      expect(proof.ceremonyIndex.toNumber()).toBe(2);
      expect(proof.communityIdentifier).toStrictEqual(cid);
      expect(proof.attendeePublic.toString()).toBe(attendee.address.toString());
      expect(proof.proverPublic.toString()).toBe(attendee.address.toString());
    });

    it('proof should be valid', async () => {
      await cryptoWaitReady();
      const attendee = keyring.addFromUri('//Bob', { name: 'Bob default' });
      const cid = communityIdentifierFromString(api.registry, 'gbsuv7YXq9G');
      const cindex = 1;
      const optionProof = await _getProofOfAttendance(attendee, cid, cindex);
      const proof = optionProof.unwrap();
      // Check message constructed from proof
      const msg = api.createType('(AccountId,CeremonyIndexType)', [proof.attendeePublic, proof.ceremonyIndex]);
      expect(
        signatureVerify(
          msg.toU8a(),
          proof.attendeeSignature.toU8a(),
          proof.attendeePublic
        )
      ).toBeTruthy();
    });
  });

  describe('signClaimOfAttendance', () => {
    it('creates valid claim', async () => {
      await cryptoWaitReady();
      const claimant = keyring.addFromUri('//Alice', { name: 'Alice default' });
      // contains Alice's key as given by the app.

      const cid = communityIdentifierFromString(api.registry, 'gbsuv7YXq9G');

      const claim = `{
        "claimant_public":"0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d",
        "ceremony_index":2,
        "community_identifier":"${cid.toHex()}",
        "meetup_index":1,
        "location":{"lon":"35.5037","lat":"18.12314"},
        "timestamp":1621507440000
        ,"number_of_participants_confirmed":3,
        "claimant_signature":null
      }`;

      const claimJson = JSON.parse(claim);
      const signedClaim = await _signClaimOfAttendance(claimant, claimJson);

      // see endian issue in signClaimOfAttendance
      const payload = window.api.createType('ClaimOfAttendanceSigningPayload', {
        ...signedClaim,
        location: {
          lat: signedClaim.location.lat.toHex(true),
          lon: signedClaim.location.lon.toHex(true),
        }
      });

      expect(
        signatureVerify(
          payload.toU8a(),
          signedClaim.claimantSignature.unwrap().toU8a(),
          claimant.publicKey
        )
      ).toEqual({
        crypto: 'sr25519',
        isValid: true,
        isWrapped: false,
        publicKey: claimant.publicKey
      });
    });
  });

  describe('parse fixed point string', () => {
    it('matches runtime value', () => {
      const locJson = '{ "lon": "342068094947158917120","lat": "654567151410639405056" }';
      const locObj = JSON.parse(locJson);
      const loc = window.api.createType('Location', locObj);

      expect(
        parseI64F64(loc.lat)
      ).toBe(35.4841563798531680618);
      expect(
        parseI64F64(loc.lon)
      ).toBe(18.543548583984375);
    });
  });

  describe('pendingIssuance', () => {
    it('correctly returns false', async () =>  {
      const cid = communityIdentifierFromString(api.registry, "sqm1v79dF6b");
      expect(
        await hasPendingIssuance(
          cid, 2, "0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d"
        )).toBeFalsy();
    });
  });

  // skip because it needs the bootstrapping script.
  describe.skip('reap voucher', () => {
    it('removes all the balance from voucher', async () => {
      // assumes that the bootstrap script has been run.
      const voucherUri = "//VoucherUri";
      const voucherPair = keyring.addFromUri(voucherUri, {name: "Voucher"})
      const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const recipient = keyring.addFromUri('//Recipient', { name: 'Recipient' });

      const cid = communityIdentifierFromString(api.registry, "sqm1v79dF6b");

      await encointerTransfer(alice, voucherPair.address, cid, 0.06.toString());

      const balanceVoucher = await getBalance(cid, voucherPair.address);
      console.log(`balance voucher: ${JSON.stringify(balanceVoucher)}`);
      // `toBeGreaterThan` is for convenience if we have executed
      // the test before we have some dust as leftover.
      expect(balanceVoucher.principal).toBeGreaterThanOrEqual(0.06);

      // await reapVoucher(voucherUri, recipient.address, cid, cid);
      //
      // const balanceRecipient = await getBalance(cid, recipient.address);
      // console.log(`balance recipient: ${JSON.stringify(balanceRecipient)}`);
      // expect(balanceRecipient.principal).toBeGreaterThan(0.058);
      //
      // const balanceVoucherReaped = await getBalance(cid, voucherPair.address);
      // console.log(`balance voucher: ${JSON.stringify(balanceVoucherReaped)}`);
      // expect(balanceVoucherReaped.principal).toBeLessThan(0.015);

    }, 90000);
  });
});
