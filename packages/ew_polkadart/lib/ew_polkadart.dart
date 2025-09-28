/// Encointer Polkadart Package
library;

export 'generated/encointer_kusama/encointer_kusama.dart' show EncointerKusama, Constants, Queries, Rpc;
export 'generated/encointer_kusama/types/tuples.dart' show Tuple2;
export 'package:polkadart/polkadart.dart';

// encointer democracy exports
export 'generated/encointer_kusama/types/encointer_primitives/democracy/proposal.dart' show Proposal;
export 'generated/encointer_kusama/types/encointer_primitives/democracy/proposal_action.dart'
    show
        ProposalAction,
        AddLocation,
        RemoveLocation,
        UpdateDemurrage,
        UpdateNominalIncome,
        SetInactivityTimeout,
        Petition,
        SpendNative,
        IssueSwapNativeOption,
        SpendAsset,
        IssueSwapAssetOption;
export 'generated/encointer_kusama/types/encointer_primitives/democracy/proposal_action_identifier.dart'
    show ProposalActionIdentifier;
export 'generated/encointer_kusama/types/encointer_primitives/democracy/proposal_state.dart'
    show ProposalState, Ongoing, Rejected, SupersededBy, Approved, Confirming, Enacted;
export 'generated/encointer_kusama/types/encointer_primitives/democracy/tally.dart' show Tally;
export 'generated/encointer_kusama/types/encointer_primitives/democracy/vote.dart' show Vote;
export 'generated/encointer_kusama/types/encointer_primitives/treasuries/swap_native_option.dart' show SwapNativeOption;
export 'generated/encointer_kusama/types/encointer_primitives/treasuries/swap_asset_option.dart' show SwapAssetOption;

export 'generated/encointer_kusama/types/staging_xcm/v5/asset/asset_id.dart' show AssetId;
export 'generated/encointer_kusama/types/staging_xcm/v5/junctions/junctions.dart' show Junctions, Here, X1, X2, X3, X4;
export 'generated/encointer_kusama/types/staging_xcm/v5/junction/junction.dart'
    show Junction, Parachain, GeneralIndex, PalletInstance, GlobalConsensus;
export 'generated/encointer_kusama/types/staging_xcm/v5/junction/network_id.dart' show Kusama, Polkadot, NetworkId;

export 'generated/encointer_kusama/types/polkadot_runtime_common/impls/versioned_locatable_asset.dart'
    show VersionedLocatableAsset, V5;

export 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        ByteInput,
        ByteOutput,
        BoolCodec,
        Codec,
        Input,
        Output,
        U32Codec,
        U64Codec,
        U128Codec,
        U8Codec,
        U8ArrayCodec,
        SequenceCodec,
        StrCodec,
        Option;

// Renamings to avoid conflicts

import 'generated/encointer_kusama/types/staging_xcm/v5/location/location.dart' show Location;
import 'generated/encointer_kusama/types/staging_xcm/v5/junction/junction.dart' show AccountId32;
import 'generated/encointer_kusama/types/xcm/versioned_location.dart' show VersionedLocation, V5;

/// Re-export Location as XcmLocation to avoid conflict with Encointer Location
typedef XcmLocation = Location;
typedef XcmVersionedLocation = VersionedLocation;
typedef LocationV5 = V5;

/// Re-export Location as XcmLocation to avoid conflict with Encointer Location
typedef XcmAccountId32 = AccountId32;
