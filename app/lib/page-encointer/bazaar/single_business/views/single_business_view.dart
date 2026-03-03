import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/single_business/widgets/single_business_detail.dart';
import 'package:encointer_wallet/page-encointer/bazaar/single_business/logic/single_business_store.dart';

class SingleBusinessView extends StatelessWidget {
  const SingleBusinessView({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<SingleBusinessStore>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Navigator.of(context).pop(store.wasEdited);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(store.business.name.toUpperCase())),
        body: SingleBusinessDetail(business: store.business),
      ),
    );
  }
}
