import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/logic/like_icon_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/widgets/single_business_detail.dart';
// import 'package:encointer_wallet/models/bazaar/single_business.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';

class SingleBusinessView extends StatelessWidget {
  const SingleBusinessView({super.key});

  // final SingleBusiness singleBusiness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () {},
        ),
        title: Text(
          'Hatha Lisa'.toUpperCase(),
          // singleBusiness.name.toUpperCase(),
          style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.primary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Provider(
        create: (context) => LikeIconStore(),
        child: const SingleBusinessDetail(),
      ),
    );
  }
}
