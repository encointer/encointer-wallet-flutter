import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/ew_polkadart.dart';
import 'package:ew_polkadart/runtime_call.dart';

class TxBuilder {
  TxBuilder(this.provider);

  final Provider provider;

  Future<Uint8List> createSignedExtrinsic(Sr25519KeyPair pair, RuntimeCall call) async {
    final encointerKusama = EncointerKusama(provider);

    // fetch recent relevant data from chain
    final runtimeVersion = await _getRuntimeVersion();
    final blockNumber = await _getBlockNumber();
    final blockHash = await _getBlockHash();
    final genesisHash = await _getBlockHash(blockNumber: 0);
    final accountInfo = await encointerKusama.query.system.account(pair.publicKey.bytes);

    print('RuntimeVersion: $runtimeVersion');
    print('blockNumber: $blockNumber');
    print('blockHash: $blockHash');
    print('genesisHash: $genesisHash');
    print('accountInfo: $accountInfo');


    final encodedCall = hex.encode(call.encode());

    final payloadToSign = SigningPayload(
      method: encodedCall,
      specVersion: runtimeVersion.specVersion,
      transactionVersion: runtimeVersion.transactionVersion,
      genesisHash: genesisHash,
      blockHash: blockHash,
      blockNumber: blockNumber,
      eraPeriod: 64,
      nonce: accountInfo.nonce,
      tip: 0,
    );

    final payload = payloadToSign.encode(encointerKusama.registry);

    final signature = pair.sign(payload);
    final hexSignature = hex.encode(signature);

    final publicKey = hex.encode(pair.publicKey.bytes);
    final extrinsic = Extrinsic(
      signer: publicKey,
      method: encodedCall,
      signature: hexSignature,
      eraPeriod: 64,
      blockNumber: blockNumber,
      nonce: 0,
      tip: 0,
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
