import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

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
  Future<List<AccountData>> _getAccountsFromInput(String input) async {
    final listLocal = widget.store.account.accountList.toList()..addAll(widget.store.settings.contactList);

    // return local account list if input empty
    if (input.isEmpty || input.trim().length < 3) {
      return listLocal;
    }

    return filterByAddressOrName(listLocal, input).toList();
  }

  /// Filters [accounts] by [nameOrAddress] and returns a filtered iterable.
  ///
  /// This returns duplicates if the `nameOrAddress` matches the name and the address of the same element.
  Iterable<AccountData> filterByAddressOrName(Iterable<AccountData> accounts, String nameOrAddress) {
    final filteredByName = accounts.where((account) => account.name.startsWith(nameOrAddress.trim()));
    final filteredByAddress = accounts.where(
      (account) => Fmt.addressOfAccount(account, widget.store).startsWith(nameOrAddress.trim()),
    );

    return filteredByName.followedBy(filteredByAddress);
  }

  String _itemAsString(AccountData item) {
    final address = Fmt.addressOfAccount(item, widget.store);
    final accInfo = widget.store.account.addressIndexMap[item.address];
    String? idx = '';
    if (accInfo != null && accInfo['accountIndex'] != null) {
      idx = accInfo['accountIndex'] as String?;
    }
    return '${item.name} $idx $address ${item.address}';
  }

  Widget _selectedItemBuilder(BuildContext context, AccountData? item) {
    if (item == null) {
      return Container();
    }
    return Observer(
      builder: (_) {
        final accInfo = widget.store.account.addressIndexMap[item.pubKey];
        final address = Fmt.addressOfAccount(item, widget.store);
        return Container(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              if (!widget.hideIdenticon)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AddressIcon(item.address, item.pubKey, tapToCopy: false, size: 36),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name.isNotEmpty ? item.name : Fmt.accountDisplayNameString(item.address, accInfo)!,
                  ),
                  Text(
                    Fmt.address(address)!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _listItemBuilder(BuildContext context, AccountData item, bool isSelected) {
    return Observer(
      builder: (_) {
        final accInfo = widget.store.account.addressIndexMap[item.pubKey];
        final address = Fmt.addressOfAccount(item, widget.store);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: !isSelected
              ? null
              : BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
          child: ListTile(
            key: Key(item.name),
            selected: isSelected,
            dense: true,
            title: Text(Fmt.address(address)!),
            subtitle: Text(
              item.name.isNotEmpty ? item.name : Fmt.accountDisplayNameString(item.address, accInfo)!,
            ),
            leading: CircleAvatar(
              child: AddressIcon(item.address, item.pubKey),
            ),
            onTap: () {
              widget.onChanged?.call(item);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return DecoratedBox(
      decoration: BoxDecoration(
        color: zurichLion.shade50,
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
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.label,
            labelStyle: Theme.of(context).textTheme.headlineMedium,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
          ),
        ),
        selectedItem: widget.initialValue,
        compareFn: (AccountData i, s) => i.pubKey == s.pubKey,
        validator: (AccountData? u) => u == null ? dic.profile.errorUserNameIsRequired : null,
        asyncItems: _getAccountsFromInput,
        itemAsString: _itemAsString,
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
