import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/extras/utils/translations/translations_services.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:flutter/material.dart';

class RemoteNodeListPage extends StatelessWidget {
  RemoteNodeListPage({super.key});

  static const String route = '/profile/endpoint';
  final Api? api = webApi;

  final AppStore _appStore = sl.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final endpoints = List<EndpointData>.of(networkEndpoints)
      ..retainWhere((i) => i.info == sl.get<AppStore>().settings.endpoint.info);
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
                    if (_appStore.settings.endpoint.value == i.value)
                      Image.asset(
                        'assets/images/assets/success.png',
                        width: 16,
                      ),
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
