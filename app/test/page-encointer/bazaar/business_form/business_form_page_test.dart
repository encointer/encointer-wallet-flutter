import 'dart:convert';

import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/page-encointer/bazaar/business_form/business_form_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BusinessFormParams', () {
    test('isEdit is false when existingBusiness is null', () {
      const params = BusinessFormParams();
      expect(params.isEdit, isFalse);
      expect(params.existingBusiness, isNull);
      expect(params.businessController, isNull);
    });

    test('isEdit is true when existingBusiness is provided', () {
      final business = _testBusiness();
      final params = BusinessFormParams(existingBusiness: business, businessController: '5GrwvaEF...');
      expect(params.isEdit, isTrue);
      expect(params.existingBusiness, isNotNull);
      expect(params.businessController, '5GrwvaEF...');
    });
  });

  group('IpfsBusiness JSON round-trip', () {
    test('toJson and fromJson are symmetric', () {
      final business = _testBusiness();
      final json = business.toJson();
      final restored = IpfsBusiness.fromJson(json);

      expect(restored.name, business.name);
      expect(restored.categoryRaw, business.categoryRaw);
      expect(restored.description, business.description);
      expect(restored.address, business.address);
      expect(restored.zipcode, business.zipcode);
      expect(restored.telephone, business.telephone);
      expect(restored.email, business.email);
      expect(restored.openingHours, business.openingHours);
      expect(restored.moreInfo, business.moreInfo);
      expect(restored.longitude, business.longitude);
      expect(restored.latitude, business.latitude);
      expect(restored.logo, business.logo);
      expect(restored.photos, business.photos);
    });

    test('toJson encodes to valid JSON string', () {
      final business = _testBusiness();
      final jsonString = jsonEncode(business.toJson());
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(decoded['name'], 'Test Bakery');
      expect(decoded['category'], 'food');
    });

    test('category maps correctly from categoryRaw', () {
      final business = _testBusiness();
      expect(business.category, Category.food);
    });

    test('unknown category maps to other', () {
      final business = IpfsBusiness(
        name: 'Test',
        categoryRaw: 'unknown_category_xyz',
        description: null,
        address: null,
        longitude: null,
        latitude: null,
        openingHours: null,
      );
      expect(business.category, Category.other);
    });

    test('all nullable fields can be null', () {
      final business = IpfsBusiness(
        name: 'Minimal',
        categoryRaw: 'other',
        description: null,
        address: null,
        longitude: null,
        latitude: null,
        openingHours: null,
      );
      final json = business.toJson();
      final restored = IpfsBusiness.fromJson(json);
      expect(restored.name, 'Minimal');
      expect(restored.description, isNull);
      expect(restored.address, isNull);
      expect(restored.logo, isNull);
      expect(restored.photos, isNull);
    });
  });

  group('Category enum', () {
    test('fromJsonKey returns correct category for known keys', () {
      expect(Category.fromJsonKey('food'), Category.food);
      expect(Category.fromJsonKey('art_music'), Category.artAndMusic);
      expect(Category.fromJsonKey('body_soul'), Category.bodyAndSoul);
      expect(Category.fromJsonKey('restaurants_bars'), Category.restaurantsAndBars);
    });

    test('fromJsonKey returns other for unknown keys', () {
      expect(Category.fromJsonKey('nonexistent'), Category.other);
      expect(Category.fromJsonKey(''), Category.other);
    });

    test('all categories except all have valid jsonKey', () {
      for (final cat in Category.values) {
        if (cat == Category.all) continue;
        expect(cat.jsonKey, isNotEmpty);
        expect(Category.fromJsonKey(cat.jsonKey), cat);
      }
    });
  });
}

IpfsBusiness _testBusiness() {
  return IpfsBusiness(
    name: 'Test Bakery',
    categoryRaw: 'food',
    description: 'A cozy local bakery',
    address: '123 Main Street',
    zipcode: '12345',
    addressDescription: 'Corner of Main and Oak',
    telephone: '+1234567890',
    email: 'bakery@test.com',
    openingHours: 'Mon-Fri 7:00-18:00',
    moreInfo: 'Fresh bread daily',
    longitude: '8.5417',
    latitude: '47.3769',
    logo: 'QmLogoHash123',
    photos: 'QmPhotosHash456',
  );
}
