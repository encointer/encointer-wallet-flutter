import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/service/ipfs/models.dart';
import 'package:ew_http/ew_http.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:path/path.dart' as p;
import 'package:html/parser.dart' as html;

const logTarget = 'Ipfs';

class IpfsApi {
  const IpfsApi(this.ewHttp, {this.gateway = ipfsGatewayEncointer, Directory? cacheDir}) : _cacheDir = cacheDir;

  final EwHttp ewHttp;
  final String gateway;
  final Directory? _cacheDir;

  static const String lsRequest = '/api/v0/ls';
  static const String catRequest = '/api/v0/cat';

  Future<String?> getCommunityIcon(String ipfsCid) async {
    if (ipfsCid.isEmpty) {
      Log.d('[IPFS] return default icon (no CID set)', logTarget);
      return null;
    }
    return getFileText(ipfsCid, communityIconName);
  }

  Future<IpfsBusiness> getIpfsBusiness(String businessIpfsCid) async {
    final response = await ewHttp.getType(_buildIpfsUrl(businessIpfsCid), fromJson: IpfsBusiness.fromJson);
    return response.fold((l) {
      Log.e('[getIpfsBusiness] error: $l', logTarget);
      throw Exception('[getIpfsBusiness] error getting business data: $l');
    }, (r) => r);
  }

  // ---------------------------------------------------------------------------
  // Flexible fetchers
  // ---------------------------------------------------------------------------

  /// 🔤 Fetches text (UTF-8) from either a folder+filename or direct CID.
  Future<String?> getFileText(String cidOrFolder, [String? filename]) async {
    final url = _buildIpfsUrl(cidOrFolder, filename);
    final response = await ewHttp.get<String>(url);
    return response.fold((l) {
      Log.e('[getFileText] error: $l', 'Ipfs');
      return null;
    }, (r) => r);
  }

  /// 💾 Fetches file bytes from IPFS (no caching).
  Future<Uint8List?> getFileBytes(String cidOrFolder, [String? filename]) async {
    final url = _buildIpfsUrl(cidOrFolder, filename);
    final response = await ewHttp.getBytes(url);
    return response.fold((l) {
      Log.e('[getFileBytes] error: $l', 'Ipfs');
      return null;
    }, (r) => r);
  }

  /// 🖼️ Fetches and caches an image, works with folder+file OR direct CID.
  Future<Uint8List?> getImageBytes(String cidOrFolder, [String? imageName]) async {
    final cacheFile = await _getCachedFile(cidOrFolder, imageName);

    if (cacheFile.existsSync()) {
      Log.d('[IPFS] Cache hit for ${imageName ?? cidOrFolder}', 'Ipfs');
      return cacheFile.readAsBytes();
    }

    final url = _buildIpfsUrl(cidOrFolder, imageName);
    final response = await ewHttp.getBytes(url);
    return response.fold((l) {
      Log.e('[getImageBytes] error: $l', 'Ipfs');
      return null;
    }, (r) async {
      await cacheFile.create(recursive: true);
      await cacheFile.writeAsBytes(r);
      Log.d('[IPFS] Cached ${imageName ?? cidOrFolder}', 'Ipfs');
      return r;
    });
  }

  /// Recursively fetches all images under a folder CID (or a direct CID if single file)
  /// Returns a map: relative path → bytes
  Future<Map<String, Uint8List>> getImagesFromFolder(String cidOrFolder) async {
    final images = <String, Uint8List>{};

    // Try to list folder; if fails, assume single file
    final entries = await listFolderDetailed(cidOrFolder);
    if (entries.isEmpty) {
      // Single file, fetch directly
      final bytes = await getImageBytes(cidOrFolder);
      if (bytes != null) images[cidOrFolder] = bytes;
      return images;
    }

    // Recursive folder fetch
    for (final entry in entries) {
      Log.d('Image entry: name ${entry.name}, hash: ${entry.hash}, type: ${entry.type}');
      final path = entry.name;
      if (entry.type == 'Dir') {
        final nested = await getImagesFromFolder(entry.hash);
        nested.forEach((nestedPath, bytes) {
          images['$path/$nestedPath'] = bytes;
        });
      } else {
        final bytes = await getImageBytes(cidOrFolder, entry.name);
        if (bytes != null) images[path] = bytes;
      }
    }

    return images;
  }

  /// Tries to list a folder. Uses API if available, otherwise falls back to gateway HTML.
  Future<List<IpfsLink>> listFolderDetailed(String folderCid) async {
    try {
      final apiUrl = '$gateway$lsRequest';
      final response = await ewHttp.postForm<Map<String, dynamic>>(
        apiUrl,
        fields: {'arg': folderCid},
        decodeResponse: (res) => jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>,
      );

      return response.fold((l) {
        Log.d('[listFolderDetailed] API not available, fallback', logTarget);
        return _listViaGateway(folderCid).then((r) => r.links);
      }, (r) {
        // Convert API response into typed objects
        final lsResponse = IpfsLsResponse.fromJson(r);
        if (lsResponse.objects.isEmpty) return <IpfsLink>[];
        return lsResponse.objects.first.links;
      });
    } catch (e, s) {
      Log.d('[listFolderDetailed] API call failed, fallback: $e', logTarget, s);
      return _listViaGateway(folderCid).then((r) => r.links);
    }
  }

  /// Fallback: parse HTML from public gateway directory listings
  Future<IpfsObject> _listViaGateway(String folderCid) async {
    final url = Uri.parse('$gateway/ipfs/$folderCid/');

    final response = await ewHttp.get<String>(url.toString());

    return response.fold((l) {
      Log.e('[listViaGateway] failed: $l', logTarget);
      return IpfsObject(links: <IpfsLink>[]);
    }, (htmlContent) {
      final document = html.parse(htmlContent);

      // Each entry in modern gateways is a 4-column row:
      // 1. icon
      // 2. name (<a>filename</a>)
      // 3. hash (<a class="ipfs-hash">Qm...</a>)
      // 4. size
      //
      // These rows live inside: <div class="grid dir"> ... </div>

      final rows = document.querySelectorAll('.grid.dir > div');

      final List<IpfsLink> links = [];

      // Process in chunks of 4 columns per row
      for (var i = 0; i + 3 < rows.length; i += 4) {
        final nameCell = rows[i + 1];
        final hashCell = rows[i + 2];

        final nameAnchor = nameCell.querySelector('a');
        if (nameAnchor == null) continue;

        final name = nameAnchor.text.trim();
        if (name.isEmpty || name == 'Parent directory') continue;

        // ---- 2) Extract hash from the hash column ----
        String hash = '';
        final hashAnchor = hashCell.querySelector('a.ipfs-hash');
        if (hashAnchor != null) {
          final href = hashAnchor.attributes['href'] ?? '';

          // extract /ipfs/<CID>
          final idx = href.indexOf('/ipfs/');
          if (idx != -1) {
            final after = href.substring(idx + 6); // skip "/ipfs/"
            hash = after.split('?').first.split('/').first;
          }
        }

        // ---- 3) Determine type ----
        final type = name.contains('.') ? 'File' : 'Dir';

        links.add(IpfsLink(
          name: name,
          hash: hash,
          size: 0,
          type: type,
        ));
      }

      return IpfsObject(links: links);
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
        final nested = await listFolderRecursive(entry.hash.isNotEmpty ? entry.hash : rootCid, prefix: path);
        result.addAll(nested);
      } else {
        result.add(path);
      }
    }

    return result;
  }

  // ---------------------------------------------------------------------------
  // Cache handling
  // ---------------------------------------------------------------------------

  Future<File> _getCachedFile(String cidOrFolder, [String? filename]) async {
    final dir = _cacheDir ?? await Directory.systemTemp.createTemp();
    final cacheDir = Directory(p.join(dir.path, 'ipfs_cache'));
    if (!cacheDir.existsSync()) cacheDir.createSync(recursive: true);

    final safeName = filename ?? cidOrFolder;
    final fileName = safeName.replaceAll(RegExp('[^a-zA-Z0-9._-]'), '_');
    return File(p.join(cacheDir.path, fileName));
  }

  /// Clears the cache folder
  Future<void> clearCache() async {
    final dir = _cacheDir ?? await Directory.systemTemp.createTemp();
    final cacheDir = Directory(p.join(dir.path, 'ipfs_cache'));
    if (cacheDir.existsSync()) cacheDir.deleteSync(recursive: true);
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _buildIpfsUrl(String cidOrFolder, [String? filename]) {
    // if filename is provided: assume folder CID
    // otherwise: assume CID refers directly to a file
    if (filename != null && filename.isNotEmpty) {
      return '$gateway/ipfs/$cidOrFolder/$filename';
    } else {
      return '$gateway/ipfs/$cidOrFolder';
    }
  }
}
