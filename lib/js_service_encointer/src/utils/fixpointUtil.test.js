import '../';
import BN from 'bn.js';
import { toI16F16 } from './fixpointUtil';

describe('fixpointUtil', () => {
  describe('toFixPoint', () => {
    it('should parse integer to fixPoint', async () => {
      const result = toI16F16(1);
      expect(result).toEqual(new BN(0x80000000, 2));
    });
    it('should parse 0 to fixPoint', async () => {
      const result = toI16F16(0);
      expect(result).toEqual(new BN(0x0, 2));
    });
    it('should parse 1.1 to fixPoint', async () => {
      const result = toI16F16(1.1);
      expect(result).toBeDefined();
    });
  });
});
