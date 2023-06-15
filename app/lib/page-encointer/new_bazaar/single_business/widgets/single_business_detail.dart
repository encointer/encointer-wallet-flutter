import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/business_detail_text_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/like_icon_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/business_detail_address_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/map_button.dart';
import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

class SingleBusinessDetail extends StatelessWidget {
  const SingleBusinessDetail({
    super.key,
    required this.singleBusiness,
  });

  final SingleBusiness singleBusiness;

  @override
  Widget build(BuildContext context) {
    final likeStore = context.watch<LikeIconStore>();

    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            Image.network(singleBusiness.photo, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 60),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        singleBusiness.category,
                        style: context.textTheme.bodySmall,
                      ),
                      Text(
                        singleBusiness.status!,
                        style: context.textTheme.bodySmall!.copyWith(color: const Color(0xFF35B731)),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Observer(builder: (_) {
                          return Assets.avatars.participant00.svg(
                              height: 19,
                              colorFilter: likeStore.isLikedPersonally
                                  ? null
                                  : const ColorFilter.mode(Colors.white, BlendMode.color));
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
                    singleBusiness.description,
                    style: context.textTheme.bodyMedium!.copyWith(height: 1.5, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  BusinessDetailTextWidget(
                    text: 'Opening Hours\n',
                    text1: singleBusiness.openingHours,
                  ),
                  const SizedBox(height: 20),
                  BusinessDetailAddressWidget(
                    text: 'Address\n',
                    description: 'Yoga Studio Zürich\n',
                    address: singleBusiness.address,
                    email: singleBusiness.email,
                    phoneNum: singleBusiness.telephone,
                  ),
                  const SizedBox(height: 20),
                  MapButton(
                    onPressed: () {
                      final location = Location(
                        singleBusiness.latitude.toString(),
                        singleBusiness.longitude.toString(),
                      );
                      AppLaunch.launchMap(location);
                    },
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
