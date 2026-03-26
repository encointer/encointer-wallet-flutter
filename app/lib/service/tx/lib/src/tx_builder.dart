import 'dart:isolate';
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
  ///
  /// Network I/O runs on the main isolate; CPU-intensive SCALE encoding and
  /// Sr25519 signing run in a background isolate to avoid ANR.
  Future<Uint8List> createSignedExtrinsicWithEncodedCall(
    Sr25519KeyPair pair,
    Uint8List encodedCall, {
    CommunityIdentifier? paymentAsset,
  }) async {
    final encointerKusama = EncointerKusama(provider);

    // Fetch raw metadata hex so we can reconstruct the Registry inside the
    // isolate (Registry contains closures and is not sendable).
    final metadataHex = (await provider.send('state_getMetadata', [])).result as String;

    // Fetch recent chain state (async I/O, non-blocking).
    final runtimeVersion = await _getRuntimeVersion();
    final finalizedHash = await _getLatestFinalizedHash();
    final blockNumber = await _getBlockNumber(hash: finalizedHash);
    final genesisHash = await _getBlockHash(blockNumber: 0);
    final accountInfo = await encointerKusama.query.system.account(pair.publicKey.bytes);

    // Extract primitives for the isolate closure.
    final nonce = accountInfo.nonce;
    final specVersion = runtimeVersion.specVersion;
    final transactionVersion = runtimeVersion.transactionVersion;
    final publicKeyBytes = Uint8List.fromList(pair.publicKey.bytes);
    final paymentAssetJson = paymentAsset?.toJson();

    // CPU-intensive work in a background isolate: reconstruct Registry from
    // metadata hex, SCALE-encode the payload, sign, and encode the extrinsic.
    return Isolate.run(() {
      final customMetadata = RuntimeMetadata.fromHex(metadataHex);
      final registry = customMetadata.chainInfo.scaleCodec.registry;

      final payloadToSign = SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: finalizedHash,
        blockNumber: blockNumber,
        eraPeriod: 64,
        nonce: nonce,
        tip: 0,
        customSignedExtensions: <String, dynamic>{
          'ChargeAssetTxPayment': {
            'tip': BigInt.zero,
            'asset_id':
                paymentAssetJson != null ? Option.some(paymentAssetJson) : const Option<CommunityIdentifier>.none(),
          },
        },
      );

      final payload = payloadToSign.encode(registry);
      final signature = pair.sign(payload);

      final extrinsic = ExtrinsicPayload(
        signer: publicKeyBytes,
        method: encodedCall,
        signature: signature,
        eraPeriod: 64,
        blockNumber: blockNumber,
        nonce: nonce,
        tip: 0,
        customSignedExtensions: <String, dynamic>{
          'ChargeAssetTxPayment': {
            'tip': BigInt.zero,
            'asset_id':
                paymentAssetJson != null ? Option.some(paymentAssetJson) : const Option<CommunityIdentifier>.none(),
          },
        },
      );

      return extrinsic.encode(registry, SignatureType.sr25519);
    });
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
