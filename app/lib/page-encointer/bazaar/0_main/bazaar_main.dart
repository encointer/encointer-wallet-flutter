import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/widgets/dropdown_widget.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class BazaarMainArgs {
  BazaarMainArgs({required this.cid});
  final CommunityIdentifier cid;
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
      ),
    );
  }
}

class BazaarPage extends StatelessWidget {
  const BazaarPage({
    super.key,
    required this.cid,
  });
  final CommunityIdentifier cid;
  static const String route = '/bazaar';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    return Provider.value(
      value: (context) => BusinessesStore(cid),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            dic.bazaar.acceptancePoints,
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
      ),
    );
  }
}
