/**
 * @jest-environment jsdom
 */

import { describe, expect, it } from '@jest/globals';
import { stringNumberToEncointerBalanceU8a } from '../../src/utils/utils.js';

describe('utils', () => {
  it('stringNumberToEncointerBalanceU8a works', () => {
    const balanceArray = stringNumberToEncointerBalanceU8a('128');
    expect(balanceArray).toStrictEqual(new Uint8Array([
      0, 0, 0, 0, 0, 0,
      0, 0, 128, 0, 0, 0,
      0, 0, 0, 0
    ]));
  });
});
