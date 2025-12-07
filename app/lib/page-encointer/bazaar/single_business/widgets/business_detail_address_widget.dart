import 'package:encointer_wallet/utils/extensions/string/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final String? description;
  final String? address;
  final String? zipCode;
  final String? email;
  final String? phoneNum;

  bool _isValidEmail(String e) =>
      RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(e);

  bool _isValidPhone(String p) =>
      RegExp(r'^[0-9+\-\s()]{6,}$').hasMatch(p);

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[
      TextSpan(
        text: '$text\n',
        style: context.textTheme.titleLarge!
            .copyWith(color: context.colorScheme.primary, fontSize: 18),
      ),
    ];

    if (description.isNotNullOrEmpty) {
      spans.add(
        TextSpan(
          text: '$description\n',
          style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      );
    }

    if (address.isNotNullOrEmpty) {
      spans.add(
        TextSpan(
          text: '$address\n',
          style: context.textTheme.bodyMedium!.copyWith(height: 1.3),
        ),
      );
    }

    if (zipCode.isNotNullOrEmpty) {
      spans.add(
        TextSpan(
          text: '$zipCode\n',
          style: context.textTheme.bodyMedium!.copyWith(height: 1.3),
        ),
      );
    }

    // EMAIL
    if (email.isNotNullOrEmpty) {
      final e = email!;
      final isValid = _isValidEmail(e);

      spans.add(
        TextSpan(
          text: '$e\n',
          style: context.textTheme.bodyMedium!.copyWith(
            height: 1.8,
            color: isValid ? context.colorScheme.primary : null,
            decoration: isValid ? TextDecoration.underline : null,
          ),
          recognizer: isValid
              ? (TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri(scheme: 'mailto', path: e);
              await launchUrl(uri);
            })
              : null,
        ),
      );
    }

    // PHONE NUMBER
    if (phoneNum.isNotNullOrEmpty) {
      final p = phoneNum!;
      final isValid = _isValidPhone(p);

      spans.add(
        TextSpan(
          text: p,
          style: context.textTheme.bodyMedium!.copyWith(
            height: 1.5,
            color: isValid ? context.colorScheme.primary : null,
            decoration: isValid ? TextDecoration.underline : null,
          ),
          recognizer: isValid
              ? (TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri(scheme: 'tel', path: p);
              await launchUrl(uri);
            })
              : null,
        ),
      );
    }

    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(children: spans),
      ),
    );
  }
}
