import 'package:ew_storage/src/storages/storage_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const mockKey = 'mock-key';
  const mockStringValue = 'mock-value';
  const mockBoolValue = true;
  const mockIntValue = 1;
  final mockException = Exception('oops');

  group('PreferencesStorage', () {
    late SharedPreferences sharedPreferences;

    setUp(() {
      sharedPreferences = MockSharedPreferences();
    });
    group('getString', () {
      test('returns `mockValue` succesfully', () async {
        when(() => sharedPreferences.getString(mockKey)).thenAnswer((_) => mockValue);
        final actual = sharedPreferences.getString(mockKey);
        expect(actual, mockValue);
      });
      test('returns `null`', () async {
        when(() => sharedPreferences.getString(mockKey)).thenAnswer((_) => mockValue);
        final actual = sharedPreferences.getString(mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.getString(mockKey)).thenThrow(mockException);
        expect(() async => sharedPreferences.getString(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('getBool', () {
      test('returns `mockValue` succesfully', () async {
        when(() => sharedPreferences.getBool(mockKey)).thenAnswer((_) => true);
        final actual = sharedPreferences.getBool(mockKey);
        expect(actual, mockValue);
      });
      test('returns `null`', () async {
        when(() => sharedPreferences.getBool(mockKey)).thenAnswer((_) => true);
        final actual = sharedPreferences.getBool(mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.getBool(mockKey)).thenThrow(mockException);
        expect(() async => sharedPreferences.getBool(mockKey), throwsA(isA<StorageException>()));
      });
    });
    group('getDouble', () {
      test('returns `mockValue` succesfully', () async {
        when(() => sharedPreferences.getDouble(mockKey)).thenAnswer((_) => 00);

        /// do we have defined Mockvalue?
        final actual = sharedPreferences.getDouble(mockKey);
        expect(actual, mockValue);
      });
      test('returns `null`', () async {
        when(() => sharedPreferences.getDouble(mockKey)).thenAnswer((_) => 00);

        ///here I need a hint
        final actual = sharedPreferences.getDouble(mockKey);
        expect(actual, isNull);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.getDouble(mockKey)).thenThrow(mockException);
        expect(() async => sharedPreferences.getDouble(mockKey), throwsA(isA<StorageException>()));
      });
    });

    group('getInt', () {
      test('returns `mock-int-value` succesfully', () async {
        when(() => sharedPreferences.getInt(mockKey)).thenAnswer((_) => mockIntValue);
        final actual = sharedPreferences.getInt(mockKey);
        expect(actual, mockIntValue);
      });
      test('returns `null`', () async {
        when(() => sharedPreferences.getInt(mockKey)).thenAnswer((_) => mockIntValue);
        final actual = sharedPreferences.getInt(mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.getInt(mockKey)).thenThrow(mockException);
        expect(() async => sharedPreferences.getInt(mockKey), throwsA(isA<StorageException>()));
      });
    });
    group('getStringList', () {
      test('returns `mockValue` succesfully', () async {
        when(() => sharedPreferences.getStringList(mockKey)).thenAnswer((_) => [mockValue]);
        final actual = sharedPreferences.getStringList(mockKey);
        expect(actual, mockValue);
      });
      test('returns `null`', () async {
        when(() => sharedPreferences.getStringList(mockKey)).thenAnswer((_) => [mockValue]);
        final actual = sharedPreferences.getStringList(mockKey);
        expect(actual, isNull);
      });

      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.getStringList(mockKey)).thenThrow(mockException);
        expect(() async => sharedPreferences.getStringList(mockKey), throwsA(isA<StorageException>()));
      });
    });
    group('setString', () {
      test('sets `mockValue` succesfully', () async {
        when(() => sharedPreferences.setString(mockKey, mockValue));
        final actual = sharedPreferences.setString(mockKey, mockValue);
        // verify(() => sharedPreferences.setString(mockKey, mockValue)).called(1);
        expect(actual, mockValue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setString(mockKey, mockValue)).thenThrow(mockException);
        expect(() async => sharedPreferences.setString(mockKey, mockValue), throwsA(isA<StorageException>()));
      });
    });
    group('setBool', () {
      test('sets `mockValue` succesfully', () async {
        await sharedPreferences.setBool(mockKey, mockValue as bool);
        final actual = sharedPreferences.setBool(mockKey, mockValue as bool); //here need to ask
        // verify(() => sharedPreferences.setBool(mockKey, mockValue)).called(1);
        expect(actual, mockValue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setBool(mockKey, mockValue as bool)).thenThrow(mockException);
        expect(() async => sharedPreferences.setBool(mockKey, mockValue as bool), throwsA(isA<StorageException>()));
      });
    });
    group('setDouble', () {
      test('sets `mockValue` succesfully', () async {
        await sharedPreferences.setDouble(mockKey, 00);
        final actual = sharedPreferences.setDouble(mockKey, 00); //here need to ask
        // verify(() => sharedPreferences.setDouble(mockKey, mockValue)).called(1);
        expect(actual, mockValue);
      });
      test('throw `StorageException` fails', () async {
        when(() => sharedPreferences.setDouble(mockKey, 00)).thenThrow(mockException);
        expect(() async => sharedPreferences.setDouble(mockKey, 00), throwsA(isA<StorageException>()));
      });
    });
  });
}
/// getString, 
/// getBool, 
/// getDouble, 
/// getInt, 
/// getStringList, 
/// setString, 
/// setBool, 
/// setDouble, 
/// setInt, 
/// setStringList, 
/// delete, 
/// clear