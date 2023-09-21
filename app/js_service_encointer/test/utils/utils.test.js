/**
 * @jest-environment jsdom
 */

import { describe, expect, it } from '@jest/globals';
import { stringNumberToEncointerBalanceU8a } from '../../src/utils/utils.js';

describe('utils', () => {
  it('stringNumberToEncointerBalanceU8a works', () => {
    /*
      Verified correctness with the following rust-test.

     	#[test]
     	fn decode_128() {
     		let balance =
     			BalanceType::from_le_bytes([0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0]);

     		assert_eq!(balance, BalanceType::from_num(128));
     	}
    */
    const balanceArray = stringNumberToEncointerBalanceU8a('128');
    expect(balanceArray).toStrictEqual(new Uint8Array([
      0, 0, 0, 0, 0, 0,
      0, 0, 128, 0, 0, 0,
      0, 0, 0, 0
    ]));
  });
});
