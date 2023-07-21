import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/single_business_detail.dart';
import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/businesses/logic/business_utils.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/store/app.dart';

class SingleBusinessView extends StatelessWidget {
  const SingleBusinessView({
    required this.appStore,
    super.key,
  });
  final AppStore appStore;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SingleBusinessStore>();
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return switch (store.fetchStatus) {
            FetchStatus.success => Text(BusinessUtils.utf8convert(store.singleBusiness!.name.toUpperCase())),
            _ => const SizedBox(),
          };
        }),
      ),
      body: Observer(builder: (_) {
        switch (store.fetchStatus) {
          case FetchStatus.loading:
            return const CenteredActivityIndicator();
          case FetchStatus.success:
            return SingleBusinessDetail(singleBusiness: store.singleBusiness!, appStore: appStore);
          case FetchStatus.error:
            return const ErrorView();
          case FetchStatus.noData:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
