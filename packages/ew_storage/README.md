# Ew Storage

Encointer Storage Package

`ew_storage` is a simple and easy-to-use storage client for Flutter applications. It provides a unified interface to read, write and delete data from various storage options such as [shared_preferences](https://pub.dev/packages/shared_preferences) and [flutter_secure_storage.](https://pub.dev/packages/flutter_secure_storage)

## PreferencesStorage
```dart
// Create a `PreferencesStorage` instance.
final storage = await PreferencesStorage.getInstance();

// Write a key/value pair.
await storage.writeString(key: 'my_key', value: 'my_value');

// Read value for key.
final value = storage.readString(key: 'my_key'); // 'my_value'
```

## SecureStorage
```dart
// Create a `SecureStorage` instance.
final storage = const SecureStorage();

// Write a key/value pair.
await storage.write(key: 'my_key', value: 'my_value');

// Read value for key.
final value = await storage.read(key: 'my_key'); // 'my_value'
```