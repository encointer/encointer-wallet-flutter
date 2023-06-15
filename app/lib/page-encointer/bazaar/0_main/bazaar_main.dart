import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class BazaarPage extends StatelessWidget {
  const BazaarPage({super.key});
  static const String route = '/bazaar';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.acceptancePoints,
          style: textTheme.displaySmall!.copyWith(color: context.colorScheme.secondary),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.categories,
                  style: textTheme.bodySmall,
                ),
                const SizedBox(width: 10),
                const DropdownWidget(),
              ],
            ),
          ),
        ),
      ),
      body: const BusinessesView(),
    );
  }
}

class BazaarMain extends StatelessWidget {
  const BazaarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BusinessesStore()..getBusinesses(),
      child: const BazaarPage(),
    );
  }
}
