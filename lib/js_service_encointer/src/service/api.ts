import { ApiOptions } from '@polkadot/api/types';

export const defaultOptions: ApiOptions = {
  types: enointerTypes,
};

const encointerTypes {
  Address: 'AccountId',
  LookupSource: 'AccountId',
  CeremonyPhaseType: {
    _enum: [
      'Registering',
      'Assigning',
      'Attesting'
    ]
  },
  CeremonyIndexType: 'u32',
  ParticipantIndexType: 'u64',
  MeetupIndexType: 'u64',
  AttestationIndexType: 'u64',
  CurrencyIdentifier: 'Hash',
  BalanceType: 'i128',
  BalanceEntry: {
    principal: 'i128',
    last_update: 'BlockNumber'
  },
  CurrencyCeremony: {
    cid: 'CurrencyIdentifier',
    cindex: 'CeremonyIndexType'
  },
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
  CurrencyPropertiesType: {
    name_utf8: 'Text',
    demurrage_per_block: 'i128'
  },
  ClaimOfAttendance: {
    claimant_public: 'AccountId',
    ceremony_index: 'CeremonyIndexType',
    currency_identifier: 'CurrencyIdentifier',
    meetup_index: 'MeetupIndexType',
    location: 'Location',
    timestamp: 'Moment',
    number_of_participants_confirmed: 'u32'
  },
  Attestation: {
    claim: 'ClaimOfAttendance',
    signature: 'Signature',
    public: 'AccountId'
  },
  ProofOfAttendance: {
    prover_public: 'AccountId',
    ceremony_index: 'CeremonyIndexType',
    currency_identifier: 'CurrencyIdentifier',
    attendee_public: 'AccountId',
    attendee_signature: 'Signature'
  },
  // substrate
  Weight: 'u32'
};