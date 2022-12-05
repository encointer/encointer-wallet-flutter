export const gesellNetwork = () => {
  return {
    chain: 'wss://gesell.encointer.org',
    genesisHash: '0xa91674169884b8f312efbca48b3ad02bbf93eed0817502092c93f8f8f8a2884b',
    chosenCid: '4oyxCDvpG6oZ93VmB73rE6P6enfdDZ9PvEvw9eRoqdeM',
    customTypes: {},
    palletOverrides: {}
  };
};

export const cantillonNetwork = () => {
  return {
    chain: 'wss://cantillon.encointer.org',
    worker: 'wss://substratee03.scs.ch',
    genesisHash: '0x2b673afeff4a17e65fb3248fe9ac2a74998508a5c434f79a722af4fa8ab7470f',
    chosenCid: '3rk5pLBVZsWesSD4buAkZ4meguYKTpK8bKAA9MjtxPDe',
    customTypes: TypeOverrides_V3_8,
    palletOverrides: PalletOverrides_V3_8
  };
};

export const chainbrickNetwork = () => {
  return {
    chain: 'ws://chainbrick.encointer.org:9944',
    worker: 'ws://chainbrick.encointer.org:2000',
    genesisHash: '0x2b673afeff4a17e65fb3248fe9ac2a74998508a5c434f79a722af4fa8ab7470f',
    chosenCid: '3rk5pLBVZsWesSD4buAkZ4meguYKTpK8bKAA9MjtxPDe',
    customTypes: TypeOverrides_V3_8,
    palletOverrides: PalletOverrides_V3_8
  };
};

export const localDevNetwork = () => {
  return {
    chain: 'ws://127.0.0.1:9944',
    worker: 'ws://127.0.0.1:2079',
    genesisHash: '0x388c446a804e24e77ae89f5bb099edb60cacc2ac7c898ce175bdaa08629c1439',
    mrenclave: '4SkU25tusVChcrUprW8X22QoEgamCgj3HKQeje7j8Z4E',
    chosenCid: '4Xgnkpg4RwXjFegLzYKgY6Y3jCSPmxyPmNvfs42Uvsuh',
    customTypes: {},
    palletOverrides: {}
  };
};

const TypeOverrides_V3_8 = {
  CurrencyIdentifier: 'Hash',
  BalanceType: 'i128',
  BalanceEntry: {
    principal: 'i128',
    last_update: 'BlockNumber'
  },
  CurrencyCeremony: '(CurrencyIdentifier,CeremonyIndexType)',
  CurrencyPropertiesType: {
    name_utf8: 'Vec<u8>',
    demurrage_per_block: 'Demurrage'
  },
  GetterArgs: '(AccountId, CurrencyIdentifier)',
  PublicGetter: {
    _enum: {
      total_issuance: 'CurrencyIdentifier',
      participant_count: 'CurrencyIdentifier',
      meetup_count: 'CurrencyIdentifier',
      ceremony_reward: 'CurrencyIdentifier',
      location_tolerance: 'CurrencyIdentifier',
      time_tolerance: 'CurrencyIdentifier',
      scheduler_state: 'CurrencyIdentifier'
    }
  },
  TrustedGetter: {
    _enum: {
      balance: '(AccountId, CurrencyIdentifier)',
      participant_index: '(AccountId, CurrencyIdentifier)',
      meetup_index: '(AccountId, CurrencyIdentifier)',
      attestations: '(AccountId, CurrencyIdentifier)',
      meetup_registry: '(AccountId, CurrencyIdentifier)'
    }
  }
};

const PalletOverrides_V3_8 = {
  encointerCommunities: {
    name: 'encointerCurrencies',
    calls: {
      communityIdentifiers: 'currencyIdentifiers'
    }
  }
};
