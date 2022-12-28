import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

const defaultSs58Prefix = {
  'info': 'default',
  'text': 'Default for the connected node',
  'value': 42,
};
const prefixList = [
  defaultSs58Prefix,
  {'info': 'substrate', 'text': 'Substrate (development)', 'value': 42},
  {'info': 'kusama', 'text': 'Kusama (canary)', 'value': 2},
  {'info': 'polkadot', 'text': 'Polkadot (live)', 'value': 0}
];

class SS58PrefixListPage extends StatelessWidget {
  SS58PrefixListPage({super.key});

  static const String route = '/profile/ss58';
  final Api? api = webApi;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final list = prefixList
        .map((i) => ListTile(
              leading: SizedBox(
                width: 36,
                child: Image.asset('assets/images/public/${i['info']}.png'),
              ),
              title: Text(i['info']! as String),
              subtitle: Text(i['text']! as String),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                if (context.read<AppStore>().settings.customSS58Format['info'] == i['info']) {
                  Navigator.of(context).pop();
                  return;
                }
                context.read<AppStore>().settings.setCustomSS58Format(i);
//                if (i['info'] == 'default') {
//                  api.account
//                      .setSS58Format(default_ss58_map[context.read<AppStore>().settings.endpoint.info]);
//                } else {
//                  api.account.setSS58Format(i['value']);
//                }
                Navigator.of(context).pop();
              },
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.settingPrefixList),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(children: list),
      ),
    );
  }
}
