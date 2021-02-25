// Specific overwrites for sgx-master branch used in dev

export const Types = {
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
  Demurrage: 'i128',
  Reputation: {
    _enum: [
      'Unverified',
      'UnverifiedReputable',
      'VerifiedUnlinked',
      'VerifiedLinked'
    ]
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

// these pallets have been renamed in more recent encointer nodes
export const encointerCommunities = 'encointerCurrencies';
export const communityIdentifiers = 'currencyIdentifiers';
