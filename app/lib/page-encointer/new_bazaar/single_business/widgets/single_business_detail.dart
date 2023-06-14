import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/business_detail_text_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/like_icon_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/business_detail_address_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/map_button.dart';
// import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/theme/theme.dart';

class SingleBusinessDetail extends StatelessWidget {
  const SingleBusinessDetail({
    super.key,
  });

  // final SingleBusiness singleBusiness;

  @override
  Widget build(BuildContext context) {
    final likeStore = context.watch<LikeIconStore>();
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            Image.network(
              'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha_lisa_single_b.png?raw=true',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 60),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // singleBusiness.category,
                        'Body & Soul',
                        style: context.textTheme.bodySmall,
                      ),
                      Text(
                        'Nei bei Leu',
                        style: context.textTheme.bodySmall!.copyWith(color: const Color(0xFF35B731)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Observer(builder: (_) {
                          return likeStore.isLikedPersonally
                              ? Assets.avatars.participant00.svg(
                                  height: 19,
                                )
                              : Assets.avatars.participant00
                                  .svg(height: 19, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.color));
                        }),
                        onPressed: context.read<LikeIconStore>().toggleOwnLikes,
                      ),
                      Text(
                        'Gefällt mir',
                        style: context.textTheme.bodySmall!
                            .copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Observer(builder: (_) {
                          return likeStore.isLiked
                              ? Assets.avatars.participant00.svg(
                                  height: 25,
                                )
                              : Assets.avatars.participant00
                                  .svg(height: 25, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.color));
                        }),
                        onPressed: context.read<LikeIconStore>().toggleLikes,
                      ),
                      Observer(builder: (_) {
                        return Text('${likeStore.countLikes}');
                      }),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    // singleBusiness.description,
                    'Nutze deine Leu, um deinem Körper und Geist etwas Gutes zu tun. Besuche eine Yogastunde im Kreis 4 oder Kreis 5 mit Lisa Stähli, einer Hatha-Yoga-Lehrerin mit über 4 Jahren Unterrichtserfahrung. Die Klassen sind für alle Niveaus geeignet, werden auf Englisch unterrichtet und bieten sowohl eine Herausforderung als auch die Möglichkeit, sein Gleichgewicht zu finden.\n\nErfahre mehr oder kontaktiere uns:\nhttps://hathalisa.com/',
                    style: context.textTheme.bodyMedium!.copyWith(height: 1.5, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  const BusinessDetailTextWidget(
                    text: 'Opening Hours\n',
                    text1: 'Mon-Fri 8h-18h',
                    //  singleBusiness.openingHours,
                  ),
                  const SizedBox(height: 20),
                  const BusinessDetailAddressWidget(
                    text: 'Address\n',
                    description: 'Yoga Studio Zürich\n',
                    address: 'Zwinglistrasse, 8 8004\n',
                    // singleBusiness.address,
                    email: 'info@hathalisa.com\n',
                    // singleBusiness.email,
                    phoneNum: '+41 123 456 789',
                    // singleBusiness.telephone,
                  ),
                  const SizedBox(height: 20),
                  MapButton(
                    onPressed: () {},
                  ),
                  const SizedBox(height: 40),
                  const BusinessDetailTextWidget(
                    text: 'More Info:\n',
                    text1: 'Bei Leu seit 01. Januar 2023',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
