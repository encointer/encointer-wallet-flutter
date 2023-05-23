import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class BazaarMain extends StatelessWidget {
  const BazaarMain({super.key});
  static const String route = '/bazaar';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          dic.bazaar.acceptancePoints,
          style: textTheme.displaySmall!.copyWith(color: zurichLion.shade600),
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
                  dic.bazaar.categories,
                  style: textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 10,
                ),
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

class BazaarPage extends StatelessWidget {
  const BazaarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BusinessesStore()..getBusinesses(),
      child: const BazaarMain(),
    );
  }
}
