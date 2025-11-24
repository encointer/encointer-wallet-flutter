import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/ipfs_image.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/helpers.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/propose_page.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/views/single_business_view.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/theme/theme.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key, required this.business});

  final IpfsBusiness business;

  @override
  Widget build(BuildContext context) {
    // final store = context.read<AppStore>();
    // final currentAddress = store.account.currentAddress;
    const currentAddress = '5C6xA6UDoGYnYM5o4wAfWMUHLL2dZLEDwAAFep11kcU9oiQK';

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => Provider(
              create: (_) => SingleBusinessStore(business),
              child: const SingleBusinessView(),
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // --- Left image ---
            IpfsImage(
              ipfs: webApi.ipfsApi,
              cidOrFolder: business.logo!,
              width: 110,
              height: 120,
              fit: BoxFit.contain,
              loadingBuilder: (_) =>
              const SizedBox(height: 120, child: Center(child: CircularProgressIndicator())),
              errorBuilder: (_, __) =>
              const SizedBox(height: 120, child: Center(child: Icon(Icons.broken_image, size: 40))),
            ),

            // --- Right side ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Category + Status
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            business.category.name,
                            style: context.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          business.status?.name ?? '',
                          style: context.bodySmall.copyWith(
                            color: business.status?.textColor ?? Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Name
                    Text(
                      business.name,
                      style: context.labelLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Description
                    Text(
                      business.description,
                      style: context.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Button (compact)
                    if (AddressUtils.areEqual(business.controller!, currentAddress))
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ProposePage.route, arguments: ProposalActionIdentifier.issueSwapAssetOption,);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.add, size: 16),
                            label: Text(context.l10n.swapOption),
                          )
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
