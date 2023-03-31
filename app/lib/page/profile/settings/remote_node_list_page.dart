import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/common/stores/settings/settings_store.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class RemoteNodeListPage extends StatelessWidget {
  RemoteNodeListPage({super.key});

  static const String route = '/profile/endpoint';
  final Api? api = webApi;

  final _appStore = sl<AppStore>();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final endpoints = List<EndpointData>.of(networkEndpoints)
      ..retainWhere((i) => i.info == _appStore.settings.endpoint.info);
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
                    if (_appStore.settings.endpoint.value == i.value) Assets.images.assets.success.image(width: 16),
                    const Icon(Icons.arrow_forward_ios, size: 18)
                  ],
                ),
              ),
              onTap: () {
                if (_appStore.settings.endpoint.value == i.value) {
                  Navigator.of(context).pop();
                  return;
                }
                _appStore.settings.setEndpoint(i);
                _appStore.settings.setNetworkLoading(true);
                webApi.launchWebview(customNode: true);
                Navigator.of(context).pop();
              },
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.settingNodeList),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.only(top: 8), children: list),
      ),
    );
  }
}
