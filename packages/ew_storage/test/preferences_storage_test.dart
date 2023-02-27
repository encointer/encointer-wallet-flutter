import 'package:ew_storage/ew_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const mockKey = 'mock-key';
  const mockValue = 'mock-value';
  const mockBoolValue = true;
  const mockDoubleValue = 0.7;
  const mockIntValue = 7;
  const mockListStringValue = ['a', 'b', 'c'];
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
      test('return String `mockValue` succesfully', () {
        when(() => preferences.getString(mockKey)).thenAnswer((_) => mockValue);
        final actual = preferencesStorage.getString(key: mockKey);
        expect(actual, mockValue);
      });

      test('return bool `mockBoolValue` succesfully', () {
        when(() => preferences.getBool(mockKey)).thenAnswer((_) => mockBoolValue);
        final actual = preferencesStorage.getBool(key: mockKey);
        expect(actual, mockBoolValue);
      });

      test('return double `mockDoubleValue` succesfully', () {
        when(() => preferences.getDouble(mockKey)).thenAnswer((_) => mockDoubleValue);
        final actual = preferencesStorage.getDouble(key: mockKey);
        expect(actual, mockDoubleValue);
      });

      test('return int `mockIntValue` succesfully', () {
        when(() => preferences.getInt(mockKey)).thenAnswer((_) => mockIntValue);
        final actual = preferencesStorage.getInt(key: mockKey);
        expect(actual, mockIntValue);
      });

      test('return List<String> `mockListStringValue` succesfully', () {
        when(() => preferences.getStringList(mockKey)).thenAnswer((_) => mockListStringValue);
        final actual = preferencesStorage.getStringList(key: mockKey);
        expect(actual, mockListStringValue);
      });

      test('return `null`', () {
        when(() => preferences.getString(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.getString(key: mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.getString(mockKey)).thenThrow(mockException);
        expect(() => preferencesStorage.getString(key: mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('Write', () {
      test('write String succesfully', () async {
        when(() => preferences.setString(mockKey, mockValue)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.setString(key: mockKey, value: mockValue), completes);
      });

      test('write bool `mockBoolValue` succesfully', () {
        when(() => preferences.setBool(mockKey, mockBoolValue)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.setBool(key: mockKey, value: mockBoolValue), completes);
      });

      test('return double `mockDoubleValue` succesfully', () {
        when(() => preferences.setDouble(mockKey, mockDoubleValue)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.setDouble(key: mockKey, value: mockDoubleValue), completes);
      });

      test('return int `mockIntValue` succesfully', () {
        when(() => preferences.setInt(mockKey, mockIntValue)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.setInt(key: mockKey, value: mockIntValue), completes);
      });

      test('return List<String> `mockListStringValue` succesfully', () {
        when(() => preferences.setStringList(mockKey, mockListStringValue)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.setStringList(key: mockKey, value: mockListStringValue), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.setString(mockKey, mockValue)).thenThrow(mockException);
        expect(
          () async => preferencesStorage.setString(key: mockKey, value: mockValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('Delete', () {
      test('delete successfully', () async {
        when(() => preferences.remove(mockKey)).thenAnswer((_) => Future.value(true));
        expect(preferencesStorage.remove(key: mockKey), completes);
      });

      test('throw `StorageException` fails', () async {
        when(() => preferences.remove(mockKey)).thenThrow(mockException);
        expect(() async => preferencesStorage.remove(key: mockKey), throwsA(isA<StorageException>()));
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
