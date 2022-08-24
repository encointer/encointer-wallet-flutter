import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class AddressInputField extends StatefulWidget {
  AddressInputField(this.store, {this.label, this.initialValue, this.onChanged, this.hideIdenticon = false});
  final AppStore store;
  final String? label;
  final AccountData? initialValue;
  final Function(AccountData)? onChanged;
  final bool hideIdenticon;
  @override
  _AddressInputFieldState createState() => _AddressInputFieldState();
}

class _AddressInputFieldState extends State<AddressInputField> {
  Future<List<AccountData>> _getAccountsFromInput(String input) async {
    final listLocal = widget.store.account.accountList.toList();
    listLocal.addAll(widget.store.settings.contactList);
    // return local account list if input empty
    if (input.isEmpty || input.trim().length < 3) {
      return listLocal;
    }

    // check if user input is valid address or indices
    final checkAddress = await webApi.account.decodeAddress([input]);
    if (checkAddress.isEmpty) {
      return listLocal;
    }

    final accountData = AccountData();
    accountData.address = input;
    if (input.length < 47) {
      // check if input indices in local account list
      final int indicesIndex = listLocal.indexWhere((e) {
        final Map? accInfo = widget.store.account.addressIndexMap[e.address];
        return accInfo != null && accInfo['accountIndex'] == input;
      });
      if (indicesIndex >= 0) {
        return [listLocal[indicesIndex]];
      }
      // query account address with account indices
      final queryRes = await webApi.account.queryAddressWithAccountIndex(input);
      if (queryRes != null) {
        accountData.address = queryRes[0];
        accountData.name = input;
      }
    } else {
      // check if input address in local account list
      final int addressIndex = listLocal.indexWhere((e) => _itemAsString(e).contains(input));
      if (addressIndex >= 0) {
        return [listLocal[addressIndex]];
      }
    }

    await webApi.account.fetchAddressIndex([accountData.address]);

    return [accountData];
  }

  String _itemAsString(AccountData item) {
    final String address = Fmt.addressOfAccount(item, widget.store);
    final Map? accInfo = widget.store.account.addressIndexMap[item.address];
    String? idx = '';
    if (accInfo != null && accInfo['accountIndex'] != null) {
      idx = accInfo['accountIndex'];
    }
    return '${item.name} $idx $address ${item.address}';
  }

  Widget _selectedItemBuilder(BuildContext context, AccountData? item) {
    if (item == null) {
      return Container();
    }
    return Observer(
      builder: (_) {
        final Map? accInfo = widget.store.account.addressIndexMap[item.pubKey];
        final String address = Fmt.addressOfAccount(item, widget.store);
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
        final Map? accInfo = widget.store.account.addressIndexMap[item.pubKey];
        final String address = Fmt.addressOfAccount(item, widget.store);
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
            selected: isSelected,
            dense: true,
            title: Text(Fmt.address(address)!),
            subtitle: Text(
              item.name.isNotEmpty ? item.name : Fmt.accountDisplayNameString(item.address, accInfo)!,
            ),
            leading: CircleAvatar(
              child: AddressIcon(item.address, item.pubKey),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    return Container(
      decoration: BoxDecoration(
        color: ZurichLion.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownSearch<AccountData>(
        popupProps: PopupProps.modalBottomSheet(
          isFilterOnline: true,
          showSearchBox: true,
          showSelectedItems: true,
          itemBuilder: _listItemBuilder,
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.label,
            labelStyle: Theme.of(context).textTheme.headline4,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
        selectedItem: widget.initialValue,
        compareFn: (AccountData i, s) => i.pubKey == s.pubKey,
        validator: (AccountData? u) => u == null ? dic.profile.errorUserNameIsRequired : null,
        asyncItems: (String filter) => _getAccountsFromInput(filter),
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
