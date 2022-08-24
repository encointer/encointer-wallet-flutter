import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/1_home/home.dart';
import 'package:encointer_wallet/page-encointer/bazaar/2_offerings/offerings.dart';
import 'package:encointer_wallet/page-encointer/bazaar/3_businesses/businesses.dart';
import 'package:encointer_wallet/page-encointer/bazaar/4_favorites/favorites.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

import 'bazaar_main_state.dart';
import 'bazaar_menu.dart';
import 'bazaar_tab_bar.dart';

class BazaarMain extends StatelessWidget {
  static const String route = '/bazaar';

  final AppStore store;

  BazaarMain(this.store);

  @override
  Widget build(BuildContext context) => Provider<BazaarMainState>(
        create: (_) => BazaarMainState(),
        child: DefaultTabController(
          length: bazaarTabBar.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(I18n.of(context)!.translationsForLocale().bazaar.bazaarTitle),
              centerTitle: true,
              // leading: IconButton(icon: Image.asset('assets/images/assets/ERT.png'), onPressed: () => _chooseCommunity()), // TODO
              leading: IconButton(icon: Image.asset('assets/images/assets/ERT.png'), onPressed: () => null),
              bottom: TabBar(
                tabs: <Widget>[
                  const Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(
                      icon: const Icon(Icons.local_offer),
                      text: I18n.of(context)!.translationsForLocale().bazaar.offerings),
                  Tab(
                      icon: const Icon(Icons.business),
                      text: I18n.of(context)!.translationsForLocale().bazaar.businesses),
                  Tab(
                      icon: const Icon(Icons.favorite, color: Colors.pink),
                      text: I18n.of(context)!.translationsForLocale().bazaar.favorites),
                ],
              ),
            ),
            endDrawer: const BazaarMenu(),
            body: TabBarView(
              children: [
                Home(),
                Offerings(),
                Businesses(),
                Favorites(),
              ],
            ),
          ),
        ),
      );
}
