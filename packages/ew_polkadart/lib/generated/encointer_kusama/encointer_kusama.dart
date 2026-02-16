// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i31;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/aura.dart' as _i12;
import 'pallets/aura_ext.dart' as _i13;
import 'pallets/authorship.dart' as _i9;
import 'pallets/balances.dart' as _i7;
import 'pallets/collator_selection.dart' as _i10;
import 'pallets/collective.dart' as _i19;
import 'pallets/encointer_balances.dart' as _i24;
import 'pallets/encointer_bazaar.dart' as _i25;
import 'pallets/encointer_ceremonies.dart' as _i22;
import 'pallets/encointer_communities.dart' as _i23;
import 'pallets/encointer_democracy.dart' as _i28;
import 'pallets/encointer_faucet.dart' as _i27;
import 'pallets/encointer_offline_payment.dart' as _i32;
import 'pallets/encointer_reputation_commitments.dart' as _i26;
import 'pallets/encointer_scheduler.dart' as _i21;
import 'pallets/encointer_treasuries.dart' as _i29;
import 'pallets/membership.dart' as _i20;
import 'pallets/message_queue.dart' as _i16;
import 'pallets/parachain_info.dart' as _i6;
import 'pallets/parachain_system.dart' as _i3;
import 'pallets/polkadot_xcm.dart' as _i15;
import 'pallets/proxy.dart' as _i17;
import 'pallets/randomness_collective_flip.dart' as _i4;
import 'pallets/scheduler.dart' as _i18;
import 'pallets/session.dart' as _i11;
import 'pallets/system.dart' as _i2;
import 'pallets/timestamp.dart' as _i5;
import 'pallets/transaction_payment.dart' as _i8;
import 'pallets/utility.dart' as _i30;
import 'pallets/xcmp_queue.dart' as _i14;

class Queries {
  Queries(_i1.StateApi api)
      : system = _i2.Queries(api),
        parachainSystem = _i3.Queries(api),
        randomnessCollectiveFlip = _i4.Queries(api),
        timestamp = _i5.Queries(api),
        parachainInfo = _i6.Queries(api),
        balances = _i7.Queries(api),
        transactionPayment = _i8.Queries(api),
        authorship = _i9.Queries(api),
        collatorSelection = _i10.Queries(api),
        session = _i11.Queries(api),
        aura = _i12.Queries(api),
        auraExt = _i13.Queries(api),
        xcmpQueue = _i14.Queries(api),
        polkadotXcm = _i15.Queries(api),
        messageQueue = _i16.Queries(api),
        proxy = _i17.Queries(api),
        scheduler = _i18.Queries(api),
        collective = _i19.Queries(api),
        membership = _i20.Queries(api),
        encointerScheduler = _i21.Queries(api),
        encointerCeremonies = _i22.Queries(api),
        encointerCommunities = _i23.Queries(api),
        encointerBalances = _i24.Queries(api),
        encointerBazaar = _i25.Queries(api),
        encointerReputationCommitments = _i26.Queries(api),
        encointerFaucet = _i27.Queries(api),
        encointerDemocracy = _i28.Queries(api),
        encointerTreasuries = _i29.Queries(api),
        encointerOfflinePayment = _i32.Queries(api);

  final _i2.Queries system;

  final _i3.Queries parachainSystem;

  final _i4.Queries randomnessCollectiveFlip;

  final _i5.Queries timestamp;

  final _i6.Queries parachainInfo;

  final _i7.Queries balances;

  final _i8.Queries transactionPayment;

  final _i9.Queries authorship;

  final _i10.Queries collatorSelection;

  final _i11.Queries session;

  final _i12.Queries aura;

  final _i13.Queries auraExt;

  final _i14.Queries xcmpQueue;

  final _i15.Queries polkadotXcm;

  final _i16.Queries messageQueue;

  final _i17.Queries proxy;

  final _i18.Queries scheduler;

  final _i19.Queries collective;

  final _i20.Queries membership;

  final _i21.Queries encointerScheduler;

  final _i22.Queries encointerCeremonies;

  final _i23.Queries encointerCommunities;

  final _i24.Queries encointerBalances;

  final _i25.Queries encointerBazaar;

  final _i26.Queries encointerReputationCommitments;

  final _i27.Queries encointerFaucet;

  final _i28.Queries encointerDemocracy;

  final _i29.Queries encointerTreasuries;

  final _i32.Queries encointerOfflinePayment;
}

class Extrinsics {
  Extrinsics();

  final _i2.Txs system = _i2.Txs();

  final _i3.Txs parachainSystem = _i3.Txs();

  final _i5.Txs timestamp = _i5.Txs();

  final _i7.Txs balances = _i7.Txs();

  final _i10.Txs collatorSelection = _i10.Txs();

  final _i11.Txs session = _i11.Txs();

  final _i14.Txs xcmpQueue = _i14.Txs();

  final _i15.Txs polkadotXcm = _i15.Txs();

  final _i16.Txs messageQueue = _i16.Txs();

  final _i30.Txs utility = _i30.Txs();

  final _i17.Txs proxy = _i17.Txs();

  final _i18.Txs scheduler = _i18.Txs();

  final _i19.Txs collective = _i19.Txs();

  final _i20.Txs membership = _i20.Txs();

  final _i21.Txs encointerScheduler = _i21.Txs();

  final _i22.Txs encointerCeremonies = _i22.Txs();

  final _i23.Txs encointerCommunities = _i23.Txs();

  final _i24.Txs encointerBalances = _i24.Txs();

  final _i25.Txs encointerBazaar = _i25.Txs();

  final _i26.Txs encointerReputationCommitments = _i26.Txs();

  final _i27.Txs encointerFaucet = _i27.Txs();

  final _i28.Txs encointerDemocracy = _i28.Txs();

  final _i29.Txs encointerTreasuries = _i29.Txs();

  final _i32.Txs encointerOfflinePayment = const _i32.Txs();
}

class Constants {
  Constants();

  final _i2.Constants system = _i2.Constants();

  final _i3.Constants parachainSystem = _i3.Constants();

  final _i5.Constants timestamp = _i5.Constants();

  final _i7.Constants balances = _i7.Constants();

  final _i8.Constants transactionPayment = _i8.Constants();

  final _i10.Constants collatorSelection = _i10.Constants();

  final _i11.Constants session = _i11.Constants();

  final _i12.Constants aura = _i12.Constants();

  final _i14.Constants xcmpQueue = _i14.Constants();

  final _i15.Constants polkadotXcm = _i15.Constants();

  final _i16.Constants messageQueue = _i16.Constants();

  final _i30.Constants utility = _i30.Constants();

  final _i17.Constants proxy = _i17.Constants();

  final _i18.Constants scheduler = _i18.Constants();

  final _i19.Constants collective = _i19.Constants();

  final _i21.Constants encointerScheduler = _i21.Constants();

  final _i22.Constants encointerCeremonies = _i22.Constants();

  final _i23.Constants encointerCommunities = _i23.Constants();

  final _i24.Constants encointerBalances = _i24.Constants();

  final _i27.Constants encointerFaucet = _i27.Constants();

  final _i28.Constants encointerDemocracy = _i28.Constants();

  final _i29.Constants encointerTreasuries = _i29.Constants();

  final _i32.Constants encointerOfflinePayment = _i32.Constants();
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

class EncointerKusama {
  EncointerKusama._(
    this._provider,
    this.rpc,
  )   : query = Queries(rpc.state),
        constant = Constants(),
        tx = Extrinsics(),
        registry = Registry();

  factory EncointerKusama(_i1.Provider provider) {
    final rpc = Rpc(
      state: _i1.StateApi(provider),
      system: _i1.SystemApi(provider),
    );
    return EncointerKusama._(
      provider,
      rpc,
    );
  }

  factory EncointerKusama.url(Uri url) {
    final provider = _i1.Provider.fromUri(url);
    return EncointerKusama(provider);
  }

  final _i1.Provider _provider;

  final Queries query;

  final Constants constant;

  final Rpc rpc;

  final Extrinsics tx;

  final Registry registry;

  _i31.Future connect() async {
    return await _provider.connect();
  }

  _i31.Future disconnect() async {
    return await _provider.disconnect();
  }
}
