import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/components/account_select_list.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/presentation/account/types/account_data.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class ContactListPage extends StatelessWidget {
  ContactListPage({super.key});

  static const String route = '/profile/contacts/list';

  final _store = sl<AppStore>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<AccountData>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(args == null
            ? I18n.of(context)!.translationsForLocale().profile.addressBook
            : I18n.of(context)!.translationsForLocale().account.list),
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
            return AccountSelectList(_store, args ?? _store.settings.contactListAll.toList());
          },
        ),
      ),
    );
  }
}
