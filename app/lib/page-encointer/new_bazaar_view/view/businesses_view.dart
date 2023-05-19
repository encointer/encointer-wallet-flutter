import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/widgets/businesses_card.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BusinessesView extends StatelessWidget {
  const BusinessesView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<BusinessesStore>();
    final dic = I18n.of(context)!.translationsForLocale().home;
    return Observer(builder: (_) {
      if (store.businesses == null) {
        return const Center(child: CupertinoActivityIndicator());
      } else if (store.businesses!.isEmpty) {
        return const Center(child: Text('No business is found'));
      } else if (store.businesses!.isNotEmpty) {
        return BusinessesList(businesses: store.businesses!);
      } else {
        return Center(child: Text(dic.unknownError));
      }
    });
  }
}

class BusinessesList extends StatelessWidget {
  const BusinessesList({super.key, required this.businesses});

  final List<Businesses> businesses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: businesses.length,
      itemBuilder: (BuildContext context, int index) {
        final business = businesses[index];
        return BusinessesCard(businesses: business);
      },
    );
  }
}
