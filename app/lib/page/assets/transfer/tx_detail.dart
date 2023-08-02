import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/jump_to_browser_link.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/utils/ui.dart';
import 'package:encointer_wallet/theme/theme.dart';

class TxDetail extends StatelessWidget {
  const TxDetail({
    super.key,
    this.success,
    this.networkName,
    this.action,
    required this.eventId,
    this.hash,
    this.blockTime,
    this.blockNum,
    this.info,
  });

  final bool? success;
  final String? networkName;
  final String? action;
  final String? eventId;
  final String? hash;
  final String? blockTime;
  final int? blockNum;
  final List<DetailInfoItem>? info;

  List<Widget> _buildListView(BuildContext context) {
    final l10n = context.l10n;
    Widget buildLabel(String name) {
      return Container(
          padding: const EdgeInsets.only(left: 8),
          width: 80,
          child: Text(name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )));
    }

    final list = <Widget>[
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(24),
            child: success! ? Assets.images.assets.success.image() : Assets.images.assets.assetsFail.image(),
          ),
          Text(
            '$action ${success! ? l10n.success : l10n.fail}',
            style: context.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: Text(blockTime!),
          ),
        ],
      ),
      const Divider(),
    ];
    for (final i in info!) {
      list.add(ListTile(
        leading: buildLabel(i.label!),
        title: Text(i.title!),
        subtitle: i.subtitle != null ? Text(i.subtitle!) : null,
        trailing: i.address != null
            ? IconButton(
                icon: Assets.images.public.copy.image(),
                onPressed: () => UI.copyAndNotify(context, i.address),
              )
            : null,
      ));
    }

    String? pnLink = 'https://polkascan.io/pre/${networkName!.toLowerCase()}/transaction/$hash';
    String? snLink = 'https://${networkName!.toLowerCase()}.subscan.io/extrinsic/$hash';
    if (networkName == networkEndpointEncointerGesell.info ||
        networkName == networkEndpointEncointerGesellDev.info ||
        networkName == networkEndpointEncointerCantillon.info) {
      pnLink = null;
      snLink = null;
    }
    list.addAll(<Widget>[
      ListTile(
        leading: buildLabel(l10n.event),
        title: Text(eventId!),
      ),
      ListTile(
        leading: buildLabel(l10n.block),
        title: Text('#$blockNum'),
      ),
      ListTile(
        leading: buildLabel(l10n.hash),
        title: Text(Fmt.address(hash)!),
        trailing: SizedBox(
          width: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              JumpToBrowserLink(
                pnLink,
                text: 'Polkascan',
              ),
              if (snLink != null)
                JumpToBrowserLink(
                  snLink,
                  text: 'Subscan',
                ),
            ],
          ),
        ),
      ),
    ]);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.detail),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: _buildListView(context),
        ),
      ),
    );
  }
}

class DetailInfoItem {
  DetailInfoItem({this.label, this.title, this.subtitle, this.address});

  final String? label;
  final String? title;
  final String? subtitle;
  final String? address;
}
