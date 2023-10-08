// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/polkadart.dart' as _i1;import 'pallets/system.dart' as _i2;import 'pallets/parachain_system.dart' as _i3;import 'pallets/randomness_collective_flip.dart' as _i4;import 'pallets/timestamp.dart' as _i5;import 'pallets/parachain_info.dart' as _i6;import 'pallets/balances.dart' as _i7;import 'pallets/transaction_payment.dart' as _i8;import 'pallets/aura.dart' as _i9;import 'pallets/aura_ext.dart' as _i10;import 'pallets/xcmp_queue.dart' as _i11;import 'pallets/polkadot_xcm.dart' as _i12;import 'pallets/dmp_queue.dart' as _i13;import 'pallets/treasury.dart' as _i14;import 'pallets/proxy.dart' as _i15;import 'pallets/scheduler.dart' as _i16;import 'pallets/collective.dart' as _i17;import 'pallets/membership.dart' as _i18;import 'pallets/encointer_scheduler.dart' as _i19;import 'pallets/encointer_ceremonies.dart' as _i20;import 'pallets/encointer_communities.dart' as _i21;import 'pallets/encointer_balances.dart' as _i22;import 'pallets/encointer_bazaar.dart' as _i23;import 'pallets/encointer_reputation_commitments.dart' as _i24;import 'pallets/encointer_faucet.dart' as _i25;import 'pallets/utility.dart' as _i26;import 'dart:async' as _i27;class Queries {Queries(_i1.StateApi api) : system = _i2.Queries(api), parachainSystem = _i3.Queries(api), randomnessCollectiveFlip = _i4.Queries(api), timestamp = _i5.Queries(api), parachainInfo = _i6.Queries(api), balances = _i7.Queries(api), transactionPayment = _i8.Queries(api), aura = _i9.Queries(api), auraExt = _i10.Queries(api), xcmpQueue = _i11.Queries(api), polkadotXcm = _i12.Queries(api), dmpQueue = _i13.Queries(api), treasury = _i14.Queries(api), proxy = _i15.Queries(api), scheduler = _i16.Queries(api), collective = _i17.Queries(api), membership = _i18.Queries(api), encointerScheduler = _i19.Queries(api), encointerCeremonies = _i20.Queries(api), encointerCommunities = _i21.Queries(api), encointerBalances = _i22.Queries(api), encointerBazaar = _i23.Queries(api), encointerReputationCommitments = _i24.Queries(api), encointerFaucet = _i25.Queries(api);

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

final _i14.Queries treasury;

final _i15.Queries proxy;

final _i16.Queries scheduler;

final _i17.Queries collective;

final _i18.Queries membership;

final _i19.Queries encointerScheduler;

final _i20.Queries encointerCeremonies;

final _i21.Queries encointerCommunities;

final _i22.Queries encointerBalances;

final _i23.Queries encointerBazaar;

final _i24.Queries encointerReputationCommitments;

final _i25.Queries encointerFaucet;

 }
class Constants {Constants();

final _i2.Constants system = _i2.Constants();

final _i5.Constants timestamp = _i5.Constants();

final _i7.Constants balances = _i7.Constants();

final _i8.Constants transactionPayment = _i8.Constants();

final _i26.Constants utility = _i26.Constants();

final _i14.Constants treasury = _i14.Constants();

final _i15.Constants proxy = _i15.Constants();

final _i16.Constants scheduler = _i16.Constants();

final _i17.Constants collective = _i17.Constants();

final _i19.Constants encointerScheduler = _i19.Constants();

final _i20.Constants encointerCeremonies = _i20.Constants();

final _i21.Constants encointerCommunities = _i21.Constants();

final _i22.Constants encointerBalances = _i22.Constants();

final _i25.Constants encointerFaucet = _i25.Constants();

 }
class Rpc {const Rpc({required this.state});

final _i1.StateApi state;

 }
class EncointerKusama {EncointerKusama._(this._provider, this.rpc, ) : query = Queries(rpc.state), constant = Constants();

factory EncointerKusama(_i1.Provider provider) { final rpc = Rpc(state: _i1.StateApi(provider));
return  EncointerKusama._(provider, rpc, ); }

factory EncointerKusama.url(Uri url) { final provider = _i1.Provider(url);
return  EncointerKusama(provider); }

final _i1.Provider _provider;

final Queries query;

final Constants constant;

final Rpc rpc;

_i27.Future connect() async  { return   await _provider.connect(); } 
_i27.Future disconnect() async  { return   await _provider.disconnect(); } 
 }
