/**
 * @jest-environment jsdom
 */

import '../../src';
import { localDevNetwork } from '../testUtils/networks';
import { beforeAll, describe, expect, it, jest } from '@jest/globals';
import { testSetup } from '../testUtils/testSetup';
import { decode, encode } from '../../src/service/scale-codec';

describe('scale-codec', () => {
  const network = localDevNetwork();
  let setup;

  beforeAll(async () => {
    jest.setTimeout(90000);

    setup = await testSetup(network);
  });

  describe('encode', () => {
    it('works correctly', async () => {
      const encoded = await encode('Option<Vec<u8>>', []);

      expect(
        await encode('Option<Vec<u8>>', []),
      ).toStrictEqual(new Uint8Array([1,0]))
    });
  });

  describe('decode', () => {
    it('works correctly', async () => {
      expect(
        await decode('Option<Vec<u8>>', [1,0])
      ).toStrictEqual(setup.api.createType('Option<Vec<u8>>', []));
    });
  });
});
