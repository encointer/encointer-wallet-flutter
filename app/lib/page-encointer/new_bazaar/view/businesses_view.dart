import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/widgets/businesses_card.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

class BusinessesView extends StatelessWidget {
  const BusinessesView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<BusinessesStore>();

    return Observer(builder: (_) {
      switch (store.fetchStatus) {
        case FetchStatus.loading:
          return const CenteredActivityIndicator();
        case FetchStatus.success:
          return BusinessesList(businesses: store.businesses!);
        case FetchStatus.error:
          return const ErrorView();
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
