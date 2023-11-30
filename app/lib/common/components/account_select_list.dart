import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter/material.dart';

class AccountSelectList extends StatelessWidget {
  const AccountSelectList(this.store, this.accounts, {super.key});

  final AppStore store;
  final List<AccountData> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: accounts.map((account) {
        final address = AddressUtils.pubKeyHexToAddress(account.pubKey, prefix: store.settings.endpoint.ss58!);

        return ListTile(
          leading: AddressIcon(address, account.pubKey),
          title: Text(Fmt.accountName(context, account)),
          subtitle: Text(Fmt.address(address)!),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => Navigator.of(context).pop(account),
        );
      }).toList(),
    );
  }
}
