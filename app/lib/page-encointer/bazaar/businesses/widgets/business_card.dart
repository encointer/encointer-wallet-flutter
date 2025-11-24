import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/ipfs_image.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/propose_page.dart';
import 'package:encointer_wallet/service/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/views/single_business_view.dart';
import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/store/app.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key, required this.business});

  final IpfsBusiness business;

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    final currentAddress = store.account.currentAddress;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (context) => Provider(
              create: (_) => SingleBusinessStore(business),
              child: const SingleBusinessView(),
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          // Enlarge height so button has its own space
          height: 190,
          child: Row(
            children: [
              IpfsImage(
                ipfs: webApi.ipfsApi,
                cidOrFolder: business.logo!,
                width: 130,
                height: double.infinity,
                fit: BoxFit.contain,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                loadingBuilder: (_) => const Center(child: CircularProgressIndicator()),
                errorBuilder: (_, __) => const Center(child: Icon(Icons.broken_image, size: 40)),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Top row ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(business.category.name, style: context.bodySmall)),
                          Text(
                            business.status?.name ?? '',
                            style: context.bodySmall.copyWith(
                              color: business.status?.textColor ?? Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // --- Name ---
                      Text(
                        business.name,
                        style: context.labelLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      const SizedBox(height: 8),

                      // --- Description ---
                      Text(
                        business.description,
                        style: context.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),

                      const Spacer(),

                      // --- Button row (safe, no overlap) ---
                      // if (business.controller == currentAddress)
                      if (true)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ProposePage.route);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('IssueSwapOption Proposal'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
