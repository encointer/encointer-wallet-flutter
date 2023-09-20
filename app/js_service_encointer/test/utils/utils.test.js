/**
 * @jest-environment jsdom
 */

import { describe, expect, it } from '@jest/globals';
import { stringNumberToEncointerBalanceU8 } from '../../src/utils/utils.js';

describe('utils', () => {
  it('stringBalanceToU8 works', () => {
    const balanceArray = stringNumberToEncointerBalanceU8('128');
    expect(balanceArray).toStrictEqual(new Uint8Array([
      0, 0, 0, 0, 0, 0,
      0, 0, 128, 0, 0, 0,
      0, 0, 0, 0
    ]));
  });
});
