import 'package:ew_keyring/src/keyring_data.dart';
import 'package:test/test.dart';

void main() {
  group('getSeedTypeFromString', () {
    test('inferring key type works', () {
      expect(getSeedTypeFromString('0xabe03'), SeedType.privateKey);
      expect(getSeedTypeFromString('//Alice'), SeedType.raw);
      expect(
        getSeedTypeFromString('spray trust gown toast route merge awful sight ghost all degree exit'),
        SeedType.mnemonic,
      );
    });
  });
}
