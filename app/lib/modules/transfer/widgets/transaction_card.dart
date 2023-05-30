import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appStore = context.watch<AppStore>();
    return Card(
      color: colorScheme.background,
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
                          color: zurichLion,
                          size: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          transaction.type.text,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                              style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${appStore.encointer.community?.symbol}',
                                    style: textTheme.displaySmall!.copyWith(
                                      color: transaction.type == TransactionType.incoming
                                          ? colorScheme.primary
                                          : colorScheme.errorContainer,
                                    ),
                                  ),
                                  const WidgetSpan(child: SizedBox(width: 5)),
                                  TextSpan(
                                    text: '${transaction.amount} ',
                                    style: textTheme.displaySmall!.copyWith(
                                        color: transaction.type == TransactionType.incoming
                                            ? colorScheme.primary
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
