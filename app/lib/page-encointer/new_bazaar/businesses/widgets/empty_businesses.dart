import 'package:flutter/material.dart';

import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/theme/theme.dart';

class EmptyBusiness extends StatelessWidget {
  const EmptyBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.noItems,
        style: context.displayMedium,
      ),
    );
  }
}
