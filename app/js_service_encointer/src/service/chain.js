import { unsubscribe } from '../utils/unsubscribe.js';

export async function subscribeNewHeads (msgChannel) {
  await api.rpc.chain.subscribeNewHeads((lastHeader) => {
    send(msgChannel, lastHeader);
  }).then((unsub) => unsubscribe(unsub, msgChannel));
}

export async function getFinalizedHeader () {
  const hash = await api.rpc.chain.getFinalizedHead();
  return api.rpc.chain.getHeader(hash);
}

export default {
  subscribeNewHeads,
  getFinalizedHeader,
};
