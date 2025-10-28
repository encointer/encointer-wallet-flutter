import 'package:encointer_wallet/page-encointer/bazaar/businesses/view/ipfs_image.dart';
import 'package:encointer_wallet/service/service.dart';
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
    return InkWell(
      onTap: () {
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
            builder: (context) => Provider(
              create: (context) => SingleBusinessStore(business),
              child: const SingleBusinessView(),
            ),
          ),
        );
      },
      child: SizedBox(
        height: 160,
        child: Card(
          margin: const EdgeInsets.only(top: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                errorBuilder: (_, error) => const Center(child: Icon(Icons.broken_image, size: 40)),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(business.category.name, style: context.bodySmall)),
                      Text(
                        business.status?.name ?? '',
                        style: context.bodySmall.copyWith(color: business.status?.textColor ?? Colors.black),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      Text(
                        business.name,
                        style: context.labelLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        business.description,
                        style: context.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 18),
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
