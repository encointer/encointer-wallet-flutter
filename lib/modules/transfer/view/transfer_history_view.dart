import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TransferHistoryStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer History'),
      ),
      body: Observer(builder: (_) {
        if (store.transfers == null) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (store.transfers!.isEmpty) {
          return const Center(child: Text('No Transfres'));
        } else if (store.transfers!.isNotEmpty) {
          return ListView.builder(
            itemCount: store.transfers!.length,
            itemBuilder: (BuildContext context, int index) {
              final transfer = store.transfers![index];
              return ListTile(
                title: Text(transfer.accountName),
                subtitle: Text(transfer.accountAddress),
              );
            },
          );
        } else {
          return const Center(child: Text('Unknown Error'));
        }
      }),
    );
  }
}
