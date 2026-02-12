import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_upload_exception.dart';
import 'package:ew_http/ew_http.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_log/ew_log.dart';

const _logTarget = 'IpfsAuth';

class AuthChallenge {
  AuthChallenge({required this.nonce, required this.timestamp, required this.message});

  factory AuthChallenge.fromJson(Map<String, dynamic> json) => AuthChallenge(
        nonce: json['nonce'] as String,
        timestamp: json['timestamp'] as int,
        message: json['message'] as String,
      );

  final String nonce;
  final int timestamp;
  final String message;
}

class AuthToken {
  AuthToken({required this.token, required this.expiresAt});

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        token: json['token'] as String,
        expiresAt: json['expires_at'] as int,
      );

  final String token;
  final int expiresAt;

  bool get isExpired => DateTime.now().millisecondsSinceEpoch >= expiresAt - 60000; // 1 min buffer
}

class IpfsAuthService {
  IpfsAuthService(this._ewHttp, {required this.gatewayUrl});

  final EwHttp _ewHttp;
  final String gatewayUrl;

  // Cache tokens per communityId
  final Map<String, AuthToken> _tokenCache = {};

  /// Gets a valid JWT token for the given community, authenticating if needed.
  ///
  /// Throws [IpfsUploadException] if authentication fails.
  Future<String> getToken({
    required String address,
    required String communityId,
    required Sr25519KeyPair keyPair,
  }) async {
    // Check cache
    final cached = _tokenCache[communityId];
    if (cached != null && !cached.isExpired) {
      Log.d('[IpfsAuth] Using cached token for $communityId', _logTarget);
      return cached.token;
    }

    // Authenticate (throws on failure)
    final token = await _authenticate(address: address, communityId: communityId, keyPair: keyPair);
    _tokenCache[communityId] = token;
    return token.token;
  }

  /// Clears cached token for a community (e.g., on logout or error).
  void clearToken(String communityId) {
    _tokenCache.remove(communityId);
  }

  /// Clears all cached tokens.
  void clearAllTokens() {
    _tokenCache.clear();
  }

  Future<AuthToken> _authenticate({
    required String address,
    required String communityId,
    required Sr25519KeyPair keyPair,
  }) async {
    Log.d('[IpfsAuth] Authenticating $address for community $communityId', _logTarget);

    // Step 1: Request challenge
    final challenge = await _requestChallenge(address, communityId);

    // Step 2: Sign the message
    final messageBytes = utf8.encode(challenge.message);
    final signature = keyPair.sign(Uint8List.fromList(messageBytes));
    final signatureHex = '0x${hex.encode(signature)}';

    Log.d('[IpfsAuth] Signed challenge, verifying...', _logTarget);

    // Step 3: Verify and get token
    return _verifySignature(
      address: address,
      communityId: communityId,
      signature: signatureHex,
      nonce: challenge.nonce,
      timestamp: challenge.timestamp,
    );
  }

  Future<AuthChallenge> _requestChallenge(String address, String communityId) async {
    final url = '$gatewayUrl/auth/challenge';
    final response = await _ewHttp.post<Map<String, dynamic>>(
      url,
      body: {'address': address, 'communityId': communityId},
    );

    return response.fold(
      (error) {
        Log.e('[IpfsAuth] Challenge request failed: $error', _logTarget);
        throw IpfsUploadException(
          'Challenge request failed: ${error.moreErrorData ?? error.failureType}',
          statusCode: error.statusCode,
        );
      },
      AuthChallenge.fromJson,
    );
  }

  Future<AuthToken> _verifySignature({
    required String address,
    required String communityId,
    required String signature,
    required String nonce,
    required int timestamp,
  }) async {
    final url = '$gatewayUrl/auth/verify';
    final response = await _ewHttp.post<Map<String, dynamic>>(
      url,
      body: {
        'address': address,
        'communityId': communityId,
        'signature': signature,
        'nonce': nonce,
        'timestamp': timestamp,
      },
    );

    return response.fold(
      (error) {
        Log.e('[IpfsAuth] Verify failed: $error', _logTarget);
        throw IpfsUploadException(
          'Authentication failed: ${error.moreErrorData ?? error.failureType}',
          statusCode: error.statusCode,
        );
      },
      (json) {
        Log.d('[IpfsAuth] Authentication successful', _logTarget);
        return AuthToken.fromJson(json);
      },
    );
  }
}
