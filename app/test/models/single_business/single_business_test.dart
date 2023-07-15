import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/data/mock_single_business_data.dart';

void main() {
  group('SingleBusiness Model', () {
    test('fromJson() should return a SingleBusiness object', () {
      final singleBusiness = SingleBusiness.fromJson(mockSingleBusiness);
      expect(singleBusiness, isA<SingleBusiness>());
    });

    test('toJson() should return a JSON map', () {
      final singleBusiness = SingleBusiness.fromJson(mockSingleBusiness);
      expect(singleBusiness.toJson(), mockSingleBusiness);
    });
  });
}
