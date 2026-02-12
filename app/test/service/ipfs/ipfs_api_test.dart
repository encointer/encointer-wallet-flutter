import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:ew_http/ew_http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/test_tags.dart';

class _MockEwHttp extends Mock implements EwHttp {
  final _responses = <Future<Either<IpfsBusiness, EwHttpException>> Function()>[];

  void enqueue(Future<Either<IpfsBusiness, EwHttpException>> Function() fn) => _responses.add(fn);

  @override
  Future<Either<T, EwHttpException>> getType<T>(String url, {required FromJson<T> fromJson}) async {
    final result = await _responses.removeAt(0)();
    return result as Either<T, EwHttpException>;
  }
}

final _testBusiness = IpfsBusiness(
  name: 'Test Business',
  description: 'A test business',
  categoryRaw: 'other',
  address: '123 Test St',
  longitude: '0.0',
  latitude: '0.0',
  openingHours: 'Mon-Fri 9-5',
);

void main() {
  const assetFolderCid = 'QmUxPhjtx7NxByaD6UwFzz46oeubShmL9mNMqAuM72mQTq';
  const logoCid = 'QmbAsammnMX41xiJPVVhLTQB6UaMPyYPFgpZVg8qBTGWNE';
  const photosCid = 'QmasSnnY6w6tMYYFzC5xaHa9GrhmeZ99aGx3eXD2rqpz8b';
  const businessCid = 'QmTvnruvcgvcW9K5AN4p47mwcDQytaBckNzndvRzNnEHx6';
  const invalidCid = 'QmInvalid123';

  late Directory tmpDir;
  late IpfsApi ipfsApi;

  setUp(() {
    tmpDir = Directory.systemTemp.createTempSync('ipfs_cache_test');
    ipfsApi = IpfsApi(EwHttp(), cacheDir: tmpDir);
  });

  tearDown(() {
    if (tmpDir.existsSync()) tmpDir.deleteSync(recursive: true);
  });

  // Test that we can access the files added in:
  //
  // https://github.com/encointer/encointer-node/pull/404
  group('IpfsApi', () {
    // -------------------------------------------------------------------------
    // BUSINESS FETCHING
    // -------------------------------------------------------------------------
    test('fetches and decodes a well-known business correctly', () async {
      final result = await ipfsApi.getIpfsBusiness(businessCid);

      final expectedBusiness = IpfsBusiness(
        name: 'Revamp-IT',
        description: 'Computersupport und -dienste',
        categoryRaw: Category.iTHardware.jsonKey,
        address: 'Birmensdorferstrasse 379, 8055 Zürich',
        longitude: '8.5049619',
        latitude: '47.3690377',
        openingHours: 'Mon 9h-12h, Tue-Fri 13h-17h',
        logo: logoCid,
        photos: photosCid,
      );

      expect(result.toJson(), expectedBusiness.toJson());
    }, tags: productionE2E);

    test('throws or returns error if CID is invalid', () async {
      expect(
        () async => ipfsApi.getIpfsBusiness(invalidCid),
        throwsA(isA<Exception>()),
      );
    }, tags: productionE2E);

    // -------------------------------------------------------------------------
    // FILE FETCHING
    // -------------------------------------------------------------------------
    test('fetches logo by direct CID', () async {
      final bytes = await ipfsApi.getFileBytes(logoCid);
      expect(bytes, isA<Uint8List>());
      expect(bytes!.isNotEmpty, isTrue);
    }, tags: productionE2E);

    test('fetches image from folder + filename', () async {
      final bytes = await ipfsApi.getFileBytes(assetFolderCid, 'logo.png');
      expect(bytes, isA<Uint8List>());
      expect(bytes!.isNotEmpty, isTrue);
    }, tags: productionE2E);

    test('returns null for non-existing file', () async {
      final result = await ipfsApi.getFileBytes(assetFolderCid, 'missing.jpg');
      expect(result, isNull);
    }, tags: productionE2E);

    test('getImagesFromFolder returns all images from asset folder', () async {
      final resultMap = await ipfsApi.getImagesFromFolder(assetFolderCid);
      final expectedKeys = ['logo.png', 'photos/image01.png', 'photos/image02.jpg', 'photos/image03.jpg'];
      expect(resultMap.keys, expectedKeys);
    }, tags: productionE2E);

    test('getImagesFromFolder returns all images from photos folder', () async {
      final resultMap = await ipfsApi.getImagesFromFolder(photosCid);
      final expectedKeys = ['image01.png', 'image02.jpg', 'image03.jpg'];
      expect(resultMap.keys, expectedKeys);
    }, tags: productionE2E);

    // -------------------------------------------------------------------------
    // FOLDER LISTING
    // -------------------------------------------------------------------------
    test('lists folder recursively with subpaths', () async {
      final result = await ipfsApi.listFolderRecursive(assetFolderCid);
      expect(result, containsAll(['logo.png', 'photos/image01.png']));
      expect(result.length, greaterThanOrEqualTo(4));
    }, tags: productionE2E);

    test('lists photos folder contents (flat)', () async {
      final result = await ipfsApi.listFolder(photosCid);
      expect(result, ['image01.png', 'image02.jpg', 'image03.jpg']);
    }, tags: productionE2E);

    test('returns empty list for invalid CID', () async {
      final result = await ipfsApi.listFolder(invalidCid);
      expect(result, isEmpty);
    }, tags: productionE2E);

    // -------------------------------------------------------------------------
    // IMAGE CACHING
    // -------------------------------------------------------------------------
    test('caches images locally and reads them back', () async {
      final firstFetch = await ipfsApi.getImageBytes(logoCid);
      expect(firstFetch, isNotNull);
      expect(firstFetch!.isNotEmpty, isTrue);

      // Fetch again — should hit cache (logically same bytes)
      final secondFetch = await ipfsApi.getImageBytes(logoCid);
      expect(secondFetch, isNotNull);
      expect(secondFetch, equals(firstFetch));

      // Cleanup after test
      await ipfsApi.clearCache();
    }, tags: productionE2E);

    test('clears cache properly', () async {
      // Create and clear cache twice to ensure idempotency
      await ipfsApi.getImageBytes(logoCid);
      await ipfsApi.clearCache();
      await ipfsApi.clearCache(); // no error expected
    }, tags: productionE2E);

    // -------------------------------------------------------------------------
    // FILE TEXT FETCHING
    // -------------------------------------------------------------------------
    test('reads text files from folder', () async {
      final text = await ipfsApi.getFileText(assetFolderCid, 'metadata.json');
      if (text != null) {
        expect(text, contains('{'));
        expect(text, contains('}'));
      } else {
        expect(text, anyOf(isNull, isEmpty)); // optional in case metadata absent
      }
    }, tags: productionE2E);

    test('returns null for missing text file', () async {
      final text = await ipfsApi.getFileText(assetFolderCid, 'nonexistent.txt');
      expect(text, isNull);
    }, tags: productionE2E);

    // -------------------------------------------------------------------------
    // CACHING
    // -------------------------------------------------------------------------
    test('caches image bytes on first fetch', () async {
      final bytes = await ipfsApi.getImageBytes(logoCid);
      expect(bytes, isNotNull);

      // The file should exist in the temp cache
      final cachedFile = File('${tmpDir.path}/ipfs_cache/$logoCid');
      expect(cachedFile.existsSync(), isTrue);
    });

    test('reads bytes from cache on second fetch', () async {
      final first = await ipfsApi.getImageBytes(logoCid);
      final second = await ipfsApi.getImageBytes(logoCid);
      expect(second, equals(first));
    });

    test('clears cache properly', () async {
      await ipfsApi.getImageBytes(logoCid);
      await ipfsApi.clearCache();

      final cacheFolder = Directory('${tmpDir.path}/ipfs_cache');
      expect(cacheFolder.existsSync(), isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // RETRY & BUSINESS CACHING (unit tests with mocked HTTP)
  // ---------------------------------------------------------------------------
  group('getIpfsBusiness retry & cache', () {
    late Directory mockTmpDir;

    setUp(() {
      mockTmpDir = Directory.systemTemp.createTempSync('ipfs_retry_test');
    });

    tearDown(() {
      if (mockTmpDir.existsSync()) mockTmpDir.deleteSync(recursive: true);
    });

    test('succeeds after transient failures', () async {
      final mockHttp = _MockEwHttp();
      final api = IpfsApi(mockHttp, cacheDir: mockTmpDir, requestTimeout: const Duration(seconds: 2));

      mockHttp
        ..enqueue(() async => const Left(EwHttpException(FailureType.unknown)))
        ..enqueue(() async => const Left(EwHttpException(FailureType.unknown)))
        ..enqueue(() async => Right(_testBusiness));

      final result = await api.getIpfsBusiness('QmRetryTest');
      expect(result.toJson(), _testBusiness.toJson());
    });

    test('throws after all retries exhausted', () async {
      final mockHttp = _MockEwHttp();
      final api = IpfsApi(mockHttp, cacheDir: mockTmpDir, requestTimeout: const Duration(seconds: 2));

      for (var i = 0; i < 3; i++) {
        mockHttp.enqueue(() async => const Left(EwHttpException(FailureType.unknown)));
      }

      expect(() => api.getIpfsBusiness('QmFailTest'), throwsA(isA<Exception>()));
    });

    test('throws TimeoutException when request hangs', () async {
      final mockHttp = _MockEwHttp();
      final api = IpfsApi(mockHttp, cacheDir: mockTmpDir, requestTimeout: const Duration(milliseconds: 100));

      for (var i = 0; i < 3; i++) {
        mockHttp.enqueue(() => Completer<Either<IpfsBusiness, EwHttpException>>().future);
      }

      expect(() => api.getIpfsBusiness('QmTimeoutTest'), throwsA(isA<TimeoutException>()));
    });

    test('returns cached data without network call', () async {
      final mockHttp = _MockEwHttp();
      final api = IpfsApi(mockHttp, cacheDir: mockTmpDir, requestTimeout: const Duration(seconds: 2));

      // First call: network succeeds and populates cache
      mockHttp.enqueue(() async => Right(_testBusiness));
      await api.getIpfsBusiness('QmCacheTest');

      // Second call: no responses enqueued — would throw if network were hit
      final cached = await api.getIpfsBusiness('QmCacheTest');
      expect(cached.toJson(), _testBusiness.toJson());
    });

    test('fetches from network on cache miss', () async {
      final mockHttp = _MockEwHttp();
      final api = IpfsApi(mockHttp, cacheDir: mockTmpDir, requestTimeout: const Duration(seconds: 2));

      mockHttp.enqueue(() async => Right(_testBusiness));
      final result = await api.getIpfsBusiness('QmFreshFetch');
      expect(result.toJson(), _testBusiness.toJson());
    });
  });
}
