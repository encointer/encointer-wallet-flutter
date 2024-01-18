/**
 * @jest-environment jsdom
 */

import '../../src';
import  {
  reapVoucher, encointerTransfer, getBalance
} from '../../src/service/encointer';
import { localDevNetwork } from '../testUtils/networks';
import { beforeAll, describe, expect, it, jest } from '@jest/globals';
import { parseI64F64, communityIdentifierFromString } from '@encointer/util';
import { testSetup } from '../testUtils/testSetup';
import { Keyring } from '@polkadot/api';


describe('encointer', () => {
  const network = localDevNetwork();
  let keyring;
  beforeAll(async () => {
    await testSetup(network);
    keyring = new Keyring({ type: 'sr25519' });
  }, 90000);

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

  // Note: this needs the bootstrapping script, but we have this in the CI now.
  describe('reap voucher', () => {
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

      await reapVoucher(voucherUri, recipient.address, cid, cid);

      const balanceRecipient = await getBalance(cid, recipient.address);
      console.log(`balance recipient: ${JSON.stringify(balanceRecipient)}`);
      expect(balanceRecipient.principal).toBeGreaterThan(0.040);

      const balanceVoucherReaped = await getBalance(cid, voucherPair.address);
      console.log(`balance voucher: ${JSON.stringify(balanceVoucherReaped)}`);
      expect(balanceVoucherReaped.principal).toBe(0);
    }, 90000);
  });
});
