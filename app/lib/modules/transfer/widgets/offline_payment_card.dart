import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/format.dart';

class OfflinePaymentCard extends StatelessWidget {
  const OfflinePaymentCard(this.record, {super.key});

  final OfflinePaymentRecord record;

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();
    final currentAddress = appStore.account.currentAddress;
    final isIncoming = record.recipientAddress == currentAddress;
    final counterparty = isIncoming ? record.senderAddress : record.recipientAddress;
    final color = isIncoming ? context.colorScheme.primary : const Color(0xffD76D89);
    final symbol = appStore.encointer.community?.symbol ?? '';

    return Card(
      margin: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
        isThreeLine: true,
        leading: Icon(
          isIncoming ? Iconsax.receive_square_2 : Iconsax.send_sqaure_2,
          color: color,
          size: 40,
        ),
        title: Row(
          children: [
            Text(isIncoming ? 'Received' : 'Sent', style: context.bodySmall),
            const SizedBox(width: 6),
            _OfflineLabel(),
            const Spacer(),
            Text(Fmt.dateTime(record.createdAt), style: context.bodySmall),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _truncateAddress(counterparty),
                    style: context.bodySmall,
                  ),
                ],
              ),
            ),
            _StatusBadge(status: record.status),
            const SizedBox(width: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: symbol, style: context.titleMedium.copyWith(color: color)),
                  const WidgetSpan(child: SizedBox(width: 5)),
                  TextSpan(
                    text: '${isIncoming ? '+' : '-'}${record.amount}',
                    style: context.titleMedium.copyWith(fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _truncateAddress(String address) {
    if (address.length <= 12) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 6)}';
  }
}

class _OfflineLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('Offline', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final OfflinePaymentStatus status;

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      OfflinePaymentStatus.pending => (Colors.orange, 'Pending'),
      OfflinePaymentStatus.submitted => (Colors.blue, 'Submitted'),
      OfflinePaymentStatus.confirmed => (Colors.green, 'Confirmed'),
      OfflinePaymentStatus.failed => (Colors.red, 'Failed'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}
