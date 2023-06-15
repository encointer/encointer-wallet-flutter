import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/single_business_detail.dart';
import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/single_business_store.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';

class SingleBusinessView extends StatelessWidget {
  const SingleBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SingleBusinessStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hatha Lisa'.toUpperCase()),
      ),
      body: Observer(builder: (_) {
        switch (store.fetchStatus) {
          case FetchStatus.loading:
            return const CenteredActivityIndicator();
          case FetchStatus.success:
            return SingleBusinessList(singleBusiness: store.singleBusiness!);
          case FetchStatus.error:
            return const ErrorView();
        }
      }),
    );
  }
}

class SingleBusinessList extends StatelessWidget {
  const SingleBusinessList({super.key, required this.singleBusiness});

  final List<SingleBusiness> singleBusiness;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 30),
      itemCount: singleBusiness.length,
      itemBuilder: (BuildContext context, int index) {
        final business = singleBusiness[index];
        return SingleBusinessDetail(
          singleBusiness: business,
        );
      },
    );
  }
}
