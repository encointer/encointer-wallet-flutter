import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

class AccountSelectList extends StatelessWidget {
  AccountSelectList(this.store, this.list, {Key? key}) : super(key: key);

  final AppStore store;
  final List<AccountData> list;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: list.map((i) {
        return ListTile(
          leading: AddressIcon(i.address, i.pubKey),
          title: Text(Fmt.accountName(context, i)),
          subtitle: Text(Fmt.address(Fmt.addressOfAccount(i, store))!),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => Navigator.of(context).pop(i),
        );
      }).toList(),
    );
  }
}
