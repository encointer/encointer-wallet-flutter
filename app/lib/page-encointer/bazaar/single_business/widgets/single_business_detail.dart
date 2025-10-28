import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/ipfs_gallery.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/ipfs_image.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/widgets/business_detail_text_widget.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/widgets/business_detail_address_widget.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/widgets/map_button.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/location/location.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

class SingleBusinessDetail extends StatelessWidget {
  const SingleBusinessDetail({required this.business, super.key});

  final IpfsBusiness business;

  @override
  Widget build(BuildContext context) {
    final businessStore = context.watch<SingleBusinessStore>();
    final appStore = context.watch<AppStore>();
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            IpfsImage(
              ipfs: webApi.ipfsApi,
              cidOrFolder: business.logo!,
              width: double.infinity,
              height: 80,
              fit: BoxFit.contain,
              loadingBuilder: (_) => const Center(child: CircularProgressIndicator()),
              errorBuilder: (_, error) => const Center(child: Icon(Icons.broken_image, size: 40)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        business.category.toString(),
                        style: context.bodySmall,
                      ),
                      // if (business.status?.isNotNullOrEmpty)
                      //   Text(
                      //     business.status!,
                      //     style: context.bodySmall.copyWith(color: const Color(0xFF35B731)),
                      //   )
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
                                child: businessStore.isLikedPersonally
                                    ? Assets.images.assets.lionIconColored.image()
                                    : Assets.images.assets.lionIconUncolored.image()),
                            const SizedBox(width: 10),
                            Text(
                              l10n.like,
                              style: context.bodySmall
                                  .copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    business.description,
                    style: context.bodyMedium.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 40),
                  if (businessStore.ipfsProducts.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.offersForCommunity(appStore.encointer.community?.symbol ?? 'LEU'),
                          style: context.titleLarge.copyWith(color: context.colorScheme.primary, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: businessStore.ipfsProducts.length,
                          itemBuilder: (context, index) {
                            final ipfsProduct = businessStore.ipfsProducts[index];
                            return BusinessOfferDetails(
                              title: ipfsProduct.name,
                              description: ipfsProduct.description,
                              price: '${appStore.encointer.community?.symbol} ${ipfsProduct.price ?? 0}',
                              openingHours: businessStore.business.openingHours,
                              businessName: businessStore.business.name,
                            );
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  BusinessDetailAddressWidget(
                    text: l10n.address,
                    description: business.addressDescription ?? '',
                    address: business.address,
                    zipCode: business.zipcode ?? '',
                    email: business.email ?? '',
                    phoneNum: business.telephone ?? '',
                  ),
                  MapButton(
                    onPressed: () {
                      final location = Location(
                        double.parse(business.latitude),
                        double.parse(business.longitude),
                      );
                      AppLaunch.launchMap(location);
                    },
                  ),
                  const SizedBox(height: 40),
                  if (business.photos != null)
                    IpfsImageGallery(
                    ipfs: webApi.ipfsApi,
                    cidsOrFolders: [business.photos!]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
