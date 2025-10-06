// Asset Hub types to avoid conflicts with Encointer types

import 'generated/asset_hub_kusama/types/staging_xcm/v5/location/location.dart' show Location;

import 'generated/asset_hub_kusama/types/staging_xcm/v5/junctions/junctions.dart' show Junctions, Here, X1, X2, X3, X4;
import 'generated/asset_hub_kusama/types/staging_xcm/v5/junction/junction.dart'
    show Junction, Parachain, GeneralIndex, PalletInstance, GlobalConsensus;

/// Re-export Location as XcmLocation to avoid conflict with Encointer Location
typedef XcmAssetHubLocation = Location;
typedef XcmAssetHubJunctions = Junctions;
typedef XcmAssetHubHere = Here;
typedef XcmAssetHubX1 = X1;
typedef XcmAssetHubX2 = X2;
typedef XcmAssetHubX3 = X3;
typedef XcmAssetHubX4 = X4;
typedef XcmAssetHubJunction = Junction;
typedef XcmAssetHubParachain = Parachain;
typedef XcmAssetHubGeneralIndex = GeneralIndex;
typedef XcmAssetHubPalletInstance = PalletInstance;
typedef XcmAssetHubGlobalConsensus = GlobalConsensus;
