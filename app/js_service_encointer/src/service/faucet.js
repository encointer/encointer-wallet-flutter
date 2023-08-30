/**
 * Gets all existing faucet accounts.
 */
export async function getAllFaucetAccounts () {
  // First we get all faucet accounts
  return await api.query.encointerFaucet.faucets.keys()
    .then((keys) => keys.map(({ args: [account] }) => api.createType('AccountId', account)));
}

/**
 * Gets information about the faucet owned by `faucetAccount`.
 */
export async function getFaucetFor (faucetAccount) {
  return await api.query.encointerFaucet.faucets(faucetAccount);
}

/**
 * Gets all existing faucets along with their owning account.
 */
export async function getAllFaucetsWithAccount () {
  const accounts = await getAllFaucetAccounts();
  const faucets = await Promise.all(accounts.map((a) => getFaucetFor(a)));
  return combineListsIntoMap(accounts, faucets);
}

/**
 * Checks if an account has already committed its reputation for a given purpose.
 */
export async function hasCommittedFor (cid, cIndex, purpose, account) {
  const maybeCommitment = await api.query.encointerReputationCommitments.commitments([cid, cIndex], [purpose, account]);
  console.log(`Commitment of: ${account} for [${cid}, [${cIndex}][${purpose}, ${account}]: ${JSON.stringify(maybeCommitment)}`);
  return maybeCommitment.isSome;
}

function combineListsIntoMap (keys, values) {
  if (keys.length !== values.length) {
    throw new Error('Lists must have the same length');
  }

  return keys.reduce((resultMap, key, index) => {
    resultMap[key] = values[index];
    return resultMap;
  }, {});
}
