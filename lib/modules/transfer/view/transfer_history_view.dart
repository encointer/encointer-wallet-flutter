import 'package:flutter/material.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransferHistoryView'),
      ),
    );
  }
}
