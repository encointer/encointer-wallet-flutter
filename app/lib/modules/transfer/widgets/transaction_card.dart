import 'package:encointer_wallet/common/components/logo/community_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appStore = context.watch<AppStore>();
    return Card(
      color: colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 130,
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 70,
                height: 70,
                child: CommunityIconObserver(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Icon(
                          transaction.type == TransactionType.incoming
                              ? Iconsax.receive_square_2
                              : Iconsax.send_sqaure_2,
                          color: zurichLion,
                          size: 35,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Erhalten',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
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
                              transaction.getNameFromContacts(appStore.settings.contactList) ?? '',
                              style: textTheme.bodyMedium,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${appStore.encointer.community?.symbol}',
                                    style: textTheme.titleMedium!.copyWith(color: colorScheme.primary),
                                  ),
                                  const WidgetSpan(child: SizedBox(width: 5)),
                                  TextSpan(
                                    text: '${transaction.amount} ',
                                    style: textTheme.titleMedium!
                                        .copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
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
    // Card(
    //   margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    //   color: colorScheme.background,
    //   child: ListTile(
    //     minLeadingWidth: 7,
    //     leading: Icon(
    //       transaction.type == TransactionType.incoming ? Iconsax.receive_square_2 : Iconsax.send_sqaure_2,
    //       color: transaction.type == TransactionType.incoming ? Colors.green : colorScheme.errorContainer,
    //     ),
    //     title: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(transaction.getNameFromContacts(appStore.settings.contactList) ?? ''),
    //         Text.rich(
    //           TextSpan(
    //             children: [
    //               TextSpan(text: '${transaction.amount} '),
    //               TextSpan(
    //                 text: '${appStore.encointer.community?.symbol}',
    //                 style: textTheme.bodySmall!.copyWith(color: colorScheme.primary),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //     subtitle: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(Fmt.address(transaction.counterParty) ?? ''),
    //         Text(Fmt.dateTime(transaction.dateTime)),
    //       ],
    //     ),
    //   ),
    // );
  }
}
