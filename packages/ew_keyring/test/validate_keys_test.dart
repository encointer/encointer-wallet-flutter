import 'package:ew_keyring/src/validate_keys.dart';
import 'package:test/test.dart';

void main() {
  group('PrivateKey', () {
    test('isPrivateKey works', () {
      expect(ValidateKeys.isPrivateKey(''), false);
      expect(ValidateKeys.isPrivateKey('0x'), true);
      expect(ValidateKeys.isPrivateKey('0xabe03'), true);
      expect(ValidateKeys.isPrivateKey('0'), true);
    });

    test('validatePrivateKey works', () {
      expect(ValidateKeys.validatePrivateKey(''), false);
      expect(ValidateKeys.validatePrivateKey('0x'), false);
      expect(ValidateKeys.validatePrivateKey('0xabe03'), false);

      // dart side only verifies length
      expect(
        ValidateKeys.validatePrivateKey('0x1111111122222222333333334444444411111111222222223333333344444444'),
        true,
      );
    });
  });

  group('RawSeed', () {
    test('isRawSeed works', () {
      // Plain "/", "//" will be recognized as raw seed, but it will fail in the validation.
      expect(ValidateKeys.isRawSeed('/'), true);
      expect(ValidateKeys.isRawSeed('//'), true);
      expect(ValidateKeys.isRawSeed('//sadfas'), true);
      expect(ValidateKeys.isRawSeed('///'), true);
      expect(ValidateKeys.isRawSeed('asd'), false);
      expect(ValidateKeys.isRawSeed(''), false);
    });

    test('validateRawSeed works', () {
      expect(ValidateKeys.validateRawSeed(''), false);
      expect(ValidateKeys.validateRawSeed('/'), false);
      expect(ValidateKeys.validateRawSeed('//'), false);
      expect(ValidateKeys.validateRawSeed('//a'), true);
      expect(ValidateKeys.validateRawSeed('///'), true);
      // longer than 32 bytes
      expect(ValidateKeys.validateRawSeed('//11111111222222223333333344444444'), false);
    });
  });

  group('Mnemonic', () {
    test('validateMnemonic works', () {
      // length ok, but not part of the bip39 dic.
      expect(ValidateKeys.validateMnemonic('a a a a a a a a a a a a'), false);

      // valid bip39, but illegal length.
      expect(
        ValidateKeys.validateMnemonic('spray trust gown toast route merge awful sight ghost all degree'),
        false,
      );

      expect(
        ValidateKeys.validateMnemonic('spray trust gown toast route merge awful sight ghost all degree exit'),
        true,
      );
    });
  });

  group('getSeedTypeFromString', () {
    test('inferring key type works', () {
      expect(getSeedTypeFromString('0xabe03'), SeedType.privateKey);
      expect(getSeedTypeFromString('//Alice'), SeedType.rawSeed);
      expect(
        getSeedTypeFromString('spray trust gown toast route merge awful sight ghost all degree exit'),
        SeedType.mnemonic,
      );
    });
  });
}
