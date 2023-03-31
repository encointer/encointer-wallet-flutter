import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class ImportAccountLink extends StatelessWidget {
  const ImportAccountLink({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${dic.profile.doYouAlreadyHaveAnAccount} ',
          style: TextStyle(color: zurichLion.shade50),
        ),
        InkWell(
          key: const Key('import-account'),
          onTap: onTap,
          child: Text(
            dic.profile.import,
            style: TextStyle(color: zurichLion.shade50, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
