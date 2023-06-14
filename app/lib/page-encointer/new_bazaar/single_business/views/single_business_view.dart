import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/single_business_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/logic/like_icon_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar/single_business/widgets/single_business_detail.dart';
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
          title: Builder(builder: (_) {
            return Text(
              'Hatha Lisa'.toUpperCase(),
              // singleBusiness.name.toUpperCase(),
              style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.primary),
            );
          }),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
        body: MultiProvider(
          providers: [
            Provider<LikeIconStore>(
              create: (_) => LikeIconStore(),
            ),
            Provider<SingleBusinessStore>(
              create: (_) => SingleBusinessStore(),
            ),
          ],
          child: const SingleBusinessDetail(),
        )
        // Provider(
        //   create: (context) => LikeIconStore(),
        //   child: const SingleBusinessDetail(),
        // ),
        );
  }
}
