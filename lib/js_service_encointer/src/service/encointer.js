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

export async function fetchCurrentPhase(api) {
  const phase = await api.query.encointerScheduler.currentPhase();
  return {
    phase,
  };
}

export async function subscribeTimestamp(api) {
  await api.query.timestamp.now((moment) => {
    send("unsubtimestamp", `timestamp: ${moment}`)
  }).then((unsub) => {
    const unsubFuncName = `unsubtimestamp`;
    window[unsubFuncName] = unsub;
    send("log", "unsubscribed channel");
    return {};
  });
}

export async function subscribeCurrentPhase(api, msgChannel) {
  console.log(`subscribing to phase in channel: ${msgChannel}`);
  send("log", `subscribing to phase in channel: ${msgChannel}`);
  return await api.query.encointerScheduler.currentPhase((phase) => {
    send("log", `phase update: ${phase}`);
    send(msgChannel, phase);
  }).then((unsub) => {
    const unsubFuncName = `unsub${msgChannel}`;
    window[unsubFuncName] = unsub;
    send("log", "unsubscribed channel");
    return {};
  });
}

export async function fetchCurrencyIdentifiers(api) {
  const cids = await api.query.encointerCurrencies.currencyIdentifiers();
  return {
    cids,
  };
}

export default {
  fetchCurrentPhase, fetchCurrencyIdentifiers, subscribeTimestamp
};
