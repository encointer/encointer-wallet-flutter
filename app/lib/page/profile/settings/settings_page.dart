import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/profile/settings/remote_node_list_page.dart';
import 'package:encointer_wallet/page/profile/settings/ss58_prefix_list_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  static const String route = '/profile/settings';

  @override
  State<SettingsPage> createState() => _Settings();
}

class _Settings extends State<SettingsPage> {
  final _langOptions = ['en', 'de'];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<AppStore>();

    String getLang(String code) {
      return switch (code) {
        'en' => 'English',
        'de' => 'Deutsch',
        _ => l10n.settingLangAuto,
      };
    }

    void onLanguageTap() {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (_) => SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: WillPopScope(
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 58,
              scrollController: FixedExtentScrollController(
                initialItem: _langOptions.indexOf(store.settings.localeCode),
              ),
              children: _langOptions.map((i) {
                return Padding(padding: const EdgeInsets.all(16), child: Text(getLang(i)));
              }).toList(),
              onSelectedItemChanged: (v) {
                setState(() {
                  _selected = v;
                });
              },
            ),
            onWillPop: () async {
              final code = _langOptions[_selected];
              if (code != context.read<AppStore>().settings.localeCode) {
                await context.read<AppStore>().settings.setLocalCode(code);
                context.read<AppStore>().settings.changeLang(context, code);
              }
              return true;
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.setting),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) => SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: SizedBox(
                  width: 36,
                  child: Image.asset('assets/images/public/${store.settings.endpoint.info}.png'),
                ),
                title: Text(l10n.settingNode),
                subtitle: Text(store.settings.endpoint.text ?? ''),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.of(context).pushNamed(RemoteNodeListPage.route),
              ),
              ListTile(
                leading: SizedBox(
                  width: 36,
                  child: Image.asset('assets/images/public/${store.settings.customSS58Format['info']}.png'),
                ),
                title: Text(l10n.settingPrefix),
                subtitle: Text(store.settings.customSS58Format['text'] as String? ?? ''),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.of(context).pushNamed(SS58PrefixListPage.route),
              ),
              ListTile(
                title: Text(l10n.settingLang),
                subtitle: Text(getLang(store.settings.localeCode)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: onLanguageTap,
              )
            ],
          ),
        ),
      ),
    );
  }
}
