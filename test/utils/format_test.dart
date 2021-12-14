import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Fmt', () {
    test('formats cid properly', () {
      var cid = CommunityIdentifier([103, 98, 115, 117, 118], [255, 255, 255, 255]);

      expect('gbsuv7YXq9G', Fmt.communityIdentifier(cid));
    });
  });
}
