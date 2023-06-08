import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ImportAccountLink extends StatelessWidget {
  const ImportAccountLink({super.key, this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${context.l10n.doYouAlreadyHaveAnAccount} ',
          style: TextStyle(color: context.colorScheme.background),
        ),
        InkWell(
          key: const Key('import-account'),
          onTap: onTap,
          child: Text(
            context.l10n.import,
            style: TextStyle(
              color: context.colorScheme.background,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
