import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({required this.transaction, super.key});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();
    final l10n = context.l10n;
    return Card(
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
        isThreeLine: true,
        leading: AddressIcon('', appStore.account.currentAccount.pubKey, size: 55, tapToCopy: false),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(
                transaction.type == TransactionType.incoming ? Iconsax.receive_square_2 : Iconsax.send_sqaure_2,
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
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.isIssuance
                      ? l10n.communityWithName(Community.fromCid(appStore.encointer.community?.cid.toFmtString()).name)
                      : transaction.getNameFromContacts(appStore.settings.contactList) ?? l10n.unknownContact,
                  style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(transaction.isIssuance ? l10n.incomeIssuance : Fmt.address(transaction.counterParty) ?? ''),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${appStore.encointer.community?.symbol}',
                        style: context.textTheme.titleMedium!.copyWith(
                          color: transaction.type == TransactionType.incoming
                              ? context.colorScheme.primary
                              : const Color(0xffD76D89),
                        ),
                      ),
                      const WidgetSpan(child: SizedBox(width: 5)),
                      TextSpan(
                        text: '${transaction.amount} ',
                        style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: transaction.type == TransactionType.incoming
                              ? context.colorScheme.primary
                              : const Color(0xffD76D89),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(Fmt.dateTime(transaction.dateTime)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
