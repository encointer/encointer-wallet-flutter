import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/business_utils.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/business_detail_text_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/business_detail_address_widget.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/map_button.dart';
import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

class SingleBusinessDetail extends StatelessWidget {
  const SingleBusinessDetail({
    required this.singleBusiness,
    required this.appStore,
    super.key,
  });

  final SingleBusiness singleBusiness;
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SingleBusinessStore>();
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            Image.network(singleBusiness.logo, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        singleBusiness.category,
                        style: context.bodySmall,
                      ),
                      if (singleBusiness.status.isNotNullOrEmpty)
                        Text(
                          singleBusiness.status!,
                          style: context.bodySmall.copyWith(color: const Color(0xFF35B731)),
                        )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Observer(builder: (_) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: context.read<SingleBusinessStore>().toggleOwnLikes,
                              child: Assets.avatars.participant00.svg(
                                  height: 19,
                                  colorFilter: store.isLikedPersonally
                                      ? null
                                      : const ColorFilter.mode(Colors.white, BlendMode.color)),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              l10n.like,
                              style: context.bodySmall
                                  .copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: context.read<SingleBusinessStore>().toggleLikes,
                              child: Assets.avatars.participant00.svg(
                                  height: 25,
                                  colorFilter:
                                      store.isLiked ? null : const ColorFilter.mode(Colors.white, BlendMode.color)),
                            ),
                            const SizedBox(width: 10),
                            Text('${store.countLikes}'),
                          ],
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    BusinessUtils.utf8convert(singleBusiness.description),
                    style: context.bodyMedium.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  if (store.ipfsProducts.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.offersForCommunity(appStore.encointer.community?.symbol ?? 'LEU'),
                          style:
                              context.titleLarge.copyWith(color: context.colorScheme.primary, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: store.ipfsProducts.length,
                          itemBuilder: (context, index) {
                            final ipfsProduct = store.ipfsProducts[index];
                            return BusinessOfferDetails(
                              title: BusinessUtils.utf8convert(ipfsProduct.name),
                              description: BusinessUtils.utf8convert(ipfsProduct.description),
                              price: '${appStore.encointer.community?.symbol} ${ipfsProduct.price ?? 0}',
                              openingHours: store.singleBusiness!.openingHours,
                              businessName: store.singleBusiness!.name,
                            );
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  BusinessDetailAddressWidget(
                    text: l10n.address,
                    description: BusinessUtils.utf8convert(singleBusiness.addressDescription),
                    address: BusinessUtils.utf8convert(singleBusiness.address),
                    zipCode: singleBusiness.zipcode,
                    email: singleBusiness.email,
                    phoneNum: singleBusiness.telephone,
                  ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
