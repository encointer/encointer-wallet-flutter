import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
// import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/like_icon_store.dart';
// import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/single_business_store.dart';
// import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/views/single_business_view.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/widgets/businesses_card.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

class BusinessesView extends StatelessWidget {
  const BusinessesView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<BusinessesStore>();
    return Observer(builder: (_) {
      return switch (store.fetchStatus) {
        FetchStatus.loading => const CenteredActivityIndicator(),
        FetchStatus.success => BusinessesList(businesses: store.businesses!),
        FetchStatus.error => const ErrorView(),
      };
    });
  }
}

class BusinessesList extends StatelessWidget {
  const BusinessesList({super.key, required this.businesses});

  final List<Businesses> businesses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 30),
      itemCount: businesses.length,
      itemBuilder: (BuildContext context, int index) {
        final business = businesses[index];
        return BusinessesCard(businesses: business);
      },
    );
  }
}
