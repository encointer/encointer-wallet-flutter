// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i24;

import 'package:polkadart/polkadart.dart' as _i1;

import 'pallets/aura.dart' as _i23;
import 'pallets/balances.dart' as _i6;
import 'pallets/encointer_balances.dart' as _i15;
import 'pallets/encointer_bazaar.dart' as _i16;
import 'pallets/encointer_ceremonies.dart' as _i13;
import 'pallets/encointer_communities.dart' as _i14;
import 'pallets/encointer_democracy.dart' as _i19;
import 'pallets/encointer_faucet.dart' as _i18;
import 'pallets/encointer_offline_payment.dart' as _i21;
import 'pallets/encointer_reputation_commitments.dart' as _i17;
import 'pallets/encointer_scheduler.dart' as _i12;
import 'pallets/encointer_treasuries.dart' as _i20;
import 'pallets/grandpa.dart' as _i8;
import 'pallets/proxy.dart' as _i9;
import 'pallets/randomness_collective_flip.dart' as _i3;
import 'pallets/scheduler.dart' as _i10;
import 'pallets/sudo.dart' as _i5;
import 'pallets/system.dart' as _i2;
import 'pallets/timestamp.dart' as _i4;
import 'pallets/transaction_payment.dart' as _i7;
import 'pallets/treasury.dart' as _i11;
import 'pallets/utility.dart' as _i22;

class Queries {
  Queries(_i1.StateApi api)
      : system = _i2.Queries(api),
        randomnessCollectiveFlip = _i3.Queries(api),
        timestamp = _i4.Queries(api),
        sudo = _i5.Queries(api),
        balances = _i6.Queries(api),
        transactionPayment = _i7.Queries(api),
        grandpa = _i8.Queries(api),
        proxy = _i9.Queries(api),
        scheduler = _i10.Queries(api),
        treasury = _i11.Queries(api),
        encointerScheduler = _i12.Queries(api),
        encointerCeremonies = _i13.Queries(api),
        encointerCommunities = _i14.Queries(api),
        encointerBalances = _i15.Queries(api),
        encointerBazaar = _i16.Queries(api),
        encointerReputationCommitments = _i17.Queries(api),
        encointerFaucet = _i18.Queries(api),
        encointerDemocracy = _i19.Queries(api),
        encointerTreasuries = _i20.Queries(api),
        encointerOfflinePayment = _i21.Queries(api);

  final _i2.Queries system;

  final _i3.Queries randomnessCollectiveFlip;

  final _i4.Queries timestamp;

  final _i5.Queries sudo;

  final _i6.Queries balances;

  final _i7.Queries transactionPayment;

  final _i8.Queries grandpa;

  final _i9.Queries proxy;

  final _i10.Queries scheduler;

  final _i11.Queries treasury;

  final _i12.Queries encointerScheduler;

  final _i13.Queries encointerCeremonies;

  final _i14.Queries encointerCommunities;

  final _i15.Queries encointerBalances;

  final _i16.Queries encointerBazaar;

  final _i17.Queries encointerReputationCommitments;

  final _i18.Queries encointerFaucet;

  final _i19.Queries encointerDemocracy;

  final _i20.Queries encointerTreasuries;

  final _i21.Queries encointerOfflinePayment;
}

class Extrinsics {
  Extrinsics();

  final _i2.Txs system = _i2.Txs();

  final _i4.Txs timestamp = _i4.Txs();

  final _i5.Txs sudo = _i5.Txs();

  final _i6.Txs balances = _i6.Txs();

  final _i8.Txs grandpa = _i8.Txs();

  final _i22.Txs utility = _i22.Txs();

  final _i9.Txs proxy = _i9.Txs();

  final _i10.Txs scheduler = _i10.Txs();

  final _i11.Txs treasury = _i11.Txs();

  final _i12.Txs encointerScheduler = _i12.Txs();

  final _i13.Txs encointerCeremonies = _i13.Txs();

  final _i14.Txs encointerCommunities = _i14.Txs();

  final _i15.Txs encointerBalances = _i15.Txs();

  final _i16.Txs encointerBazaar = _i16.Txs();

  final _i17.Txs encointerReputationCommitments = _i17.Txs();

  final _i18.Txs encointerFaucet = _i18.Txs();

  final _i19.Txs encointerDemocracy = _i19.Txs();

  final _i20.Txs encointerTreasuries = _i20.Txs();

  final _i21.Txs encointerOfflinePayment = _i21.Txs();
}

class Constants {
  Constants();

  final _i2.Constants system = _i2.Constants();

  final _i4.Constants timestamp = _i4.Constants();

  final _i6.Constants balances = _i6.Constants();

  final _i7.Constants transactionPayment = _i7.Constants();

  final _i23.Constants aura = _i23.Constants();

  final _i8.Constants grandpa = _i8.Constants();

  final _i22.Constants utility = _i22.Constants();

  final _i9.Constants proxy = _i9.Constants();

  final _i10.Constants scheduler = _i10.Constants();

  final _i11.Constants treasury = _i11.Constants();

  final _i12.Constants encointerScheduler = _i12.Constants();

  final _i13.Constants encointerCeremonies = _i13.Constants();

  final _i14.Constants encointerCommunities = _i14.Constants();

  final _i15.Constants encointerBalances = _i15.Constants();

  final _i18.Constants encointerFaucet = _i18.Constants();

  final _i19.Constants encointerDemocracy = _i19.Constants();

  final _i20.Constants encointerTreasuries = _i20.Constants();

  final _i21.Constants encointerOfflinePayment = _i21.Constants();
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

  _i24.Future connect() async {
    return await _provider.connect();
  }

  _i24.Future disconnect() async {
    return await _provider.disconnect();
  }
}
