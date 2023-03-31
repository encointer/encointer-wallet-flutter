import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

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
              title: Text((i['info'] as String?) ?? ''),
              subtitle: Text((i['text'] as String?) ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                if (sl<AppStore>().settings.customSS58Format['info'] == i['info']) {
                  Navigator.of(context).pop();
                  return;
                }
                sl<AppStore>().settings.setCustomSS58Format(i);

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
