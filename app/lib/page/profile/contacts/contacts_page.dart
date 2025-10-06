import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_detail_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_test_keys/ew_test_keys.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  static const String route = '/profile/contacts';

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.addressBook,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 8),
            key: const Key(EWTestKeys.addContact),
            icon: const Icon(Icons.add, size: 28),
            onPressed: () => Navigator.of(context).pushNamed(ContactPage.route),
          )
        ],
      ),
      body: Observer(builder: (_) {
        return ListView.builder(
          itemCount: appStore.settings.contactList.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = appStore.settings.contactList[index];
            final address =
                AddressUtils.pubKeyHexToAddress(contact.pubKey, prefix: appStore.settings.currentNetwork.ss58());
            return ListTile(
              key: Key(contact.name),
              leading: AddressIcon(address, contact.pubKey, size: 45),
              title: Text(Fmt.accountName(context, contact)),
              subtitle: Text(Fmt.address(address)!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () => Navigator.of(context).pushNamed(ContactDetailPage.route, arguments: contact),
            );
          },
        );
      }),
    );
  }
}
