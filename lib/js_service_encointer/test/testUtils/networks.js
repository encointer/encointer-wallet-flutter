export const gesellNetwork = () => {
  return {
    chain: 'wss://gesell.encointer.org',
    genesisHash: '0xbe9b25f50cd46745d0b6a78d7a0c67bfee10a0597b1fe607483dc819f2c3a0d2',
    chosenCid: '4oyxCDvpG6oZ93VmB73rE6P6enfdDZ9PvEvw9eRoqdeM',
    customTypes: { }
  };
};

export const cantillonNetwork = () => {
  return {
    chain: 'wss://cantillon.encointer.org',
    worker: 'wss://substratee03.scs.ch',
    genesisHash: '0x2b673afeff4a17e65fb3248fe9ac2a74998508a5c434f79a722af4fa8ab7470f',
    chosenCid: '3rk5pLBVZsWesSD4buAkZ4meguYKTpK8bKAA9MjtxPDe',
    customTypes: { }
  };
};

export const chainbrickNetwork = () => {
  return {
    chain: 'ws://chainbrick.encointer.org:9944',
    worker: 'ws://chainbrick.encointer.org:2000',
    genesisHash: '0x2b673afeff4a17e65fb3248fe9ac2a74998508a5c434f79a722af4fa8ab7470f',
    chosenCid: '3rk5pLBVZsWesSD4buAkZ4meguYKTpK8bKAA9MjtxPDe',
    customTypes: { }
  };
};

export const localDockerNetwork = () => {
  return {
    chain: 'ws://127.0.0.1:9979',
    worker: 'ws://127.0.0.1:2079',
    genesisHash: '0xa9aa009b2c17430aa0e995dfa9db51b219802d3c2209ce39b0e277ac49b59827',
    mrenclave: 'DxF5PNys87yxxUSqD2CR37vi7UWLfrQ8fR5j6QUbWNXH',
    chosenCid: '4Xgnkpg4RwXjFegLzYKgY6Y3jCSPmxyPmNvfs42Uvsuh',
    customTypes: {
      Address: 'MultiAddress',
      TrustedGetter: { // updated getter that is not yet in Cantillon
        _enum: {
          balance: '(AccountId, CommunityIdentifier)',
          participant_index: '(AccountId, CommunityIdentifier)',
          meetup_index: '(AccountId, CommunityIdentifier)',
          attestations: '(AccountId, CommunityIdentifier)',
          meetup_registry: '(AccountId, CommunityIdentifier)'
        }
      }
    }
  };
};
