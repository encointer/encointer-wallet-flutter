// import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/logic/businesses_store.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/view/businesses_view.dart';
import 'package:encointer_wallet/page-encointer/new_bazaar_view/widgets/dropdown_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_main_state.dart';
// import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_menu.dart';
// import 'package:encointer_wallet/page-encointer/bazaar/0_main/bazaar_tab_bar.dart';
// import 'package:encointer_wallet/page-encointer/bazaar/1_home/home.dart';
// import 'package:encointer_wallet/page-encointer/bazaar/2_offerings/offerings.dart';
// import 'package:encointer_wallet/page-encointer/bazaar/3_businesses/businesses.dart';
// import 'package:encointer_wallet/page-encointer/bazaar/4_favorites/favorites.dart';
// import 'package:encointer_wallet/utils/translations/index.dart';

class BazaarMain extends StatefulWidget {
  const BazaarMain({super.key});
  static const String route = '/bazaar';

  @override
  State<BazaarMain> createState() => _BazaarMainState();
}

class _BazaarMainState extends State<BazaarMain> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Akzeptanzstellen',
          style: textTheme.displayMedium!.copyWith(color: zurichLion.shade600),
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
              children: const [
                Text('Kategorie:'),
                SizedBox(
                  width: 10,
                ),
                DropdownWidget(),
              ],
            ),
          ),
        ),
      ),
      body: Provider(
        create: (context) => BusinessesStore()..getBusinesses(),
        child: const BusinessesView(),
      ),
    );
  }
}

// class BazaarMain extends StatelessWidget {
//   const BazaarMain({super.key});

// static const String route = '/bazaar';

// @override
// Widget build(BuildContext context) => Provider<BazaarMainState>(
//       create: (_) => BazaarMainState(),
//       child: DefaultTabController(
//         length: bazaarTabBar.length,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(I18n.of(context)!.translationsForLocale().bazaar.bazaarTitle),
//             centerTitle: true,
//             // leading: IconButton(icon: Image.asset('assets/images/assets/ert.png'), onPressed: () => _chooseCommunity()), // TODO
//             leading: IconButton(icon: Assets.images.assets.ert.image(), onPressed: () {}),
//             bottom: TabBar(
//               tabs: <Widget>[
//                 const Tab(icon: Icon(Icons.home), text: 'Home'),
//                 Tab(
//                     icon: const Icon(Icons.local_offer),
//                     text: I18n.of(context)!.translationsForLocale().bazaar.offerings),
//                 Tab(
//                     icon: const Icon(Icons.business),
//                     text: I18n.of(context)!.translationsForLocale().bazaar.businesses),
//                 Tab(
//                     icon: const Icon(Icons.favorite, color: Colors.pink),
//                     text: I18n.of(context)!.translationsForLocale().bazaar.favorites),
//               ],
//             ),
//           ),
//           endDrawer: const BazaarMenu(),
//           body: TabBarView(
//             children: [
//               const Home(),
//               Offerings(),
//               Businesses(),
//               Favorites(),
//             ],
//           ),
//         ),
//       ),
//     );
// }
