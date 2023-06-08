import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';

class BusinessDetailAddressWidget extends StatelessWidget {
  const BusinessDetailAddressWidget({
    super.key,
    required this.text,
    required this.description,
    required this.address,
    required this.email,
    required this.phoneNum,
  });
  final String text;
  final String description;
  final String address;
  final String email;
  final String phoneNum;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.primary, fontSize: 18),
            ),
            TextSpan(
              text: description,
              style: context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.8,
              ),
            ),
            TextSpan(
              text: address,
              style: context.textTheme.bodyMedium!.copyWith(height: 1.3),
            ),
            TextSpan(
              text: email,
              style: context.textTheme.bodyMedium!.copyWith(height: 1.3),
            ),
            TextSpan(
              text: phoneNum,
              style: context.textTheme.bodyMedium!.copyWith(height: 1.3),
            ),
          ],
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
