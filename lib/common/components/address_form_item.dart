import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';

class AddressFormItem extends StatelessWidget {
  const AddressFormItem(this.account, {super.key, this.label, this.onTap});
  final String? label;
  final AccountData account;
  final Future<void> Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final grey = Theme.of(context).unselectedWidgetColor;

    final address = Fmt.addressOfAccount(account, context.watch<AppStore>());

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              label!,
              style: TextStyle(color: grey),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Theme.of(context).disabledColor, width: 0.5),
          ),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: AddressIcon(
                  address,
                  account.pubKey,
                  size: 32,
                  tapToCopy: false,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Fmt.accountName(context, account)),
                    Text(
                      Fmt.address(address)!,
                      style: TextStyle(fontSize: 14, color: grey),
                    )
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: grey,
                ),
            ],
          ),
        )
      ],
    );

    if (onTap == null) {
      return content;
    }
    return GestureDetector(
      child: content,
      onTap: () => onTap!(),
    );
  }
}
