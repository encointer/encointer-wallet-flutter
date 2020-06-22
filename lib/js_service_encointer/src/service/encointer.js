import { formatBalance } from "@polkadot/util";
import BN from "bn.js";

const divisor = new BN("1".padEnd(18 + 1, "0"));

function balanceToNumber(amount) {
  return (
    amount
      .muln(1000)
      .div(divisor)
      .toNumber() / 1000
  );
}

export async function fetchCurrentPhase() {
  const phase = await api.query.encointerScheduler.currentPhase();
  return {
    phase,
  };
}

/**
 * Mainly debug method introduced to test subscriptions. Subscribes to the timestamp of the last block
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeTimestamp(msgChannel) {
  await api.query.timestamp.now((moment) => {
    send(msgChannel, `timestamp: ${moment}`)
  }).then((unsub) => unsubscribe(unsub,  msgChannel));
}

/**
 * Subscribes to the current ceremony phase
 * @param msgChannel channel that the message handler uses on the dart side
 * @returns {Promise<void>}
 */
export async function subscribeCurrentPhase(msgChannel) {
  return await api.query.encointerScheduler.currentPhase((phase) => {
    send(msgChannel, phase);
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

export async function fetchCurrencyIdentifiers() {
  const cids = await api.query.encointerCurrencies.currencyIdentifiers();
  return {
    cids,
  };
}

function unsubscribe(unsub, msgChannel) {
  const unsubFuncName = `unsub${msgChannel}`;
  window[unsubFuncName] = unsub;
  return {};
}

export default {
  fetchCurrentPhase, fetchCurrencyIdentifiers, subscribeTimestamp, subscribeCurrentPhase
};
