import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:encointer_wallet/service/ipfs/ipfs_auth_service.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_log/ew_log.dart';
import 'package:http/http.dart' as http;

const _logTarget = 'IpfsUpload';

class IpfsUploadResult {
  IpfsUploadResult({
    required this.hash,
    required this.name,
    required this.size,
    this.remainingUploads,
  });

  factory IpfsUploadResult.fromJson(Map<String, dynamic> json) => IpfsUploadResult(
        hash: json['Hash'] as String,
        name: json['Name'] as String,
        size: json['Size'] as String,
        remainingUploads: json['remaining_uploads'] as int?,
      );

  final String hash;
  final String name;
  final String size;
  final int? remainingUploads;
}

class IpfsUploadException implements Exception {
  IpfsUploadException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'IpfsUploadException: $message (status: $statusCode)';
}

class IpfsUploadService {
  IpfsUploadService(this._authService, {required this.gatewayUrl, http.Client? client})
      : _client = client ?? http.Client();

  final IpfsAuthService _authService;
  final String gatewayUrl;
  final http.Client _client;

  /// Uploads a file to IPFS via the authenticated gateway.
  Future<IpfsUploadResult> uploadFile({
    required File file,
    required String address,
    required String communityId,
    required Sr25519KeyPair keyPair,
    String? filename,
  }) async {
    final bytes = await file.readAsBytes();
    return uploadBytes(
      bytes: bytes,
      filename: filename ?? file.uri.pathSegments.last,
      address: address,
      communityId: communityId,
      keyPair: keyPair,
    );
  }

  /// Uploads raw bytes to IPFS via the authenticated gateway.
  Future<IpfsUploadResult> uploadBytes({
    required Uint8List bytes,
    required String filename,
    required String address,
    required String communityId,
    required Sr25519KeyPair keyPair,
    String? mimeType,
  }) async {
    // Get JWT token
    final token = await _authService.getToken(
      address: address,
      communityId: communityId,
      keyPair: keyPair,
    );

    if (token == null) {
      throw IpfsUploadException('Authentication failed');
    }

    Log.d('[IpfsUpload] Uploading $filename (${bytes.length} bytes)', _logTarget);

    // Build multipart request
    final uri = Uri.parse('$gatewayUrl/ipfs/add');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: filename,
      ));

    try {
      final streamed = await _client.send(request);
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        final result = IpfsUploadResult.fromJson(json);
        Log.d('[IpfsUpload] Success: ${result.hash}', _logTarget);
        return result;
      }

      // Handle specific errors
      if (response.statusCode == HttpStatus.unauthorized) {
        // Token may be invalid, clear cache and retry once
        _authService.clearToken(communityId);
        throw IpfsUploadException('Unauthorized - please try again', statusCode: response.statusCode);
      }

      if (response.statusCode == HttpStatus.forbidden) {
        throw IpfsUploadException('Not a CC holder for this community', statusCode: response.statusCode);
      }

      if (response.statusCode == 429) {
        throw IpfsUploadException('Rate limit exceeded - try again later', statusCode: response.statusCode);
      }

      throw IpfsUploadException('Upload failed: ${response.body}', statusCode: response.statusCode);
    } catch (e) {
      if (e is IpfsUploadException) rethrow;
      Log.e('[IpfsUpload] Error: $e', _logTarget);
      throw IpfsUploadException('Network error: $e');
    }
  }

  /// Uploads JSON data to IPFS.
  Future<IpfsUploadResult> uploadJson({
    required Map<String, dynamic> data,
    required String filename,
    required String address,
    required String communityId,
    required Sr25519KeyPair keyPair,
  }) async {
    final jsonBytes = Uint8List.fromList(utf8.encode(jsonEncode(data)));
    return uploadBytes(
      bytes: jsonBytes,
      filename: filename,
      address: address,
      communityId: communityId,
      keyPair: keyPair,
      mimeType: 'application/json',
    );
  }
}
