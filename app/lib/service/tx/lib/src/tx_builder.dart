import 'dart:typed_data';

import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/encointer_types.dart' show CommunityIdentifier;
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
    return createSignedExtrinsicWithEncodedCall(
      pair,
      call.encode(),
      paymentAsset: paymentAsset,
    );
  }

  /// Creates an extrinsic from an opaque call.
  Future<Uint8List> createSignedExtrinsicWithEncodedCall(
    Sr25519KeyPair pair,
    Uint8List encodedCall, {
    CommunityIdentifier? paymentAsset,
  }) async {
    final encointerKusama = EncointerKusama(provider);
    final encointerState = StateApi(provider);

    final customMetadata = await encointerState.getMetadata();
    // We have to use this special registry to use custom signed extensions
    final registry = customMetadata.chainInfo.scaleCodec.registry;

    // fetch recent relevant data from chain
    final runtimeVersion = await _getRuntimeVersion();
    final finalizedHash = await _getLatestFinalizedHash();
    final blockNumber = await _getBlockNumber(hash: finalizedHash);
    final genesisHash = await _getBlockHash(blockNumber: 0);
    final accountInfo = await encointerKusama.query.system.account(pair.publicKey.bytes);

    // print('RuntimeVersion: $runtimeVersion');
    // print('blockNumber: $blockNumber');
    // print('blockHash: $blockHash');
    // print('genesisHash: $genesisHash');
    // print('accountInfo: $accountInfo');

    // print('encodedCall: call');

    final payloadToSign = SigningPayload(
      method: encodedCall,
      specVersion: runtimeVersion.specVersion,
      transactionVersion: runtimeVersion.transactionVersion,
      genesisHash: genesisHash,
      blockHash: finalizedHash,
      blockNumber: blockNumber,
      eraPeriod: 64,
      nonce: accountInfo.nonce,
      tip: 0,
      customSignedExtensions: <String, dynamic>{
        'ChargeAssetTxPayment': {
          'tip': BigInt.zero,
          'asset_id':
              paymentAsset != null ? Option.some(paymentAsset.toJson()) : const Option<CommunityIdentifier>.none(),
        }, // A custom Signed Extensions
      },
    );

    final payload = payloadToSign.encode(registry);
    final signature = pair.sign(payload);

    final publicKey = Uint8List.fromList(pair.publicKey.bytes);
    final extrinsic = ExtrinsicPayload(
      signer: publicKey,
      method: encodedCall,
      signature: signature,
      eraPeriod: 64,
      blockNumber: blockNumber,
      nonce: accountInfo.nonce,
      tip: 0,
      customSignedExtensions: <String, dynamic>{
        'ChargeAssetTxPayment': {
          'tip': BigInt.zero,
          'asset_id':
              paymentAsset != null ? Option.some(paymentAsset.toJson()) : const Option<CommunityIdentifier>.none(),
        }, // A custom Signed Extensions
      },
    );

    return extrinsic.encode(registry, SignatureType.sr25519);
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

  Future<String> _getLatestFinalizedHash() async {
    final hash = (await provider.send('chain_getFinalizedHead', [])).result as String;
    return hash.replaceFirst('0x', '');
  }

  Future<int> _getBlockNumber({String? hash}) async {
    final params = hash != null ? [hash.replaceFirst('0x', '')] : <String>[];

    final block = await provider.send('chain_getBlock', params);

    // ignore: avoid_dynamic_calls
    final blockNumber = int.parse(block.result['block']['header']['number'] as String);
    return blockNumber;
  }
}
