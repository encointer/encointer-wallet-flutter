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

async function fetchCurrentPhase(api, address) {
  const phase = await api.query.encointerScheduler.currentPhase();
  return {
    phase,
  };
}

export default {
  fetchCurrentPhase,
};
