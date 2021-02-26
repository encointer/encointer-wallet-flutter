import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';

const NodeConfig SgxMasterConfig = const NodeConfig(SgxMasterTypeOverrides, SgxMasterPalletOverrides);

@JsonSerializable(explicitToJson: true)
/// Config to handle different versions of our nodes by supplying type overwrites
/// and currently overwrite pallet names and methods that have been renamed.
class NodeConfig {
  /// type overwrites passed to the JS Api type-registry
  final Map<String, dynamic> types;
  /// custom pallet config. The key is the current name of the pallet. The pallet
  /// holds the overwrite data
  final Map<String, Pallet> pallets;

  const NodeConfig(this.types, this.pallets);

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory NodeConfig.fromJson(Map<String, dynamic> json) => _$NodeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$NodeConfigToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Pallet {
  final String name;
  final Map<String, String> calls;

  const Pallet(this.name, this.calls);


  @override
  String toString() {
    return jsonEncode(this);
  }

  factory Pallet.fromJson(Map<String, dynamic> json) => _$PalletFromJson(json);
  Map<String, dynamic> toJson() => _$PalletToJson(this);
}

const SgxMasterTypeOverrides = {
  'CurrencyIdentifier': 'Hash',
  'BalanceType': 'i128',
  'BalanceEntry': {
    'principal': 'i128',
    'last_update': 'BlockNumber'
  },
  'CurrencyCeremony': '(CurrencyIdentifier,CeremonyIndexType)',
  'CurrencyPropertiesType': {
    'name_utf8': 'Vec<u8>',
    'demurrage_per_block': 'Demurrage'
  },
  'GetterArgs': '(AccountId, CurrencyIdentifier)',
  'PublicGetter': {
    '_enum': {
      'total_issuance': 'CurrencyIdentifier',
      'participant_count': 'CurrencyIdentifier',
      'meetup_count': 'CurrencyIdentifier',
      'ceremony_reward': 'CurrencyIdentifier',
      'location_tolerance': 'CurrencyIdentifier',
      'time_tolerance': 'CurrencyIdentifier',
      'scheduler_state': 'CurrencyIdentifier'
    }
  },
  'TrustedGetter': {
    '_enum': {
      'balance': '(AccountId, CurrencyIdentifier)',
      'participant_index': '(AccountId, CurrencyIdentifier)',
      'meetup_index': '(AccountId, CurrencyIdentifier)',
      'attestations': '(AccountId, CurrencyIdentifier)',
      'meetup_registry': '(AccountId, CurrencyIdentifier)'
    }
  }
};

const Map<String, Pallet> SgxMasterPalletOverrides = {
  'encointerCommunities': const Pallet('encointerCurrencies', { 'communityIdentifiers': 'currencyIdentifiers'})
};
