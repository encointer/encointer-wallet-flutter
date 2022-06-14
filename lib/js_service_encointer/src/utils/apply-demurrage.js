export function applyDemurrage(balanceEntry, latestBlockNumber, demurrageRate) {
  const elapsed = latestBlockNumber - balanceEntry.lastUpdate;
  const exponent = -demurrageRate * elapsed
  return balanceEntry.principal * Math.pow(Math.E, exponent);
}
