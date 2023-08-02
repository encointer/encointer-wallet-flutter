import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/profile/contacts/contacts_page_store.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_detail_page.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  static const String route = '/profile/contacts';

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late ContactsPageStore _contactsPageStore;

  @override
  void didChangeDependencies() {
    _contactsPageStore = ContactsPageStore(context.watch<AppStore>());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _contactsPageStore.init();
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            context.l10n.addressBook,
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 8),
              key: const Key(EWTestKeys.addContact),
              icon: const Icon(Icons.add, size: 28),
              onPressed: () => Navigator.of(context).pushNamed(ContactPage.route),
            ),
          ],
        ),
        body: SafeArea(
          child: Observer(
            builder: (_) {
              if (_contactsPageStore.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (_contactsPageStore.contactList.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.noContactsStored,
                    style: context.bodyMedium,
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: _contactsPageStore.contactList.length,
                  itemBuilder: (context, index) {
                    final contact = _contactsPageStore.contactList[index];
                    final address =
                        Fmt.ss58Encode(contact.pubKey, prefix: _contactsPageStore.appStore.settings.endpoint.ss58!);
                    return ListTile(
                      key: Key(contact.name),
                      leading: AddressIcon(address, contact.pubKey, size: 45),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Fmt.accountName(context, contact)),
                          Text(
                            '${context.l10n.reputation}: ${contact.reputation.length}',
                            style: context.labelSmall.copyWith(color: AppColors.encointerGrey),
                          )
                        ],
                      ),
                      subtitle: Text(Fmt.address(address)!),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () => Navigator.of(context).pushNamed(ContactDetailPage.route, arguments: contact),
                    );
                  },
                );
              }
            },
          ),
        ),
      );
}
