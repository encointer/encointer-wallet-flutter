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
  // Commitment is an Option<H256>, so we need to see if the key exists, as None maps to null.
  const keys = await api.query.encointerReputationCommitments.commitments.keys([cid, cIndex])
    .then((keys) => keys.map(({ args: [[_cid, _cIndex], [purposeId, accountId]] }) => [purposeId, accountId]));

  console.log(`Keys for [${JSON.stringify(cid)}, ${cIndex}]: ${JSON.stringify(keys)}`);

  const accountTyped = api.createType('AccountId', account);
  const purposeTyped = api.createType('u64', purpose);

  for (const [purposeId, accountId] of keys) {
    // prevent mismatch of ss58 prefix, types, codecs etc.
    const acc = api.createType('AccountId', accountId);
    const pur = api.createType('u64', purposeId);

    if (purposeTyped.toHex() === pur.toHex() && accountTyped.toHex() === acc.toHex()) {
      return true;
    }
  }

  return false;
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
