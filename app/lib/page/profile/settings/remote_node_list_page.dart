import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class RemoteNodeListPage extends StatelessWidget {
  RemoteNodeListPage({super.key});

  static const String route = '/profile/endpoint';
  final Api? api = webApi;

  @override
  Widget build(BuildContext context) {
    final dic = context.l10n;
    final endpoints = List<EndpointData>.of(networkEndpoints)
      ..retainWhere((i) => i.info == context.watch<AppStore>().settings.endpoint.info);
    final list = endpoints
        .map((i) => ListTile(
              leading: SizedBox(
                width: 36,
                child: Image.asset('assets/images/public/${i.info}.png'),
              ),
              title: Text(i.info!),
              subtitle: Text(i.text!),
              trailing: SizedBox(
                width: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (context.select<AppStore, bool>((store) => store.settings.endpoint.value == i.value))
                      Assets.images.assets.success.image(width: 16),
                    const Icon(Icons.arrow_forward_ios, size: 18)
                  ],
                ),
              ),
              onTap: () {
                if (context.read<AppStore>().settings.endpoint.value == i.value) {
                  Navigator.of(context).pop();
                  return;
                }
                context.read<AppStore>().settings.setEndpoint(i);
                context.read<AppStore>().settings.setNetworkLoading(true);
                webApi.launchWebview(customNode: true);
                Navigator.of(context).pop();
              },
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.settingNodeList),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.only(top: 8), children: list),
      ),
    );
  }
}
