import 'package:encointer_wallet/page-encointer/bazaar/menu/1_my_offerings/my_offerings.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/my_businesses.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

class BazaarMenu extends StatelessWidget {
  const BazaarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
              child: Text(l10n.menu),
            ),
          ),
          ListTile(
            title: Text(l10n.offeringsMy),
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
            title: Text(l10n.businessesMy),
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
            title: Text(l10n.notifications),
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
