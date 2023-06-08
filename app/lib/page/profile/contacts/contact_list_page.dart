import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/account_select_list.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  static const String route = '/profile/contacts/list';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<AccountData>?;
    final store = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(args == null ? context.l10n.addressBook : context.l10n.list),
        centerTitle: true,
        actions: <Widget>[
          if (args == null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(Icons.add, size: 28),
                onPressed: () => Navigator.of(context).pushNamed(ContactPage.route),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            return AccountSelectList(store, args ?? store.settings.contactListAll.toList());
          },
        ),
      ),
    );
  }
}
