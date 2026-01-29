import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/ui.dart';
import 'package:ew_keyring/ew_keyring.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard(
    this.transaction,
    this.contacts, {
    super.key,
  });

  final Transaction transaction;
  final List<AccountData> contacts;

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
        leading: AddressIcon(transaction.counterParty, tryGetPubKey(transaction), size: 55),
        title: Row(
          children: [
            if (transaction.transactionType == TransactionType.incoming) incomingIcon(context) else outgoingIcon(),
            const SizedBox(width: 5),
            Text(
              transaction.transactionType.getText(context),
              style: context.bodySmall,
            ),
            const Spacer(),
            Text(Fmt.dateTime(transaction.dateTime), style: context.bodySmall),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        transaction.isIssuance || transaction.isFromTreasury
                            ? l10n.communityWithName(appStore.encointer.community!.name!)
                            : transaction.getNameFromContacts(contacts) ?? l10n.unknown,
                        style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      if (transaction.isSwap)
                        transferAmount(context, appStore.encointer.community!.symbol!, transaction,
                            transactionType: TransactionType.outgoing),
                    ],
                  ),
                  Row(
                    children: [
                      tappableAddress(context, transaction),
                      const Spacer(),
                      if (transaction.isSwap)
                        foreignAssetAmount(context, transaction, transactionType: TransactionType.incoming),
                      if (!transaction.isSwap)
                        transferAmount(context, appStore.encointer.community!.symbol!, transaction),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget tappableAddress(BuildContext context, Transaction transaction) {
  return GestureDetector(
    child: Row(
      children: [
        Text(
          transaction.counterPartyDisplay(context),
          style: context.bodySmall,
        ),
        const SizedBox(width: 3),
        const Icon(Iconsax.copy, size: 14),
      ],
    ),
    onTap: () => UI.copyAndNotify(context, transaction.counterParty),
  );
}

Widget transferAmount(BuildContext context, String symbol, Transaction transaction,
    {TransactionType? transactionType}) {
  final type = transactionType ?? transaction.transactionType;
  final color = type == TransactionType.incoming ? context.colorScheme.primary : const Color(0xffD76D89);

  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: symbol,
          style: context.titleMedium.copyWith(color: color),
        ),
        const WidgetSpan(child: SizedBox(width: 5)),
        TextSpan(
          text: transaction.amount.toString(),
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget foreignAssetAmount(BuildContext context, Transaction transaction, {TransactionType? transactionType}) {
  final type = transactionType ?? transaction.transactionType;
  final color = type == TransactionType.incoming ? context.colorScheme.primary : const Color(0xffD76D89);

  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: transaction.foreignAssetName,
          style: context.titleMedium.copyWith(color: color),
        ),
        const WidgetSpan(child: SizedBox(width: 5)),
        TextSpan(
          text: transaction.foreignAssetAmount.toString(),
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget incomingIcon(BuildContext context) {
  return Icon(
    Iconsax.receive_square_2,
    color: context.colorScheme.primary,
    size: 25,
  );
}

Widget outgoingIcon() {
  return const Icon(
    Iconsax.send_sqaure_2,
    color: Color(0xffD76D89),
    size: 25,
  );
}

String tryGetPubKey(Transaction transaction) {
  String counterPartyPubKey;

  try {
    counterPartyPubKey = AddressUtils.addressToPubKeyHex(transaction.counterParty);
  } catch (e) {
    Log.e('Could not decode address. Error: $e');

    // this is only used in the identicon, so we don't need to localize it.
    counterPartyPubKey = 'invalid address';
  }
  return counterPartyPubKey;
}
