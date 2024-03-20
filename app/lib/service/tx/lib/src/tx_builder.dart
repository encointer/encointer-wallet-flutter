import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/runtime_call.dart';

class TxBuilder {
  TxBuilder(this.provider);

  final Provider provider;

  Future<Uint8List> createSignedExtrinsic(
    Sr25519KeyPair pair,
    RuntimeCall call, {
    CommunityIdentifier? paymentAsset,
  }) async {
    final encodedCall = hex.encode(call.encode());
    // print('encodedCall: $encodedCall');
    return createSignedExtrinsicWithEncodedCall(pair, encodedCall, paymentAsset: paymentAsset);
  }

  /// Creates an extrinsic from an opaque call.
  Future<Uint8List> createSignedExtrinsicWithEncodedCall(
    Sr25519KeyPair pair,
    String encodedCall, {
    CommunityIdentifier? paymentAsset,
  }) async {
    final encointerKusama = EncointerKusama(provider);
    final call = encodedCall.replaceFirst('0x', '');

    // fetch recent relevant data from chain
    final runtimeVersion = await _getRuntimeVersion();
    final blockNumber = await _getBlockNumber();
    final blockHash = await _getBlockHash(blockNumber: blockNumber);
    final genesisHash = await _getBlockHash(blockNumber: 0);
    final accountInfo = await encointerKusama.query.system.account(pair.publicKey.bytes);

    // print('RuntimeVersion: $runtimeVersion');
    // print('blockNumber: $blockNumber');
    // print('blockHash: $blockHash');
    // print('genesisHash: $genesisHash');
    // print('accountInfo: $accountInfo');

    // print('encodedCall: call');

    final payloadToSign = SigningPayload(
      method: call,
      specVersion: runtimeVersion.specVersion,
      transactionVersion: runtimeVersion.transactionVersion,
      genesisHash: genesisHash,
      blockHash: blockHash,
      blockNumber: blockNumber,
      eraPeriod: 64,
      nonce: accountInfo.nonce,
      tip: 0,
      assetId: paymentAsset,
    );

    final payload = payloadToSign.encode(encointerKusama.registry);
    final signature = pair.sign(payload);
    final hexSignature = hex.encode(signature);

    final publicKey = hex.encode(pair.publicKey.bytes);
    final extrinsic = Extrinsic.withSigningPayload(
      signer: publicKey,
      method: call,
      signature: hexSignature,
      payload: payloadToSign,
    );

    return extrinsic.encode(encointerKusama.registry, SignatureType.sr25519);
  }

  Future<RuntimeVersion> _getRuntimeVersion() async {
    final stateApi = StateApi(provider);
    final runtimeVersion = await stateApi.getRuntimeVersion();
    return runtimeVersion;
  }

  Future<String> _getBlockHash({int? blockNumber}) async {
    final params = blockNumber != null ? [blockNumber] : <int>[];
    final hash = (await provider.send('chain_getBlockHash', params)).result as String;

    return hash.replaceFirst('0x', '');
  }

  Future<int> _getBlockNumber() async {
    final block = await provider.send('chain_getBlock', []);

    // ignore: avoid_dynamic_calls
    final blockNumber = int.parse(block.result['block']['header']['number'] as String);
    return blockNumber;
  }
}
