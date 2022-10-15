import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/account_select_list.dart';
import 'package:encointer_wallet/page/profile/contacts/contact_page.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class ContactListPage extends StatelessWidget {
  ContactListPage({Key? key}) : super(key: key);

  static const String route = '/profile/contacts/list';

  @override
  Widget build(BuildContext context) {
    final List<AccountData>? args = ModalRoute.of(context)!.settings.arguments as List<AccountData>?;
    final _store = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(args == null
            ? I18n.of(context)!.translationsForLocale().profile.addressBook
            : I18n.of(context)!.translationsForLocale().account.list),
        centerTitle: true,
        actions: <Widget>[
          args == null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 28),
                    onPressed: () => Navigator.of(context).pushNamed(ContactPage.route),
                  ),
                )
              : Container()
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
