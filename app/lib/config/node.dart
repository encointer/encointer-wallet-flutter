// import 'dart:convert';

// import 'package:json_annotation/json_annotation.dart';

// part 'node.g.dart';

// /// Overrides for the Gesell test network
// const NodeConfig gesellConfig = NodeConfig(gesellTypeOverrides, gesellPalletOverrides);

// /// Overrides for the Cantillon test network
// const NodeConfig cantillonConfig = NodeConfig(gesellTypeOverrides, gesellPalletOverrides);

// /// Overrides for the master branch of the `encointer-node`, which is usually used in a local
// /// no-tee-dev-setup
// const NodeConfig masterBranchConfig = NodeConfig(typeOverridesDev, palletOverridesDev);

// /// Overrides for the sgx-master branch of the `encointer-node`, which is usually used in a local
// /// tee-dev-setup
// const NodeConfig sgxBranchConfig = NodeConfig(gesellTypeOverrides, gesellPalletOverrides);

// /// Config to handle different versions of our nodes by supplying type overwrites
// /// and pallet names and methods overwrites.
// @JsonSerializable(explicitToJson: true)
// class NodeConfig {
//   const NodeConfig(this.types, this.pallets);

//   factory NodeConfig.fromJson(Map<String, dynamic> json) => _$NodeConfigFromJson(json);
//   Map<String, dynamic> toJson() => _$NodeConfigToJson(this);

//   /// type overwrites passed to the JS Api type-registry
//   final Map<String, dynamic>? types;

//   /// custom pallet config. The key is the current name of the pallet. The pallet
//   /// holds the overwrite data
//   final Map<String, Pallet>? pallets;

//   @override
//   String toString() {
//     return jsonEncode(this);
//   }
// }

// @JsonSerializable(explicitToJson: true)
// class Pallet {
//   const Pallet(this.name, this.calls);

//   factory Pallet.fromJson(Map<String, dynamic> json) => _$PalletFromJson(json);
//   Map<String, dynamic> toJson() => _$PalletToJson(this);

//   final String? name;
//   final Map<String, String>? calls;

//   @override
//   String toString() {
//     return jsonEncode(this);
//   }
// }

// const Map<String, dynamic> typeOverridesDev = {};
// const Map<String, Pallet> palletOverridesDev = {};

// /// Type overrides needed for Gesell
// const Map<String, dynamic> gesellTypeOverrides = {};

// /// Pallet overrides needed for Gesell
// const Map<String, Pallet> gesellPalletOverrides = {};
