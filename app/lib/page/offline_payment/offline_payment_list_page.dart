import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/theme/theme.dart';

class OfflinePaymentListPage extends StatelessWidget {
  const OfflinePaymentListPage({super.key});

  static const String route = '/offline-payment/history';

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    final currentAddress = store.account.currentAddress;

    return Scaffold(
      appBar: AppBar(title: const Text('Offline Payments')),
      body: Observer(
        builder: (_) {
          final payments = store.offlinePayment.payments.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          if (payments.isEmpty) {
            return const Center(child: Text('No offline payments yet'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: payments.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final record = payments[index];
              return _PaymentTile(record: record, currentAddress: currentAddress);
            },
          );
        },
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.record, required this.currentAddress});

  final OfflinePaymentRecord record;
  final String currentAddress;

  @override
  Widget build(BuildContext context) {
    final isSender = record.role == OfflinePaymentRole.sender;
    final counterparty = isSender ? record.recipientAddress : record.senderAddress;
    final sign = isSender ? '-' : '+';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isSender ? Icons.arrow_upward : Icons.arrow_downward,
        color: isSender ? Colors.red : Colors.green,
      ),
      title: Text('$sign${record.amount} \u2D50', style: context.titleMedium),
      subtitle: Text(
        _truncateAddress(counterparty),
        style: context.bodySmall,
      ),
      trailing: _StatusBadge(status: record.status),
    );
  }

  String _truncateAddress(String address) {
    if (address.length <= 12) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 6)}';
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
