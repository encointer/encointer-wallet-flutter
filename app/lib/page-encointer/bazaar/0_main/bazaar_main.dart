import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/theme/custom/typography/typography_theme.dart';

class BazaarMainArgs {
  BazaarMainArgs({
    required this.cid,
    required this.appStore,
  });
  final CommunityIdentifier cid;
  final AppStore appStore;
}

class BazaarMain extends StatelessWidget {
  const BazaarMain({
    required this.args,
    super.key,
  });
  final BazaarMainArgs args;

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => BusinessesStore(args.cid)..getBusinesses(),
      child: BazaarPage(
        cid: args.cid,
        appStore: args.appStore,
      ),
    );
  }
}

class BazaarPage extends StatelessWidget {
  const BazaarPage({
    super.key,
    required this.cid,
    required this.appStore,
  });
  final CommunityIdentifier cid;
  static const String route = '/bazaar';
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.acceptancePoints, style: context.headlineSmall),
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
                  style: context.bodySmall,
                ),
                const SizedBox(width: 10),
                const DropdownWidget(),
              ],
            ),
          ),
        ),
      ),
      body: BusinessesView(appStore: appStore),
    );
  }
}
