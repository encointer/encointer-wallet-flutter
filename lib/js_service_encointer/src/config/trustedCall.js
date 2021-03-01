export const TrustedCallTypes = {
  TrustedCallSigned: {
    call: 'TrustedCall',
    nonce: 'u32',
    signature: 'Signature'
  },
  TrustedCall: {
    _enum: {
      balance_transfer: '(AccountId, AccountId, CommunityIdentifier, BalanceType)',
      ceremonies_register_participant: '(AccountId, CurrencyIdentifier, Option<ProofOfAttendance<MultiSignature, AccountId>>)',
      ceremonies_register_attestations: '(AccountId, Vec<Attestation<MultiSignature, AccountId, u64>>)',
      ceremonies_grant_reputation: '(AccountId, CurrencyIdentifier, AccountId)'
    }
  }
};

export const TrustedCallMap = {
  encointerCeremonies: {
    registerParticipant: 'ceremonies_register_participant',
    registerAttestations: 'ceremonies_register_attestations',
    grantReputation: 'ceremonies_grant_reputation'
  },
  encointerBalances: {
    transfer: 'balance_transfer'
  }
};
