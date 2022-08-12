import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RemoteNodeListPage extends StatelessWidget {
  const RemoteNodeListPage({Key? key}) : super(key: key);

  static const String route = '/profile/endpoint';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final endpoints = List<EndpointData>.of(networkEndpoints);
    endpoints.retainWhere((i) => i.info == context.read<SettingsStore>().endpoint.info);
    final list = endpoints
        .map((i) => ListTile(
              leading: Image.asset('assets/images/public/${i.info}.png', width: 36),
              title: Text(i.info!),
              subtitle: Text(i.text!),
              trailing: SizedBox(
                width: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    context.read<SettingsStore>().endpoint.value == i.value
                        ? Image.asset('assets/images/assets/success.png', width: 16)
                        : const SizedBox(),
                    const Icon(Icons.arrow_forward_ios, size: 18)
                  ],
                ),
              ),
              onTap: () {
                if (context.read<SettingsStore>().endpoint.value == i.value) {
                  Navigator.of(context).pop();
                  return;
                }
                context.read<SettingsStore>().setEndpoint(i);
                context.read<SettingsStore>().setNetworkLoading(true);
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
        child: ListView(padding: EdgeInsets.only(top: 8), children: list),
      ),
    );
  }
}
