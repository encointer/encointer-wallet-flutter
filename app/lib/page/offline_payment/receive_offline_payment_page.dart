import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/offline_payment/components/trust_indicator.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/offline_payment.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/theme/theme.dart';

class ReceiveOfflinePaymentPage extends StatelessWidget {
  const ReceiveOfflinePaymentPage({super.key});

  static const String route = '/offline-payment/receive';

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments! as OfflinePaymentData;

    return Scaffold(
      appBar: AppBar(title: const Text('Offline Payment')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('From: ${data.label}', style: context.titleLarge),
              const SizedBox(height: 8),
              Text(data.sender, style: context.bodySmall),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  '${data.amount} \u2D50',
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Center(child: Text(data.cidFmt, style: context.bodyMedium)),
              const SizedBox(height: 24),
              TrustIndicator(reputationCount: data.reputationCount),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Decline'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _acceptPayment(context, data),
                      child: const Text('Accept'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _acceptPayment(BuildContext context, OfflinePaymentData data) async {
    final store = context.read<AppStore>();

    // Validate recipient matches current account
    if (data.recipient != store.account.currentAddress) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This payment is not addressed to your current account.')),
        );
      }
      return;
    }

    // Reject duplicate nullifiers
    if (store.offlinePayment.payments.any((p) => p.nullifierHex == data.nullifierHex)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This payment has already been received.')),
        );
      }
      return;
    }

    final record = OfflinePaymentRecord(
      proofBase64: data.proofBase64,
      senderAddress: data.sender,
      recipientAddress: data.recipient,
      cidFmt: data.cidFmt,
      amount: double.parse(data.amount),
      nullifierHex: data.nullifierHex,
      commitmentHex: data.commitmentHex,
      role: OfflinePaymentRole.receiver,
      createdAt: DateTime.now(),
    );
    await store.offlinePayment.addPayment(record);
    if (context.mounted) Navigator.of(context).pop();
  }
}
