
export async function getFinalizedHeader () {
  const hash = await api.rpc.chain.getFinalizedHead();
  return api.rpc.chain.getHeader(hash);
}

export default {
  getFinalizedHeader,
};
