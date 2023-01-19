import 'package:ew_translation/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/1_my_offerings/my_offerings.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/my_businesses.dart';

class BazaarMenu extends StatelessWidget {
  const BazaarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(dic.bazaar.menu),
            ),
          ),
          ListTile(
            title: Text(dic.bazaar.offeringsMy),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => MyOfferings(),
                ),
              );
            },
          ),
          ListTile(
            title: Text(dic.bazaar.businessesMy),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => MyBusinesses(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            title: Text(dic.bazaar.notifications),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
