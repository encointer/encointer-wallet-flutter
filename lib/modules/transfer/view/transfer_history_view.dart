import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/transfer/transfer_history.dart';

import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';
import 'package:encointer_wallet/modules/modules.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TransferHistoryStore>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AppBar(
            title: Column(
              children: [
                const Text('Transactions'),
                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                  Text(
                    '5G9dry...MEKpNZ',
                    style: TextStyle(color: encointerBlack, fontSize: 14),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.copy_outlined,
                    size: 18,
                  )
                ]),

                // Text('Balance'),
              ],
            ),
            actions: [
              // IconButton(
              //     iconSize: 30,
              //     icon: const Icon(Iconsax.scan_barcode),
              //     onPressed: () {
              //       Navigator.of(context).pushNamed(
              //         ScanPage.route,
              //         arguments: ScanPageParams(scannerContext: QrScannerContext.transferPage),
              //       );
              //     }),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(30),
                        child: SizedBox(
                          height: 150,
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                  leading: const Icon(
                                    Icons.qr_code_2,
                                    color: zurichLion,
                                  ),
                                  title: const Text(
                                    'Scan QR-Code',
                                    style: TextStyle(color: zurichLion),
                                  ),
                                  onTap: () => {
                                        Navigator.of(context).pushNamed(
                                          ScanPage.route,
                                          arguments: ScanPageParams(scannerContext: QrScannerContext.transferPage),
                                        )
                                      }),
                              ListTile(
                                leading: const Icon(
                                  Icons.copy_sharp,
                                  color: zurichLion,
                                ),
                                title: const Text(
                                  'Copy',
                                  style: TextStyle(color: zurichLion),
                                ),
                                onTap: () => {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Observer(builder: (_) {
        if (store.transfers == null) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (store.transfers!.isEmpty) {
          return const Center(child: Text('No Transfers'));
        } else if (store.transfers!.isNotEmpty) {
          return ListView.builder(
            itemCount: store.transfers!.length,
            itemBuilder: (BuildContext context, int index) {
              final transfer = store.transfers![index];
              return ListTile(
                leading: const Icon(
                  Icons.arrow_upward,
                  color: Colors.green,
                ),
                title: Text(transfer.accountName),
                subtitle: Text(transfer.accountAddress),
                trailing: Text(transfer.amount.toString()),
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
