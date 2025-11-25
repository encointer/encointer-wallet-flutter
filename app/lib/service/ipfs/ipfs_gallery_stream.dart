import 'dart:typed_data';

import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';

class IpfsImageItem {
  const IpfsImageItem({
    required this.cidOrFolder,
    this.fileName,
    this.bytes,
  });

  final String cidOrFolder;
  final String? fileName;
  final Uint8List? bytes; // nullable: null = failed image

  bool get hasData => bytes != null;
}

extension IpfsApiGalleryStream on IpfsApi {
  /// Streams images progressively in order, with a maximum of [maxConcurrent] downloads at a time.
  Stream<IpfsImageItem> streamGalleryImagesQueued({
    required List<String> cidsOrFolders,
    Map<String, List<String>>? includeFiles,
    int maxConcurrent = 4,
  }) async* {
    // Step 1: build all fetch tasks in order
    final taskList = <Future<IpfsImageItem> Function()>[];

    for (final cidOrFolder in cidsOrFolders) {
      final included = includeFiles?[cidOrFolder];

      if (included != null && included.isNotEmpty) {
        for (final file in included) {
          taskList.add(() => _fetchImageWithPlaceholder(cidOrFolder, file));
        }
      } else {
        final entries = await listFolderDetailed(cidOrFolder);
        if (entries.isEmpty) {
          taskList.add(() => _fetchImageWithPlaceholder(cidOrFolder, null));
        } else {
          for (final entry in entries.where((e) => e.type == 'File')) {
            taskList.add(() => _fetchImageWithPlaceholder(cidOrFolder, entry.name));
          }
        }
      }
    }

    // Step 2: track results and active futures
    final results = List<IpfsImageItem?>.filled(taskList.length, null);
    var nextIndexToYield = 0;
    var nextTaskIndex = 0;
    final activeFutures = <Future<void>>[];

    while (nextIndexToYield < taskList.length) {
      // Start new tasks up to maxConcurrent
      while (activeFutures.length < maxConcurrent && nextTaskIndex < taskList.length) {
        final index = nextTaskIndex;

        late Future<void> future;
        future = taskList[index]().then((res) {
          results[index] = res;
        }).catchError((_) {
          results[index] = const IpfsImageItem(cidOrFolder: '');
        }).whenComplete(() {
          activeFutures.remove(future);
        });

        activeFutures.add(future);
        nextTaskIndex++;
      }

      // Yield completed images in order
      while (nextIndexToYield < results.length && results[nextIndexToYield] != null) {
        yield results[nextIndexToYield]!;
        nextIndexToYield++;
      }

      // Wait for at least one active future to complete before continuing
      if (nextIndexToYield < taskList.length && activeFutures.isNotEmpty) {
        await Future.any(activeFutures);
      }
    }
  }

  Future<IpfsImageItem> _fetchImageWithPlaceholder(String cidOrFolder, String? fileName) async {
    try {
      final bytes = await getImageBytes(cidOrFolder, fileName);
      return IpfsImageItem(cidOrFolder: cidOrFolder, fileName: fileName, bytes: bytes);
    } catch (_) {
      return IpfsImageItem(cidOrFolder: cidOrFolder, fileName: fileName);
    }
  }
}
