import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/bazaar/businesses.dart';

class BusinessesCard extends StatelessWidget {
  const BusinessesCard({
    super.key,
    required this.businesses,
  });

  final Businesses businesses;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        color: businesses.status != null ? businesses.statusColor : const Color(0xFFf4f7f8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: Image.network(
                  businesses.photo,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(businesses.category.name, style: textTheme.bodySmall),
                          Text(
                            businesses.status?.name ?? '',
                            style: textTheme.bodySmall!.copyWith(color: businesses.status?.textColor ?? Colors.black),
                          )
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(businesses.name, style: textTheme.labelLarge),
                        ),
                        Text(businesses.description, style: textTheme.bodyMedium),
                      ],
                    ),
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
