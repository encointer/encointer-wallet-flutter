import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_auth_service.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_upload_exception.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_upload_service.dart';
import 'package:ew_http/ew_http.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/test_tags.dart';

/// E2E test for IPFS upload via the production gateway.
///
/// Requires the environment variable `IPFS_E2E_MNEMONIC` to be set to the
/// mnemonic of a funded test account (>0.1 CC in the leu community).
void main() {
  const communityId = 'u0qj944rhWE';
  const gatewayUrl = ipfsAuthGatewayEncointer;

  late KeyringAccount account;
  late IpfsAuthService authService;
  late IpfsUploadService uploadService;

  setUpAll(() async {
    final env = Platform.environment['IPFS_E2E_MNEMONIC'];
    if (env == null || env.isEmpty) {
      fail('IPFS_E2E_MNEMONIC environment variable is not set');
    }

    account = await KeyringAccount.fromUri('e2e-test', env);

    final ewHttp = EwHttp();
    authService = IpfsAuthService(ewHttp, gatewayUrl: gatewayUrl);
    uploadService = IpfsUploadService(authService, gatewayUrl: gatewayUrl);
  });

  group('IPFS upload e2e', () {
    test('authenticate and get JWT token', () async {
      final token = await authService.getToken(
        address: account.pair.address,
        communityId: communityId,
        keyPair: account.pair,
      );
      expect(token, isNotEmpty);
    }, tags: ipfsUploadE2E);

    test('upload JSON and get CID', () async {
      final result = await uploadService.uploadJson(
        data: {'test': true, 'timestamp': DateTime.now().millisecondsSinceEpoch},
        filename: 'ci-test.json',
        address: account.pair.address,
        communityId: communityId,
        keyPair: account.pair,
      );
      expect(result.hash, startsWith('Qm'));
      expect(result.name, 'ci-test.json');
    }, tags: ipfsUploadE2E);

    test('upload bytes and get CID', () async {
      final bytes = Uint8List.fromList(utf8.encode('ipfs-upload-e2e-${DateTime.now().toIso8601String()}'));
      final result = await uploadService.uploadBytes(
        bytes: bytes,
        filename: 'ci-test.txt',
        address: account.pair.address,
        communityId: communityId,
        keyPair: account.pair,
      );
      expect(result.hash, startsWith('Qm'));
    }, tags: ipfsUploadE2E);

    test('unfunded random account is rejected', () async {
      final randomAccount = await KeyringAccount.generate('random');
      final randomAuthService = IpfsAuthService(EwHttp(), gatewayUrl: gatewayUrl);

      expect(
        () => randomAuthService.getToken(
          address: randomAccount.pair.address,
          communityId: communityId,
          keyPair: randomAccount.pair,
        ),
        throwsA(isA<IpfsUploadException>()),
      );
    }, tags: ipfsUploadE2E);
  });
}
