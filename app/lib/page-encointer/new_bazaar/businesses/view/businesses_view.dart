import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/widgets/empty_businesses.dart';
import 'package:encointer_wallet/models/bazaar/businesses.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/widgets/businesses_card.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

class BusinessesView extends StatelessWidget {
  const BusinessesView({
    required this.appStore,
    super.key,
  });

  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<BusinessesStore>();
    return Observer(builder: (_) {
      return switch (store.fetchStatus) {
        FetchStatus.loading => const CenteredActivityIndicator(),
        FetchStatus.success => BusinessesList(businesses: store.sortedBusinesses, cid: store.cid, appStore: appStore),
        FetchStatus.error => const ErrorView(),
        FetchStatus.noData => const EmptyBusiness(),
      };
    });
  }
}

class BusinessesList extends StatelessWidget {
  const BusinessesList({
    super.key,
    required this.businesses,
    required this.cid,
    required this.appStore,
  });

  final List<Businesses> businesses;
  final CommunityIdentifier cid;
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    if (businesses.isEmpty) return const EmptyBusiness();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 30),
      itemCount: businesses.length,
      itemBuilder: (BuildContext context, int index) {
        final business = businesses[index];
        return BusinessesCard(businesses: business, cid: cid, appStore: appStore);
      },
    );
  }
}
