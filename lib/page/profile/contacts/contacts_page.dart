import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_detail_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage(this.store, {Key? key}) : super(key: key);

  static const String route = '/profile/contacts';
  final AppStore store;

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                I18n.of(context)!.translationsForLocale().profile.addressBook,
                style: Theme.of(context).textTheme.headline3,
              ),
              iconTheme: const IconThemeData(
                color: Color(0xff666666), //change your color here
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 28),
                    onPressed: () => Navigator.of(context).pushNamed(ContactPage.route),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: ListView(
                children: store.settings.contactList.map((i) {
                  return ListTile(
                    leading: AddressIcon(i.address, i.pubKey, size: 45),
                    title: Text(Fmt.accountName(context, i)),
                    subtitle: Text(Fmt.address(i.address)!),
                    trailing: Container(
                      width: 36,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        onPressed: () => Navigator.of(context).pushNamed(ContactDetailPage.route, arguments: i),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );
}
