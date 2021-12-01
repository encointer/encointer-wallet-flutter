/**
 * @jest-environment jsdom
 */

import '../../src';
import {
  _signClaimOfAttendance
} from '../../src/service/encointer';
import { localDockerNetwork } from '../testUtils/networks';
import { beforeAll, describe, it, jest } from '@jest/globals';
import { testSetup } from '../testUtils/testSetup';
import { Keyring } from '@polkadot/api';
import { decode, encode } from '../../src/service/scale-codec';

describe('scale-codec', () => {
  const network = localDockerNetwork();
  let keyring;

  const testClaim = {
    claimant_public: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
    ceremony_index: 63,
    community_identifier: '0x22c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d3',
    meetup_index: 1,
    location: {
      lat: '0x00000000000000237bf1ac299e7e0000',
      lon: '0x00000000000000128b26000000000000'
    },
    timestamp: 1638441840000,
    number_of_participants_confirmed: 3,
    signature: null
  };

  beforeAll(async () => {
    jest.setTimeout(90000);

    await testSetup(network);
    keyring = new Keyring({ type: 'sr25519' });
  });

  describe('encode', () => {
    it('works correctly', async () => {
      const claimant = keyring.addFromUri('//Alice', { name: 'Alice default' });

      const claimSigned = await _signClaimOfAttendance(claimant, testClaim);

      expect(
        await encode('ClaimOfAttendance', claimSigned)
      ).toStrictEqual(claimSigned.toU8a());
    });
  });

  describe('decode', () => {
    it('works correctly', async () => {
      const claimant = keyring.addFromUri('//Alice', { name: 'Alice default' });

      const claimSigned = await _signClaimOfAttendance(claimant, testClaim);

      expect(
        await decode('ClaimOfAttendance', claimSigned.toU8a())
      ).toStrictEqual(claimSigned);
    });
  });
});
