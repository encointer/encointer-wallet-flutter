// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i28;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/aura.dart' as _i9;
import 'pallets/aura_ext.dart' as _i10;
import 'pallets/balances.dart' as _i7;
import 'pallets/collective.dart' as _i18;
import 'pallets/dmp_queue.dart' as _i13;
import 'pallets/encointer_balances.dart' as _i23;
import 'pallets/encointer_bazaar.dart' as _i24;
import 'pallets/encointer_ceremonies.dart' as _i21;
import 'pallets/encointer_communities.dart' as _i22;
import 'pallets/encointer_faucet.dart' as _i26;
import 'pallets/encointer_reputation_commitments.dart' as _i25;
import 'pallets/encointer_scheduler.dart' as _i20;
import 'pallets/membership.dart' as _i19;
import 'pallets/message_queue.dart' as _i14;
import 'pallets/parachain_info.dart' as _i6;
import 'pallets/parachain_system.dart' as _i3;
import 'pallets/polkadot_xcm.dart' as _i12;
import 'pallets/proxy.dart' as _i16;
import 'pallets/randomness_collective_flip.dart' as _i4;
import 'pallets/scheduler.dart' as _i17;
import 'pallets/system.dart' as _i2;
import 'pallets/timestamp.dart' as _i5;
import 'pallets/transaction_payment.dart' as _i8;
import 'pallets/treasury.dart' as _i15;
import 'pallets/utility.dart' as _i27;
import 'pallets/xcmp_queue.dart' as _i11;

class Queries {
  Queries(_i1.StateApi api)
      : system = _i2.Queries(api),
        parachainSystem = _i3.Queries(api),
        randomnessCollectiveFlip = _i4.Queries(api),
        timestamp = _i5.Queries(api),
        parachainInfo = _i6.Queries(api),
        balances = _i7.Queries(api),
        transactionPayment = _i8.Queries(api),
        aura = _i9.Queries(api),
        auraExt = _i10.Queries(api),
        xcmpQueue = _i11.Queries(api),
        polkadotXcm = _i12.Queries(api),
        dmpQueue = _i13.Queries(api),
        messageQueue = _i14.Queries(api),
        treasury = _i15.Queries(api),
        proxy = _i16.Queries(api),
        scheduler = _i17.Queries(api),
        collective = _i18.Queries(api),
        membership = _i19.Queries(api),
        encointerScheduler = _i20.Queries(api),
        encointerCeremonies = _i21.Queries(api),
        encointerCommunities = _i22.Queries(api),
        encointerBalances = _i23.Queries(api),
        encointerBazaar = _i24.Queries(api),
        encointerReputationCommitments = _i25.Queries(api),
        encointerFaucet = _i26.Queries(api);

  final _i2.Queries system;

  final _i3.Queries parachainSystem;

  final _i4.Queries randomnessCollectiveFlip;

  final _i5.Queries timestamp;

  final _i6.Queries parachainInfo;

  final _i7.Queries balances;

  final _i8.Queries transactionPayment;

  final _i9.Queries aura;

  final _i10.Queries auraExt;

  final _i11.Queries xcmpQueue;

  final _i12.Queries polkadotXcm;

  final _i13.Queries dmpQueue;

  final _i14.Queries messageQueue;

  final _i15.Queries treasury;

  final _i16.Queries proxy;

  final _i17.Queries scheduler;

  final _i18.Queries collective;

  final _i19.Queries membership;

  final _i20.Queries encointerScheduler;

  final _i21.Queries encointerCeremonies;

  final _i22.Queries encointerCommunities;

  final _i23.Queries encointerBalances;

  final _i24.Queries encointerBazaar;

  final _i25.Queries encointerReputationCommitments;

  final _i26.Queries encointerFaucet;
}

class Extrinsics {
  Extrinsics();

  final _i2.Txs system = _i2.Txs();

  final _i3.Txs parachainSystem = _i3.Txs();

  final _i5.Txs timestamp = _i5.Txs();

  final _i7.Txs balances = _i7.Txs();

  final _i11.Txs xcmpQueue = _i11.Txs();

  final _i12.Txs polkadotXcm = _i12.Txs();

  final _i14.Txs messageQueue = _i14.Txs();

  final _i27.Txs utility = _i27.Txs();

  final _i15.Txs treasury = _i15.Txs();

  final _i16.Txs proxy = _i16.Txs();

  final _i17.Txs scheduler = _i17.Txs();

  final _i18.Txs collective = _i18.Txs();

  final _i19.Txs membership = _i19.Txs();

  final _i20.Txs encointerScheduler = _i20.Txs();

  final _i21.Txs encointerCeremonies = _i21.Txs();

  final _i22.Txs encointerCommunities = _i22.Txs();

  final _i23.Txs encointerBalances = _i23.Txs();

  final _i24.Txs encointerBazaar = _i24.Txs();

  final _i25.Txs encointerReputationCommitments = _i25.Txs();

  final _i26.Txs encointerFaucet = _i26.Txs();
}

class Constants {
  Constants();

  final _i2.Constants system = _i2.Constants();

  final _i5.Constants timestamp = _i5.Constants();

  final _i7.Constants balances = _i7.Constants();

  final _i8.Constants transactionPayment = _i8.Constants();

  final _i11.Constants xcmpQueue = _i11.Constants();

  final _i14.Constants messageQueue = _i14.Constants();

  final _i27.Constants utility = _i27.Constants();

  final _i15.Constants treasury = _i15.Constants();

  final _i16.Constants proxy = _i16.Constants();

  final _i17.Constants scheduler = _i17.Constants();

  final _i18.Constants collective = _i18.Constants();

  final _i20.Constants encointerScheduler = _i20.Constants();

  final _i21.Constants encointerCeremonies = _i21.Constants();

  final _i22.Constants encointerCommunities = _i22.Constants();

  final _i23.Constants encointerBalances = _i23.Constants();

  final _i26.Constants encointerFaucet = _i26.Constants();
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
    return ['CheckMortality', 'CheckNonce', 'ChargeAssetTxPayment'];
  }

  List getSignedExtensionExtra() {
    return ['CheckSpecVersion', 'CheckTxVersion', 'CheckGenesis', 'CheckMortality'];
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

  _i28.Future connect() async {
    return await _provider.connect();
  }

  _i28.Future disconnect() async {
    return await _provider.disconnect();
  }
}
