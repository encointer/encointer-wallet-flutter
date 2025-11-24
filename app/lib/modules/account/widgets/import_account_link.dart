import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:ew_l10n/l10n.dart';

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
          style: TextStyle(color: context.colorScheme.surface),
        ),
        InkWell(
          key: const Key(EWTestKeys.importAccount),
          onTap: onTap,
          child: Text(
            context.l10n.import,
            style: TextStyle(
              color: context.colorScheme.surface,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
