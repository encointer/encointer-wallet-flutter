import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test SingleBusiness page mock', () {
    final singleBusiness = SingleBusiness.fromJson(singleBusinessMockData);

    expect(singleBusiness.name, 'Hatha Lisa');
    expect(singleBusiness.description,
        'Nutze deine Leu, um deinem Körper und Geist etwas Gutes zu tun. Besuche eine Yogastunde im Kreis 4 oder Kreis 5 mit Lisa Stähli, einer Hatha-Yoga-Lehrerin mit über 4 Jahren Unterrichtserfahrung. Die Klassen sind für alle Niveaus geeignet, werden auf Englisch unterrichtet und bieten sowohl eine Herausforderung als auch die Möglichkeit, sein Gleichgewicht zu finden.\n\nErfahre mehr oder kontaktiere uns:\nhttps://hathalisa.com/');
    expect(singleBusiness.category, 'Body & Soul');
    expect(singleBusiness.addressDescription, 'Yoga Studio Zürich');
    expect(singleBusiness.address, 'Zwinglistrasse, 8');
    expect(singleBusiness.zipcode, '8004, Zürich');
    expect(singleBusiness.telephone, '+41 123 456 789');
    expect(singleBusiness.email, 'info@hathalisa.com');
    expect(singleBusiness.longitude, 8.515962660312653);
    expect(singleBusiness.latitude, 47.390349148891545);
    expect(singleBusiness.openingHours1, 'Tuesdays 07:30-08:30');
    expect(singleBusiness.openingHours2, 'Wednesday 12:15-13:20');
    expect(singleBusiness.logo, 'QmUH7W2eAWTfHRYYV1YitZaz54sTjEwv6udjZjh7Tg47Xv');
    expect(singleBusiness.photo,
        'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha_lisa_single_b.png?raw=true');
    expect(singleBusiness.offer, 'Offer for Leu');
    expect(singleBusiness.offerName1, 'Single course LEU 25');
    expect(singleBusiness.offerName2, '10-course subscription LEU 200');
    expect(singleBusiness.moreInfo, 'With Leu since 01 January 2023');
    expect(singleBusiness.status, 'Neu bei Leu');
    expect(singleBusiness.isLiked, false);
    expect(singleBusiness.isLikedPersonally, false);
    expect(singleBusiness.countLikes, 0);
  });
}
