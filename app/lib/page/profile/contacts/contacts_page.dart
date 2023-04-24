import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_detail_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  static const String route = '/profile/contacts';

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) {
          final store = context.watch<AppStore>();

          return Scaffold(
            appBar: AppBar(
              title: Text(
                I18n.of(context)!.translationsForLocale().profile.addressBook,
                style: Theme.of(context).textTheme.displaySmall,
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
                    key: const Key('add-contact'),
                    icon: const Icon(Icons.add, size: 28),
                    onPressed: () => Navigator.of(context).pushNamed(ContactPage.route),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: ListView(
                children: context.watch<AppStore>().settings.contactList.map((contact) {
                  final address = Fmt.ss58Encode(contact.pubKey, prefix: store.settings.endpoint.ss58!);

                  return ListTile(
                    leading: AddressIcon(address, contact.pubKey, size: 45),
                    title: Text(Fmt.accountName(context, contact)),
                    subtitle: Text(Fmt.address(address)!),
                    trailing: SizedBox(
                      width: 36,
                      child: IconButton(
                        key: Key(contact.name),
                        icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        onPressed: () => Navigator.of(context).pushNamed(ContactDetailPage.route, arguments: contact),
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
