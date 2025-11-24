// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i32;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/asset_conversion.dart' as _i28;
import 'pallets/assets.dart' as _i22;
import 'pallets/aura.dart' as _i13;
import 'pallets/aura_ext.dart' as _i14;
import 'pallets/authorship.dart' as _i10;
import 'pallets/balances.dart' as _i7;
import 'pallets/collator_selection.dart' as _i11;
import 'pallets/foreign_assets.dart' as _i25;
import 'pallets/message_queue.dart' as _i18;
import 'pallets/multi_block_migrations.dart' as _i6;
import 'pallets/multisig.dart' as _i19;
import 'pallets/nft_fractionalization.dart' as _i26;
import 'pallets/nfts.dart' as _i24;
import 'pallets/parachain_info.dart' as _i5;
import 'pallets/parachain_system.dart' as _i3;
import 'pallets/polkadot_xcm.dart' as _i16;
import 'pallets/pool_assets.dart' as _i27;
import 'pallets/proxy.dart' as _i20;
import 'pallets/remote_proxy_relay_chain.dart' as _i21;
import 'pallets/revive.dart' as _i29;
import 'pallets/session.dart' as _i12;
import 'pallets/state_trie_migration.dart' as _i30;
import 'pallets/system.dart' as _i2;
import 'pallets/timestamp.dart' as _i4;
import 'pallets/to_polkadot_xcm_router.dart' as _i17;
import 'pallets/transaction_payment.dart' as _i8;
import 'pallets/uniques.dart' as _i23;
import 'pallets/utility.dart' as _i31;
import 'pallets/vesting.dart' as _i9;
import 'pallets/xcmp_queue.dart' as _i15;

class Queries {
  Queries(_i1.StateApi api)
      : system = _i2.Queries(api),
        parachainSystem = _i3.Queries(api),
        timestamp = _i4.Queries(api),
        parachainInfo = _i5.Queries(api),
        multiBlockMigrations = _i6.Queries(api),
        balances = _i7.Queries(api),
        transactionPayment = _i8.Queries(api),
        vesting = _i9.Queries(api),
        authorship = _i10.Queries(api),
        collatorSelection = _i11.Queries(api),
        session = _i12.Queries(api),
        aura = _i13.Queries(api),
        auraExt = _i14.Queries(api),
        xcmpQueue = _i15.Queries(api),
        polkadotXcm = _i16.Queries(api),
        toPolkadotXcmRouter = _i17.Queries(api),
        messageQueue = _i18.Queries(api),
        multisig = _i19.Queries(api),
        proxy = _i20.Queries(api),
        remoteProxyRelayChain = _i21.Queries(api),
        assets = _i22.Queries(api),
        uniques = _i23.Queries(api),
        nfts = _i24.Queries(api),
        foreignAssets = _i25.Queries(api),
        nftFractionalization = _i26.Queries(api),
        poolAssets = _i27.Queries(api),
        assetConversion = _i28.Queries(api),
        revive = _i29.Queries(api),
        stateTrieMigration = _i30.Queries(api);

  final _i2.Queries system;

  final _i3.Queries parachainSystem;

  final _i4.Queries timestamp;

  final _i5.Queries parachainInfo;

  final _i6.Queries multiBlockMigrations;

  final _i7.Queries balances;

  final _i8.Queries transactionPayment;

  final _i9.Queries vesting;

  final _i10.Queries authorship;

  final _i11.Queries collatorSelection;

  final _i12.Queries session;

  final _i13.Queries aura;

  final _i14.Queries auraExt;

  final _i15.Queries xcmpQueue;

  final _i16.Queries polkadotXcm;

  final _i17.Queries toPolkadotXcmRouter;

  final _i18.Queries messageQueue;

  final _i19.Queries multisig;

  final _i20.Queries proxy;

  final _i21.Queries remoteProxyRelayChain;

  final _i22.Queries assets;

  final _i23.Queries uniques;

  final _i24.Queries nfts;

  final _i25.Queries foreignAssets;

  final _i26.Queries nftFractionalization;

  final _i27.Queries poolAssets;

  final _i28.Queries assetConversion;

  final _i29.Queries revive;

  final _i30.Queries stateTrieMigration;
}

class Extrinsics {
  Extrinsics();

  final _i2.Txs system = _i2.Txs();

  final _i3.Txs parachainSystem = _i3.Txs();

  final _i4.Txs timestamp = _i4.Txs();

  final _i6.Txs multiBlockMigrations = _i6.Txs();

  final _i7.Txs balances = _i7.Txs();

  final _i9.Txs vesting = _i9.Txs();

  final _i11.Txs collatorSelection = _i11.Txs();

  final _i12.Txs session = _i12.Txs();

  final _i15.Txs xcmpQueue = _i15.Txs();

  final _i16.Txs polkadotXcm = _i16.Txs();

  final _i17.Txs toPolkadotXcmRouter = _i17.Txs();

  final _i18.Txs messageQueue = _i18.Txs();

  final _i31.Txs utility = _i31.Txs();

  final _i19.Txs multisig = _i19.Txs();

  final _i20.Txs proxy = _i20.Txs();

  final _i21.Txs remoteProxyRelayChain = _i21.Txs();

  final _i22.Txs assets = _i22.Txs();

  final _i23.Txs uniques = _i23.Txs();

  final _i24.Txs nfts = _i24.Txs();

  final _i25.Txs foreignAssets = _i25.Txs();

  final _i26.Txs nftFractionalization = _i26.Txs();

  final _i27.Txs poolAssets = _i27.Txs();

  final _i28.Txs assetConversion = _i28.Txs();

  final _i29.Txs revive = _i29.Txs();

  final _i30.Txs stateTrieMigration = _i30.Txs();
}

class Constants {
  Constants();

  final _i2.Constants system = _i2.Constants();

  final _i3.Constants parachainSystem = _i3.Constants();

  final _i4.Constants timestamp = _i4.Constants();

  final _i6.Constants multiBlockMigrations = _i6.Constants();

  final _i7.Constants balances = _i7.Constants();

  final _i8.Constants transactionPayment = _i8.Constants();

  final _i9.Constants vesting = _i9.Constants();

  final _i11.Constants collatorSelection = _i11.Constants();

  final _i12.Constants session = _i12.Constants();

  final _i13.Constants aura = _i13.Constants();

  final _i15.Constants xcmpQueue = _i15.Constants();

  final _i16.Constants polkadotXcm = _i16.Constants();

  final _i18.Constants messageQueue = _i18.Constants();

  final _i31.Constants utility = _i31.Constants();

  final _i19.Constants multisig = _i19.Constants();

  final _i20.Constants proxy = _i20.Constants();

  final _i22.Constants assets = _i22.Constants();

  final _i23.Constants uniques = _i23.Constants();

  final _i24.Constants nfts = _i24.Constants();

  final _i25.Constants foreignAssets = _i25.Constants();

  final _i26.Constants nftFractionalization = _i26.Constants();

  final _i27.Constants poolAssets = _i27.Constants();

  final _i28.Constants assetConversion = _i28.Constants();

  final _i29.Constants revive = _i29.Constants();

  final _i30.Constants stateTrieMigration = _i30.Constants();
}

class Rpc {
  const Rpc({
    required this.state,
    required this.system,
  });

  final _i1.StateApi state;

  final _i1.SystemApi system;
}

class Registry {
  Registry();

  final int extrinsicVersion = 4;

  List getSignedExtensionTypes() {
    return ['CheckMortality', 'CheckNonce', 'ChargeAssetTxPayment', 'CheckMetadataHash'];
  }

  List getSignedExtensionExtra() {
    return ['CheckSpecVersion', 'CheckTxVersion', 'CheckGenesis', 'CheckMortality', 'CheckMetadataHash'];
  }
}

class AssetHubKusama {
  AssetHubKusama._(
    this._provider,
    this.rpc,
  )   : query = Queries(rpc.state),
        constant = Constants(),
        tx = Extrinsics(),
        registry = Registry();

  factory AssetHubKusama(_i1.Provider provider) {
    final rpc = Rpc(
      state: _i1.StateApi(provider),
      system: _i1.SystemApi(provider),
    );
    return AssetHubKusama._(
      provider,
      rpc,
    );
  }

  factory AssetHubKusama.url(Uri url) {
    final provider = _i1.Provider.fromUri(url);
    return AssetHubKusama(provider);
  }

  final _i1.Provider _provider;

  final Queries query;

  final Constants constant;

  final Rpc rpc;

  final Extrinsics tx;

  final Registry registry;

  _i32.Future connect() async {
    return await _provider.connect();
  }

  _i32.Future disconnect() async {
    return await _provider.disconnect();
  }
}
