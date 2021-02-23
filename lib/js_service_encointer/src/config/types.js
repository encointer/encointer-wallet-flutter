export const CustomTypes = {
  Address: 'MultiAddress',
  LookupSource: 'MultiAddress',
  CeremonyPhaseType: {
    _enum: [
      'Registering',
      'Assigning',
      'Attesting'
    ]
  },
  ShopIdentifier: 'Text',
  ArticleIdentifier: 'Text',
  CeremonyIndexType: 'u32',
  ParticipantIndexType: 'u64',
  MeetupIndexType: 'u64',
  AttestationIndexType: 'u64',
  CommunityIdentifier: 'Hash',
  BalanceType: 'i128',
  BalanceEntry: {
    principal: 'i128',
    last_update: 'BlockNumber'
  },
  CommunityCeremony: '(CommunityIdentifier,CeremonyIndexType)',
  CommunityPropertiesType: {
    name_utf8: 'Vec<u8>',
    demurrage_per_block: 'Demurrage'
  },
  Demurrage: 'i128',
  Location: {
    lat: 'i64',
    lon: 'i64'
  },
  Reputation: {
    _enum: [
      'Unverified',
      'UnverifiedReputable',
      'VerifiedUnlinked',
      'VerifiedLinked'
    ]
  },
  ClaimOfAttendance: {
    claimant_public: 'AccountId',
    ceremony_index: 'CeremonyIndexType',
    community_identifier: 'CommunityIdentifier',
    meetup_index: 'MeetupIndexType',
    location: 'Location',
    timestamp: 'Moment',
    number_of_participants_confirmed: 'u32'
  },
  Attestation: {
    claim: 'ClaimOfAttendance',
    signature: 'MultiSignature',
    public: 'AccountId'
  },
  ProofOfAttendance: {
    prover_public: 'AccountId',
    ceremony_index: 'CeremonyIndexType',
    community_identifier: 'CommunityIdentifier',
    attendee_public: 'AccountId',
    attendee_signature: 'MultiSignature'
  },
  ShardIdentifier: 'Hash',
  PublicGetter: {
    _enum: {
      total_issuance: 'CommunityIdentifier',
      participant_count: 'CommunityIdentifier',
      meetup_count: 'CommunityIdentifier',
      ceremony_reward: 'CommunityIdentifier',
      location_tolerance: 'CommunityIdentifier',
      time_tolerance: 'CommunityIdentifier'
    }
  },
  TrustedGetter: {
    _enum: {
      balance: '(AccountId, CommunityIdentifier)',
      participant_index: '(AccountId, CommunityIdentifier)',
      meetup_index: '(AccountId, CommunityIdentifier)',
      attestations: '(AccountId, CommunityIdentifier)',
      meetup_registry: '(AccountId, CommunityIdentifier)'
    }
  },
  TrustedGetterSigned: {
    getter: 'TrustedGetter',
    signature: 'Signature'
  },
  Getter: {
    _enum: {
      public: 'PublicGetter',
      trusted: 'TrustedGetterSigned'
    }
  },
  TrustedCallSigned: {
    call: 'TrustedCall',
    nonce: 'u32',
    signature: 'Signature'
  },
  TrustedCall: {
    _enum: {
      balance_transfer: '(AccountId, AccountId, CommunityIdentifier, BalanceType)',
      ceremonies_register_participant: '(AccountId, CommunityIdentifier, Option<ProofOfAttendance<MultiSignature, AccountId>>)',
      ceremonies_register_attestations: '(AccountId, Vec<Attestation<MultiSignature, AccountId, u64>>)',
      ceremonies_grant_reputation: '(AccountId, CommunityIdentifier, AccountId)'
    }
  },
  ClientRequest: {
    _enum: {
      PubKeyWorker: null,
      MuRaPortWorker: null,
      StfState: '(Getter, ShardIdentifier)'
    }
  },
  Request: {
    shard: 'ShardIdentifier',
    cyphertext: 'Vec<u8>'
  },
  Enclave: {
    pubkey: 'AccountId',
    mrenclave: 'Hash',
    timestamp: 'u64',
    url: 'Text'
  }
};
