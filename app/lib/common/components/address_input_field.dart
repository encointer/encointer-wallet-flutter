import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class AddressInputField extends StatefulWidget {
  const AddressInputField(
    this.store, {
    super.key,
    this.label,
    this.initialValue,
    this.onChanged,
    this.hideIdenticon = false,
  });

  final AppStore store;
  final String? label;
  final AccountData? initialValue;
  final void Function(AccountData)? onChanged;
  final bool hideIdenticon;

  @override
  State<AddressInputField> createState() => _AddressInputFieldState();
}

class _AddressInputFieldState extends State<AddressInputField> {
  /// Returns true if the [account]'s name or address starts with [nameOrAddress].
  bool filterByAddressOrName(AccountData account, String nameOrAddress) {
    final ss58 = widget.store.settings.endpoint.ss58!;
    // we can't just use account.address unfortunately, see #1019.
    return account.name.startsWith(nameOrAddress.trim()) ||
        Fmt.ss58Encode(account.pubKey, prefix: ss58).startsWith(nameOrAddress.trim());
  }

  Widget _selectedItemBuilder(BuildContext context, AccountData? account) {
    if (account == null) {
      return Container();
    }

    final address = Fmt.ss58Encode(account.pubKey, prefix: widget.store.settings.endpoint.ss58!);

    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          if (!widget.hideIdenticon)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: AddressIcon(address, account.pubKey, tapToCopy: false, size: 36),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(account.name),
              Text(
                Fmt.address(address)!,
                style: TextStyle(fontSize: 12, color: context.theme.unselectedWidgetColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _listItemBuilder(BuildContext context, AccountData account, bool isSelected) {
    final address = Fmt.ss58Encode(account.pubKey, prefix: widget.store.settings.endpoint.ss58!);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: context.colorScheme.primary),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        key: Key(account.name),
        selected: isSelected,
        dense: true,
        title: Text(account.name),
        subtitle: Text(Fmt.address(address)!),
        leading: CircleAvatar(child: AddressIcon(address, account.pubKey)),
        onTap: () {
          widget.onChanged?.call(account);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownSearch<AccountData>(
        key: const Key('transfer-select-account'),
        popupProps: PopupProps.modalBottomSheet(
          isFilterOnline: true,
          showSearchBox: true,
          showSelectedItems: true,
          itemBuilder: _listItemBuilder,
          interceptCallBacks: true,
          emptyBuilder: (context, searchEntry) {
            if (Fmt.isAddress(searchEntry)) {
              final address = searchEntry.replaceAll(' ', '');
              final pubKey = Fmt.ss58Decode(address).pubKey;
              final newAccount = AccountData()
                ..address = address
                ..pubKey = pubKey
                ..name = l10n.unknownAccount;
              return _listItemBuilder(context, newAccount, false);
            } else {
              return Align(
                alignment: Alignment.topCenter,
                child: Text(l10n.contactAddressError),
              );
            }
          },
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.label,
            labelStyle: context.textTheme.headlineMedium,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
          ),
        ),
        selectedItem: widget.initialValue,
        compareFn: (AccountData i, s) => i.pubKey == s.pubKey,
        validator: (AccountData? u) => u == null ? l10n.errorUserNameIsRequired : null,
        items: widget.store.settings.knownAccounts(),
        filterFn: filterByAddressOrName,
        onChanged: (AccountData? data) {
          if (widget.onChanged != null && data != null) {
            widget.onChanged!(data);
          }
        },
        dropdownBuilder: _selectedItemBuilder,
      ),
    );
  }
}
