import 'package:ew_storage/ew_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  const mockKey = 'mock-key';
  const mockValue = 'mock-value';
  final mockException = Exception('oops');

  group('SecureStorage', () {
    late FlutterSecureStorage flutterSecureStorage;
    late SecureStorage secureStorage;

    setUp(() {
      flutterSecureStorage = MockFlutterSecureStorage();
      secureStorage = SecureStorage(flutterSecureStorage);
    });

    test('Create SecureStorage constructor', () {
      expect(() => const SecureStorage(), isNot(throwsA(isA<Exception>())));
    });

    group('Read', () {
      test('returns `mockValue` succesfully', () async {
        when(() => flutterSecureStorage.read(key: mockKey)).thenAnswer((_) => Future.value(mockValue));
        final actual = await secureStorage.readAsync(key: mockKey);
        expect(actual, mockValue);
      });

      test('returns `null`', () async {
        when(() => flutterSecureStorage.read(key: mockKey)).thenAnswer((_) => Future<String?>.value());
        final actual = await secureStorage.readAsync(key: mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => flutterSecureStorage.read(key: mockKey)).thenThrow(mockException);
        expect(() async => secureStorage.readAsync(key: mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('Write', () {
      test('write succesfully', () async {
        when(() => flutterSecureStorage.write(key: mockKey, value: mockValue)).thenAnswer((_) => Future.value());
        expect(secureStorage.write<String>(key: mockKey, value: mockValue), completes);
      });

      test('throw `StorageException` Type fails', () async {
        when(() => flutterSecureStorage.write(key: mockKey, value: mockValue)).thenThrow(mockException);
        expect(() async => secureStorage.write<bool>(key: mockKey, value: true), throwsA(isA<StorageException>()));
      });

      test('throw `StorageException` fails', () async {
        when(() => flutterSecureStorage.write(key: mockKey, value: mockValue)).thenThrow(mockException);
        expect(
          () async => secureStorage.write<String>(key: mockKey, value: mockValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('Delete', () {
      test('delete successfully', () async {
        when(() => flutterSecureStorage.delete(key: mockKey)).thenAnswer((_) => Future.value());
        expect(secureStorage.delete(key: mockKey), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => flutterSecureStorage.delete(key: mockKey)).thenThrow(mockException);
        expect(() async => secureStorage.delete(key: mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('Clear', () {
      test('clear successfully', () async {
        when(() => flutterSecureStorage.deleteAll()).thenAnswer((_) => Future.value());
        expect(secureStorage.clear(), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => flutterSecureStorage.deleteAll()).thenThrow(mockException);
        expect(() async => secureStorage.clear(), throwsA(isA<StorageException>()));
      });
    });
  });
}
