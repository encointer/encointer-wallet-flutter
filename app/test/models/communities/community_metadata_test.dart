import 'package:encointer_wallet/models/communities/community_metadata.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test `CommunityMetadata` deserialization', () {
    test('Corsica LoCoFlex with signer', () {
      final corsicaLocoFlexMetadata = {
        'name': 'Corsica LoCoFlex',
        'symbol': 'CLL',
        'assets': 'QmP2fzfikh7VqTu8pvzd2G2vAd4eK7EaazXTEgqGN6AWoD',
        'theme': null,
        'url': null,
        'announcementSigner': {'Bip340': '0xceda72c19f11aebecf8fb4a0ab3fb2a03e03f283225655baab4728303a560a13'},
        'rules': 'LoCoFlex'
      };

      final meta = CommunityMetadata.fromJson(corsicaLocoFlexMetadata);

      expect(meta.name, 'Corsica LoCoFlex');
      expect(meta.symbol, 'CLL');
      expect(meta.assets, 'QmP2fzfikh7VqTu8pvzd2G2vAd4eK7EaazXTEgqGN6AWoD');
      expect(meta.theme, null);
      expect(meta.url, null);
      expect(meta.announcementSigner!['Bip340'], '0xceda72c19f11aebecf8fb4a0ab3fb2a03e03f283225655baab4728303a560a13');
      expect(meta.rules, CommunityRules.LoCoFlex);
    });

    test('Corsica LoCoFlex without signer', () {
      final corsicaLocoFlexMetadata = {
        'name': 'Corsica LoCoFlex',
        'symbol': 'CLL',
        'assets': 'QmP2fzfikh7VqTu8pvzd2G2vAd4eK7EaazXTEgqGN6AWoD',
        'theme': null,
        'url': null,
        'announcementSigner': null,
        'rules': 'LoCoFlex'
      };

      final meta = CommunityMetadata.fromJson(corsicaLocoFlexMetadata);

      expect(meta.name, 'Corsica LoCoFlex');
      expect(meta.symbol, 'CLL');
      expect(meta.assets, 'QmP2fzfikh7VqTu8pvzd2G2vAd4eK7EaazXTEgqGN6AWoD');
      expect(meta.theme, null);
      expect(meta.url, null);
      expect(meta.announcementSigner, null);
      expect(meta.rules, CommunityRules.LoCoFlex);
    });
  });
}
