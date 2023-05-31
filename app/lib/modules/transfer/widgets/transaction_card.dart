import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.transaction,
    super.key,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();
    return Card(
      color: context.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: AddressIcon(
                '',
                appStore.account.currentAccount.pubKey,
                size: 55,
                tapToCopy: false,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      children: [
                        Icon(
                          transaction.type == TransactionType.incoming
                              ? Iconsax.receive_square_2
                              : Iconsax.send_sqaure_2,
                          color: context.colorScheme.primary,
                          size: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          transaction.type.getText(context),
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transaction.getNameFromContacts(appStore.settings.contactList) ?? 'No Name',
                              style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${appStore.encointer.community?.symbol}',
                                    style: context.textTheme.displaySmall!.copyWith(
                                      color: transaction.type == TransactionType.incoming
                                          ? context.colorScheme.primary
                                          : const Color(0xffD76D89),
                                    ),
                                  ),
                                  const WidgetSpan(child: SizedBox(width: 5)),
                                  TextSpan(
                                    text: '${transaction.amount} ',
                                    style: context.textTheme.displaySmall!.copyWith(
                                        color: transaction.type == TransactionType.incoming
                                            ? context.colorScheme.primary
                                            : const Color(0xffD76D89),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Fmt.address(transaction.counterParty) ?? ''),
                          Text(Fmt.dateTime(transaction.dateTime)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
