import { Keyring } from '@polkadot/keyring';

export const keyring = new Keyring({ ss58Format: 0, type: 'sr25519' });
export const devKeyring = new Keyring({ ss58Format: 0, type: 'sr25519' });
export const keyrings = new Keyrings(keyring, devKeyring)

export const unableToRetrieveKeyPairException = (address) => `Error: Unable to retrieve keypair '${address}'`;

/**
 * Wrapper class to handle two keyrings.
 */
export class Keyrings {
  constructor(keyring, devKeyring) {
    this.keyring = keyring;
    this.devKeyring = devKeyring;
  }

  getPair(addressOrPubKey, password) {
    try {
      const keyPair = this.keyring.getPair(addressOrPubKey)
      return keyPair.decodePkcs8(password);
    } catch (e) {
      console.log(`Exception getting pair from keyring: ${e.toString()}`);
      return this.devKeyring.getPair(addressOrPubKey)
    }
  }
}
