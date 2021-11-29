import 'package:flutter/material.dart';

import '../1_home/Home.dart';
import '../2_offerings/Offerings.dart';
import '../3_businesses/Businesses.dart';
import '../4_favorites/Favorites.dart';
import 'BazaarMainState.dart';
import 'BazaarMenu.dart';
import 'BazaarTabBar.dart';

class BazaarMain extends StatelessWidget {
  final BazaarMainState bazaarMainState = BazaarMainState();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bazaarTabBar.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("The Bazaar"),
          centerTitle: true,
          // leading: IconButton(icon: Image.asset('assets/images/assets/ERT.png'), onPressed: () => _chooseCommunity()), // TODO
          leading: IconButton(icon: Image.asset('assets/images/assets/ERT.png'), onPressed: () => null),
          bottom: TabBar(
            tabs: bazaarTabBar,
          ),
        ),
        endDrawer: BazaarMenu(bazaarMainState),
        body: TabBarView(
          children: [
            Home(bazaarMainState),
            Offerings(bazaarMainState),
            Businesses(bazaarMainState),
            Favorites(bazaarMainState),
          ],
        ),
      ),
    );
  }
}
