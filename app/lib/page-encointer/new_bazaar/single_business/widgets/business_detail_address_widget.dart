import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';

class BusinessDetailAddressWidget extends StatelessWidget {
  const BusinessDetailAddressWidget({
    required this.text,
    required this.description,
    required this.address,
    required this.zipCode,
    required this.email,
    required this.phoneNum,
    super.key,
  });
  final String text;
  final String description;
  final String address;
  final String zipCode;
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
              text: '$text\n',
              style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.primary, fontSize: 18),
            ),
            TextSpan(
              text: '$description\n',
              style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: '$address\n', style: context.textTheme.bodyMedium!.copyWith(height: 1.3)),
            TextSpan(text: '$zipCode\n', style: context.textTheme.bodyMedium!.copyWith(height: 1.3)),
            TextSpan(text: '$email\n', style: context.textTheme.bodyMedium!.copyWith(height: 1.3)),
            TextSpan(text: phoneNum, style: context.textTheme.bodyMedium!.copyWith(height: 1.5)),
          ],
        ),
      ),
    );
  }
}
