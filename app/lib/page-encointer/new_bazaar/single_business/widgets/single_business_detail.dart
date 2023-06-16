import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/l10n/l10.dart';
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
    required this.singleBusiness,
    super.key,
  });

  final SingleBusiness singleBusiness;

  @override
  Widget build(BuildContext context) {
    final likeStore = context.watch<LikeIconStore>();
    final l10n = context.l10n;
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
                        l10n.like,
                        style: context.textTheme.bodySmall!
                            .copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Observer(builder: (_) {
                          return Assets.avatars.participant00.svg(
                              height: 25,
                              colorFilter:
                                  likeStore.isLiked ? null : const ColorFilter.mode(Colors.white, BlendMode.color));
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
                    text: singleBusiness.offer,
                    text1: singleBusiness.offerName1,
                    text2: singleBusiness.offerName2,
                  ),
                  BusinessDetailTextWidget(
                    text: l10n.openningHours,
                    text1: singleBusiness.openingHours1,
                    text2: singleBusiness.openingHours2,
                  ),
                  const SizedBox(height: 20),
                  BusinessDetailAddressWidget(
                    text: l10n.address,
                    description: singleBusiness.addressDescription,
                    address: singleBusiness.address,
                    zipCode: singleBusiness.zipcode,
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
                  BusinessDetailTextWidget(
                    text: l10n.moreInfo,
                    text1: singleBusiness.moreInfo,
                    text2: '',
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
