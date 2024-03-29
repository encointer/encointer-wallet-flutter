import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/views/single_business_view.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/theme/theme.dart';

class BusinessesCard extends StatelessWidget {
  const BusinessesCard({super.key, required this.businesses});

  final Businesses businesses;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push<Widget>(
          context,
          MaterialPageRoute(
            builder: (context) => Provider(
              create: (context) => SingleBusinessStore(businesses, context.read<AppStore>().encointer.community!.cid)
                ..getSingleBusiness(),
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
              if (businesses.logo.isNotNullOrEmpty)
                DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(businesses.logo!),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: const SizedBox(height: double.infinity, width: 130),
                )
              else
                DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(Assets.images.assets.mosaicBackground.path),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: const SizedBox(height: double.infinity, width: 130),
                ),
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(businesses.category.name, style: context.bodySmall)),
                      Text(
                        businesses.status?.name ?? '',
                        style: context.bodySmall.copyWith(color: businesses.status?.textColor ?? Colors.black),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),
                      Text(
                        businesses.name,
                        style: context.labelLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        businesses.description,
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
