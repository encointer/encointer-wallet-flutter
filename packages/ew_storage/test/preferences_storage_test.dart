import 'package:ew_storage/ew_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const key = 'key';

  group('PreferencesStorage', () {
    test('setString - getString', () async {
      const setValue = 'set-value';
      SharedPreferences.setMockInitialValues(<String, Object>{key: setValue});
      final storage = await PreferencesStorage.getInstance();
      final success = await storage.setString(key: key, value: setValue);
      final getValue = storage.getString(key);
      expect(success, isTrue);
      expect(getValue, setValue);
    });

    test('setBool - getBool', () async {
      const setValue = true;
      SharedPreferences.setMockInitialValues(<String, Object>{key: setValue});
      final storage = await PreferencesStorage.getInstance();
      final success = await storage.setBool(key: key, value: setValue);
      final getValue = storage.getBool(key);
      expect(success, isTrue);
      expect(getValue, setValue);
    });

    test('setDouble - getDouble', () async {
      const setValue = 1.7;
      SharedPreferences.setMockInitialValues(<String, Object>{key: setValue});
      final storage = await PreferencesStorage.getInstance();
      final success = await storage.setDouble(key: key, value: setValue);
      final getValue = storage.getDouble(key);
      expect(success, isTrue);
      expect(getValue, setValue);
    });

    test('setInt - getInt', () async {
      const setValue = 1;
      SharedPreferences.setMockInitialValues(<String, Object>{key: setValue});
      final storage = await PreferencesStorage.getInstance();
      final success = await storage.setInt(key: key, value: setValue);
      final getValue = storage.getInt(key);
      expect(success, isTrue);
      expect(getValue, setValue);
    });

    test('setStringList - getStringList', () async {
      const setValue = ['A', 'B', 'C'];
      SharedPreferences.setMockInitialValues(<String, Object>{key: setValue});
      final storage = await PreferencesStorage.getInstance();
      final success = await storage.setStringList(key: key, value: setValue);
      final getValue = storage.getStringList(key);
      expect(success, isTrue);
      expect(getValue, setValue);
    });

    test('Delete', () async {
      const setValue = 1;
      SharedPreferences.setMockInitialValues(<String, Object>{key: setValue});
      final storage = await PreferencesStorage.getInstance();
      await storage.setInt(key: key, value: setValue);
      final getValue = storage.getInt(key);
      expect(getValue, setValue);
      final success = await storage.delete(key);
      expect(success, isTrue);
      final getNullValue = storage.getInt(key);
      expect(getNullValue, isNull);
    });

    test('Clear', () async {
      const boolKey = 'bool-key';
      const stringKey = 'string-key';
      const setStringValue = 'string-value';
      const setBoolValue = true;
      SharedPreferences.setMockInitialValues(<String, Object>{
        stringKey: setStringValue,
        boolKey: setBoolValue,
      });
      final storage = await PreferencesStorage.getInstance();
      final getStringValue = storage.getString(stringKey);
      final getBoolValue = storage.getBool(boolKey);
      expect(getStringValue, setStringValue);
      expect(getBoolValue, setBoolValue);
      final success = await storage.clear();
      expect(success, isTrue);
      final getStringNullValue = storage.getString(stringKey);
      final getBoolNullValue = storage.getBool(boolKey);
      expect(getStringNullValue, isNull);
      expect(getBoolNullValue, isNull);
    });
  });
}
