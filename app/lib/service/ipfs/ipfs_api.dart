import 'dart:convert';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:ew_http/ew_http.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:html/parser.dart' as html;

class IpfsApi {
  const IpfsApi(this.ewHttp, {this.gateway = encointerIpfsUrl});

  final EwHttp ewHttp;
  final String gateway;

  static const String lsRequest = '/api/v0/ls';
  static const String catRequest = '/api/v0/cat';

  Future<String?> getCommunityIcon(String ipfsCid) async {
    if (ipfsCid.isEmpty) {
      Log.d('[IPFS] return default icon (no CID set)', 'Ipfs');
      return null;
    }
    return getFileFromFolder(ipfsCid, communityIconName);
  }

  Future<IpfsBusiness> getIpfsBusiness(String businessIpfsCid) async {
    final response = await ewHttp.getType(ipfsUrl(businessIpfsCid), fromJson: IpfsBusiness.fromJson);
    return response.fold((l) {
      Log.e('[getIpfsBusiness] error: $l', 'Ipfs');
      throw Exception('[getIpfsBusiness] error getting business data: $l');
    }, (r) => r);
  }

  Future<String?> getFileFromFolder(String folderCid, String assetName) async {
    final url = '$gateway/ipfs/$folderCid/$assetName';
    final response = await ewHttp.get<String>(url);

    return response.fold((l) {
      Log.e('[getFileFromFolder] error: $l', 'Ipfs');
      return null;
    }, (r) => r);
  }

  /// Tries to list a folder. Uses API if available, otherwise falls back to gateway HTML.
  Future<List<IpfsLink>> listFolderDetailed(String folderCid) async {
    try {
      // Try API first
      final apiUrl = '$gateway$lsRequest';
      final response = await ewHttp.postForm<Map<String, dynamic>>(
        apiUrl,
        fields: {'arg': folderCid},
        decodeResponse: (res) => jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
      );

      return response.fold((l) {
        Log.d('[listFolderDetailed] API not available, fallback to gateway', 'Ipfs');
        return _listViaGateway(folderCid);
      }, (r) {
        final objects = (r['Objects'] as List?) ?? [];
        if (objects.isEmpty) return <IpfsLink>[];

        final links = (objects.first['Links'] as List?) ?? [];
        return links.map((link) => IpfsLink.fromJson(link as Map<String, dynamic>)).toList();
      });
    } catch (e, s) {
      Log.d('[listFolderDetailed] API call failed, fallback: $e', 'Ipfs', s);
      return _listViaGateway(folderCid);
    }
  }

  /// Fallback: parse HTML from public gateway directory listings
  Future<List<IpfsLink>> _listViaGateway(String folderCid) async {
    final url = Uri.parse('$gateway/ipfs/$folderCid/');
    final response = await ewHttp.get<String>(url.toString());

    return response.fold((l) {
      Log.e('[listViaGateway] failed: $l', 'Ipfs');
      return <IpfsLink>[];
    }, (htmlContent) {
      final document = html.parse(htmlContent);
      final anchors = document.querySelectorAll('a');

      return anchors
          .map((a) => a.text.trim())
          .where((name) => name.isNotEmpty && name != 'Parent directory')
          .map((name) => IpfsLink(name: name, hash: '', size: 0, type: name.contains('.') ? 'File' : 'Dir'))
          .toList();
    });
  }

  /// Lists just the file/folder names
  Future<List<String>> listFolder(String folderCid) async {
    final detailed = await listFolderDetailed(folderCid);
    return detailed.map((e) => e.name).toList();
  }

  /// Recursive listing (API or fallback)
  Future<List<String>> listFolderRecursive(String rootCid, {String prefix = ''}) async {
    final result = <String>[];

    final entries = await listFolderDetailed(rootCid);
    for (final entry in entries) {
      final path = prefix.isEmpty ? entry.name : '$prefix/${entry.name}';
      if (entry.type == 'Dir') {
        final nested = await listFolderRecursive(entry.hash.isEmpty ? rootCid : entry.hash, prefix: path);
        result.addAll(nested);
      } else {
        result.add(path);
      }
    }

    return result;
  }

  /// Reads file content
  Future<String?> cat(String fileCid) async {
    final apiUrl = '$gateway$catRequest';
    final response = await ewHttp.postForm<String>(
      apiUrl,
      fields: {'arg': fileCid},
      decodeResponse: (res) => utf8.decode(res.bodyBytes),
    );

    return response.fold((l) async {
      // fallback: try reading via gateway
      final fallback = await ewHttp.get<String>('$gateway/ipfs/$fileCid');
      return fallback.fold((_) => null, (r) => r);
    }, (r) => r);
  }

  String ipfsUrl(String cid) => '$gateway/ipfs/$cid';
}

/// Internal model for an IPFS ls result.
class IpfsLink {
  IpfsLink({
    required this.name,
    required this.hash,
    required this.size,
    required this.type,
  }); // "File" or "Dir"

  factory IpfsLink.fromJson(Map<String, dynamic> json) {
    return IpfsLink(
      name: json['Name'] as String? ?? '',
      hash: json['Hash'] as String? ?? '',
      size: json['Size'] is int ? json['Size'] as int : int.tryParse('${json['Size']}') ?? 0,
      type: (json['Type'] == 1) ? 'Dir' : 'File',
    );
  }

  final String name;
  final String hash;
  final int size;
  final String type;
}
