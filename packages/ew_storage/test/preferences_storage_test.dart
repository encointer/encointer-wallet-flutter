import 'package:ew_storage/ew_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const mockKey = 'mock-key';
  const mockStringValue = 'mock-value';
  const mockBoolValue = true;
  const mockIntValue = 1;
  const mockDoubleValue = 0.0;
  const mockStringListValue = [''];
  final mockException = Exception('oops');

  group('PreferencesStorage', () {
    late SharedPreferences sharedPreferences;
    late PreferencesStorage preferencesStorage;

    setUp(() async {
      sharedPreferences = MockSharedPreferences();
      preferencesStorage = await PreferencesStorage.getInstance(sharedPreferences);
    });

    group('getString', () {
      test('returns `mockStringValue` succesfully', () async {
        when(() => sharedPreferences.getString(mockKey)).thenAnswer((_) => mockStringValue);
        final actual = preferencesStorage.getString(mockKey);
        verify(() => sharedPreferences.getString(mockKey)).called(1);
        expect(actual, mockStringValue);
      });
      test('returns null', () {
        when(() => sharedPreferences.getString(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.getString(mockKey);
        verify(() => sharedPreferences.getString(mockKey)).called(1);
        expect(actual, isNull);
      });
      test('throw `StorageException` fails', () {
        when(() => sharedPreferences.getString(mockKey)).thenThrow(mockException);
        expect(() => preferencesStorage.getString(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('getBool', () {
      test('returns `mockValue` succesfully', () {
        when(() => sharedPreferences.getBool(mockKey)).thenAnswer((_) => mockBoolValue);
        final actual = preferencesStorage.getBool(mockKey);
        verify(() => sharedPreferences.getBool(mockKey)).called(1);
        expect(actual, mockBoolValue);
      });
      test('returns `null`', () {
        when(() => sharedPreferences.getBool(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.getBool(mockKey);
        verify(() => sharedPreferences.getBool(mockKey)).called(1);
        expect(actual, isNull);
      });
      test('throw `StorageException` fails', () {
        when(() => sharedPreferences.getBool(mockKey)).thenThrow(mockException);
        expect(() => preferencesStorage.getBool(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('getDouble', () {
      test('returns `mockDoubleValue` succesfully', () {
        when(() => sharedPreferences.getDouble(mockKey)).thenAnswer((_) => mockDoubleValue);
        final actual = preferencesStorage.getDouble(mockKey);
        verify(
          () => sharedPreferences.getDouble(mockKey),
        ).called(1);
        expect(actual, mockDoubleValue);
      });
      test('returns null', () {
        when(() => sharedPreferences.getDouble(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.getDouble(mockKey);
        verify(() => sharedPreferences.getDouble(mockKey)).called(1);
        expect(actual, isNull);
      });
      test('throw StorageException fails', () {
        when(() => sharedPreferences.getDouble(mockKey)).thenThrow(mockException);
        expect(() => preferencesStorage.getDouble(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('getInt', () {
      test('returns `mockIntValue` succesfully', () {
        when(() => sharedPreferences.getInt(mockKey)).thenAnswer((_) => mockIntValue);
        final value = preferencesStorage.getInt(mockKey);
        verify(() => sharedPreferences.getInt(mockKey)).called(1);
        expect(value, mockIntValue);
      });
      test('returns `null` succesfully', () {
        when(() => sharedPreferences.getInt(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.getInt(mockKey);
        verify(() => sharedPreferences.getInt(mockKey)).called(1);
        expect(actual, null);
      });
      test('throw `StorageException` fails', () {
        when(() => sharedPreferences.getInt(mockKey)).thenThrow(mockException);
        verifyNever(() => sharedPreferences.getInt(mockKey));
        expect(() => preferencesStorage.getInt(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('getStringList', () {
      test('returns `mockStringListValue` succesfully', () {
        when(() => sharedPreferences.getStringList(mockKey)).thenAnswer((_) => mockStringListValue);
        final actual = preferencesStorage.getStringList(mockKey);
        verify(() => sharedPreferences.getStringList(mockKey)).called(1);
        expect(actual, mockStringListValue);
      });
      test('returns `null`', () {
        when(() => sharedPreferences.getStringList(mockKey)).thenAnswer((_) => null);
        final actual = preferencesStorage.getStringList(mockKey);
        verify(() => sharedPreferences.getStringList(mockKey)).called(1);
        expect(actual, isNull);
      });
      test('throw `StorageException` fails', () {
        when(() => sharedPreferences.getStringList(mockKey)).thenThrow(mockException);
        verifyNever(() => sharedPreferences.getStringList(mockKey));
        expect(() => preferencesStorage.getStringList(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('setString', () {
      test('saves mockStringValue succesfully returns true', () async {
        when(() => sharedPreferences.setString(mockKey, mockStringValue)).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.setString(key: mockKey, value: mockStringValue);
        verify(() => sharedPreferences.setString(mockKey, mockStringValue)).called(1);
        expect(actual, isTrue);
      });
      test('throw `StorageException` when false', () async {
        when(() => sharedPreferences.setString(mockKey, mockStringValue)).thenThrow(mockException);
        expect(
          () async => preferencesStorage.setString(key: mockKey, value: mockStringValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('setBool', () {
      test('saves `mockBoolValue` succesfully', () async {
        when(() => sharedPreferences.setBool(mockKey, mockBoolValue)).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.setBool(key: mockKey, value: mockBoolValue);
        verify(() => sharedPreferences.setBool(mockKey, mockBoolValue)).called(1);
        expect(actual, isTrue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setBool(mockKey, mockBoolValue)).thenThrow(mockException);
        expect(
          () async => preferencesStorage.setBool(key: mockKey, value: mockBoolValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('setDouble', () {
      test('saves `mockDoubleValue` succesfully', () async {
        when(() => sharedPreferences.setDouble(mockKey, mockDoubleValue)).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.setDouble(key: mockKey, value: mockDoubleValue);
        verify(() => sharedPreferences.setDouble(mockKey, mockDoubleValue)).called(1);
        expect(actual, isTrue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setDouble(mockKey, mockDoubleValue)).thenThrow(mockException);
        expect(
          () async => preferencesStorage.setDouble(key: mockKey, value: mockDoubleValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('setInt', () {
      test('saves `mockIntValue` succesfully', () async {
        when(() => sharedPreferences.setInt(mockKey, mockIntValue)).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.setInt(key: mockKey, value: mockIntValue);
        verify(() => sharedPreferences.setInt(mockKey, mockIntValue)).called(1);
        expect(actual, isTrue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setInt(mockKey, mockIntValue)).thenThrow(mockException);
        expect(
          () async => preferencesStorage.setInt(key: mockKey, value: mockIntValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('setStringList', () {
      test('saves `mockIntValue` succesfully', () async {
        when(() => sharedPreferences.setStringList(mockKey, mockStringListValue)).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.setStringList(key: mockKey, value: mockStringListValue);
        verify(() => sharedPreferences.setStringList(mockKey, mockStringListValue)).called(1);
        expect(actual, isTrue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setStringList(mockKey, mockStringListValue)).thenThrow(mockException);
        expect(
          () async => preferencesStorage.setStringList(key: mockKey, value: mockStringListValue),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('Delete', () {
      test('delete successfully', () async {
        when(() => sharedPreferences.remove(mockKey)).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.delete(mockKey);
        verify(() => sharedPreferences.remove(mockKey)).called(1);
        expect(actual, isTrue);
      });

      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.remove(mockKey)).thenThrow(mockException);
        expect(() async => preferencesStorage.delete(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('Clear', () {
      test('clear successfully', () async {
        when(() => sharedPreferences.clear()).thenAnswer((_) => Future.value(true));
        final actual = await preferencesStorage.clear();
        verify(() => sharedPreferences.clear()).called(1);
        expect(actual, isTrue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.clear()).thenThrow(mockException);
        expect(() async => preferencesStorage.clear(), throwsA(isA<StorageException>()));
      });
    });
  });
}
