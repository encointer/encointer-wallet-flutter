import 'package:flutter_test/flutter_test.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/models/bazaar/category.dart';

void main() {
  group('IpfsBusiness Category Parsing', () {
    test('maps known categories to correct enum', () {
      final b = IpfsBusiness.fromJson({
        'name': 'Known business',
        'description': 'desc',
        'category': 'food_beverage_store',
        'address': 'addr',
        'longitude': '8.5',
        'latitude': '47.3',
        'openingHours': 'always',
      });

      expect(b.category, equals(Category.foodAndBeverageStore));
      expect(b.categoryDisplayName, equals('Food & Beverage Store'));
    });

    test('falls back to Category.other for unknown categories', () {
      final b = IpfsBusiness.fromJson({
        'name': 'Unknown business',
        'description': 'desc',
        'category': 'local_produce',
        'address': 'addr',
        'longitude': '8.5',
        'latitude': '47.3',
        'openingHours': 'always',
      });

      expect(b.category, equals(Category.other));
    });

    test('prettifies unknown category slugs with underscores', () {
      final b = IpfsBusiness.fromJson({
        'name': 'Unknown business',
        'description': 'desc',
        'category': 'local_art__and_crafts',
        'address': 'addr',
        'longitude': '8.5',
        'latitude': '47.3',
        'openingHours': 'always',
      });

      expect(b.categoryDisplayName, equals('Local Art And Crafts'));
    });

    test('handles empty category gracefully', () {
      final b = IpfsBusiness.fromJson({
        'name': 'Empty business',
        'description': 'desc',
        'category': '',
        'address': 'addr',
        'longitude': '8.5',
        'latitude': '47.3',
        'openingHours': 'always',
      });

      expect(b.category, equals(Category.other));
      expect(b.categoryDisplayName, equals('Other'));
    });
  });
}
