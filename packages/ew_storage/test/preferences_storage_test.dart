import 'package:ew_storage/ew_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const mockKey = 'mock-key';
  const mockValue = 'mock-value';
  final mockException = Exception('oops');

  group('SecureStorage', () {
    late MockSharedPreferences preferences;
    late PreferencesStorage preferencesStorage;

    setUp(() async {
      preferences = MockSharedPreferences();
      preferencesStorage = await PreferencesStorage.getInstance(preferences);
    });

    test('Create SecureStorage constructor', () {
      expect(preferencesStorage, isNot(throwsA(isA<Exception>())));
    });

    group('Read', () {
      test('returns `mockValue` succesfully', () {
        when(() => preferences.getString(mockKey)).thenAnswer((_) => mockValue);
        final actual = preferencesStorage.read(key: mockKey);
        expect(actual, mockValue);
      });

      test('returns `null`', () {
        when(() => preferences.getString(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.read(key: mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.getString(mockKey)).thenThrow(mockException);
        expect(() => preferencesStorage.read(key: mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('Write', () {
      test('write succesfully', () async {
        when(() => preferences.setString(mockKey, mockValue)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.write(key: mockKey, value: mockValue), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.setString(mockKey, mockValue)).thenThrow(mockException);
        expect(() async => preferencesStorage.write(key: mockKey, value: mockValue), throwsA(isA<StorageException>()));
      });
    });

    group('Delete', () {
      test('delete successfully', () async {
        when(() => preferences.remove(mockKey)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.delete(key: mockKey), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.remove(mockKey)).thenThrow(mockException);
        expect(() async => preferencesStorage.delete(key: mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('Clear', () {
      test('clear successfully', () async {
        when(() => preferences.clear()).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.clear(), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.clear()).thenThrow(mockException);
        expect(() async => preferencesStorage.clear(), throwsA(isA<StorageException>()));
      });
    });
  });
}
