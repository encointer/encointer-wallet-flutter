import 'package:encointer_wallet/page-encointer/bazaar/business_form/business_form_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidName', () {
    test('null returns false', () {
      expect(BusinessFormValidators.isValidName(null), isFalse);
    });

    test('empty string returns false', () {
      expect(BusinessFormValidators.isValidName(''), isFalse);
    });

    test('whitespace only returns false', () {
      expect(BusinessFormValidators.isValidName('   '), isFalse);
    });

    test('single non-whitespace char returns false', () {
      expect(BusinessFormValidators.isValidName('a'), isFalse);
      expect(BusinessFormValidators.isValidName(' a '), isFalse);
    });

    test('two non-whitespace chars returns true', () {
      expect(BusinessFormValidators.isValidName('ab'), isTrue);
      expect(BusinessFormValidators.isValidName(' a b '), isTrue);
    });

    test('normal name returns true', () {
      expect(BusinessFormValidators.isValidName('My Shop'), isTrue);
    });
  });

  group('isValidTelephone', () {
    test('digits only is valid', () {
      expect(BusinessFormValidators.isValidTelephone('123456'), isTrue);
    });

    test('leading plus is valid', () {
      expect(BusinessFormValidators.isValidTelephone('+41791234567'), isTrue);
    });

    test('formatted number with spaces/dashes/parens is valid', () {
      expect(BusinessFormValidators.isValidTelephone('+1 (555) 123-4567'), isTrue);
    });

    test('too short returns false', () {
      expect(BusinessFormValidators.isValidTelephone('12345'), isFalse);
    });

    test('letters return false', () {
      expect(BusinessFormValidators.isValidTelephone('abc'), isFalse);
      expect(BusinessFormValidators.isValidTelephone('123abc'), isFalse);
    });

    test('empty returns false', () {
      expect(BusinessFormValidators.isValidTelephone(''), isFalse);
    });
  });

  group('isValidEmail', () {
    test('basic email is valid', () {
      expect(BusinessFormValidators.isValidEmail('user@example.com'), isTrue);
    });

    test('subdomain email is valid', () {
      expect(BusinessFormValidators.isValidEmail('user@sub.example.com'), isTrue);
    });

    test('minimal email is valid', () {
      expect(BusinessFormValidators.isValidEmail('a@b.c'), isTrue);
    });

    test('missing @ returns false', () {
      expect(BusinessFormValidators.isValidEmail('userexample.com'), isFalse);
    });

    test('missing domain dot returns false', () {
      expect(BusinessFormValidators.isValidEmail('user@example'), isFalse);
    });

    test('empty local part returns false', () {
      expect(BusinessFormValidators.isValidEmail('@example.com'), isFalse);
    });

    test('space in address returns false', () {
      expect(BusinessFormValidators.isValidEmail('us er@example.com'), isFalse);
    });

    test('empty returns false', () {
      expect(BusinessFormValidators.isValidEmail(''), isFalse);
    });
  });

  group('isValidUrl', () {
    test('https URL is valid', () {
      expect(BusinessFormValidators.isValidUrl('https://example.com'), isTrue);
    });

    test('http URL is valid', () {
      expect(BusinessFormValidators.isValidUrl('http://example.com'), isTrue);
    });

    test('URL with path and query is valid', () {
      expect(BusinessFormValidators.isValidUrl('https://example.com/path?q=1'), isTrue);
    });

    test('ftp scheme returns false', () {
      expect(BusinessFormValidators.isValidUrl('ftp://example.com'), isFalse);
    });

    test('no scheme returns false', () {
      expect(BusinessFormValidators.isValidUrl('example.com'), isFalse);
    });

    test('scheme only returns false', () {
      expect(BusinessFormValidators.isValidUrl('https://'), isFalse);
    });

    test('not a URL returns false', () {
      expect(BusinessFormValidators.isValidUrl('not a url'), isFalse);
    });

    test('empty returns false', () {
      expect(BusinessFormValidators.isValidUrl(''), isFalse);
    });
  });
}
