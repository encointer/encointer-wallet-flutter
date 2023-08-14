/**
 * @jest-environment jsdom
 */
import '../../src';
import account from '../../src/service/account';
import { cryptoWaitReady } from '@polkadot/util-crypto';
import { gesellNetwork, localDevNetwork } from '../testUtils/networks';
import { testSetup } from '../testUtils/testSetup';
import { Keyring } from '@polkadot/api';
import BN from 'bn.js';
import { communityIdentifierFromString } from '@encointer/util';
import { bnToU8a } from '@polkadot/util';
import { stringToEncointerBalance } from '@encointer/types';
import { extractEvents } from '@encointer/node-api';


describe('account', () => {
  const network = localDevNetwork();
  let keyring;
  beforeAll(async () => {
    await testSetup(network);
    keyring = new Keyring({ type: 'sr25519' });
  });

  describe('faucet', () => {
    it('has enough funds', async () => {
      await cryptoWaitReady();
      const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const balance = await account.getBalance(alice.address);
      const faucetTransferValue = 0.0001 * Math.pow(10, 12);
      expect(parseInt(balance.freeBalance)).toBeGreaterThan(faucetTransferValue);
    });
  });

  describe('community-payment', () => {
    // skipping because it needs to have a community setup
    it.skip('community fee payment works for ferdie without native tokens', async () => {
      await cryptoWaitReady();
      const alice = keyring.addFromUri('//Alice', { name: 'Alice default' });
      const eve = keyring.addFromUri('//Eve', { name: 'Ferdie default' });
      const ferdie = keyring.addFromUri('//Ferdie', { name: 'Ferdie default' });

      const cid = communityIdentifierFromString(api.registry, 'sqm1v79dF6b');
      const cidOpt = api.createType('Option<CommunityIdentifier>', cid);

      console.log(`CidOpt ${JSON.stringify(cidOpt)}`);
      console.log(`CidOpt ${cidOpt.toHex()}`);

      const aliceToFerdie = api.tx.encointerBalances.transfer(
        ferdie.address,
        cid,
        bnToU8a(stringToEncointerBalance('0.08')),
      );

      const signerOptions = {
        tip: new BN(0, 10),
        assetId: cidOpt
      };

      await aliceToFerdie.signAsync(alice, signerOptions);

      console.log(`aliceToFerdie: ${aliceToFerdie.toString()}`);
      console.log(`aliceToFerdie: ${aliceToFerdie.toHex()}`);

      await submitAndWatchTx(api, aliceToFerdie)

      const ferdieToEve = api.tx.encointerBalances.transfer(
        eve.address,
        cid,
        bnToU8a(stringToEncointerBalance('0.05')),
      );

      await ferdieToEve.signAsync(ferdie, signerOptions);
      console.log(`ferdieToEve: ${ferdieToEve.toString()}`);
      console.log(`ferdieToEve: ${ferdieToEve.toHex()}`);

      await submitAndWatchTx(api, ferdieToEve)
    }, 80000);
  });
});

export function submitAndWatchTx(api, tx) {
  return new Promise((resolve => {
    let unsub = () => {
    };

    const onStatusChange = (result) => {
      if (result.status.isInBlock || result.status.isFinalized) {
        const {success, error} = extractEvents(api, result);

        if (success) {
          resolve({
            hash: tx.hash,
            time: new Date().getTime(),
            params: tx.args
          });
        }
        if (error) {
          resolve({
            hash: tx.hash,
            time: new Date().getTime(),
            params: tx.args,
            error: error
          });
        }
        unsub();
      } else {
        console.log('txStatusChange', result.status.type)
      }
    }
    tx.send(onStatusChange)
      .then((res) => {
        unsub = res;
      })
      .catch((err) => {
        console.log(`{error: ${err.message}}`);
      });
  }))
}
