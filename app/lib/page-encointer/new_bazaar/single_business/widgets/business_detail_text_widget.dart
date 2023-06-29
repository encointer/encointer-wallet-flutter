import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';

class BusinessOfferDetails extends StatelessWidget {
  const BusinessOfferDetails({
    required this.title,
    required this.description,
    required this.price,
    required this.openningHours,
    required this.buisnessName,
    super.key,
  });
  final String title;
  final String description;
  final String price;
  final String openningHours;
  final String buisnessName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title\n',
                style: context.textTheme.bodyLarge!.copyWith(
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: '$price\n',
                style: context.textTheme.bodyMedium!.copyWith(height: 1.4),
              ),
            ],
          ),
        ),
        Text(
          description,
          style: context.textTheme.bodyLarge!.copyWith(
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          openningHours,
          style: context.textTheme.bodyMedium!.copyWith(height: 1.4),
        ),
        Text(
          '@ $buisnessName',
          style: context.textTheme.bodyMedium!.copyWith(height: 1.4),
        ),
      ],
    );
  }
}
