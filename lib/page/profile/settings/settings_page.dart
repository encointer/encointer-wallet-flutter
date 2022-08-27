import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/page/profile/settings/remote_node_list_page.dart';
import 'package:encointer_wallet/page/profile/settings/ss58_prefix_list_page.dart';
import 'package:encointer_wallet/store/settings.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage(this.store, this.changeLang, {Key? key}) : super(key: key);
  static const String route = '/profile/settings';
  final SettingsStore store;
  final Function changeLang;
  @override
  _Settings createState() => _Settings(store, changeLang);
}

class _Settings extends State<SettingsPage> {
  _Settings(this.store, this.changeLang);

  final SettingsStore store;
  final Function changeLang;

  final _langOptions = ['en', 'de'];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();

    String getLang(String code) {
      switch (code) {
        case 'en':
          return 'English';
        case 'de':
          return 'Deutsch';
        default:
          return dic.profile.settingLangAuto;
      }
    }

    void _onLanguageTap() {
      showCupertinoModalPopup(
        context: context,
        builder: (_) => SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: WillPopScope(
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              itemExtent: 58,
              scrollController: FixedExtentScrollController(initialItem: _langOptions.indexOf(store.localeCode)),
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
              String code = _langOptions[_selected];
              if (code != store.localeCode) {
                store.setLocalCode(code);
                changeLang(context, code);
              }
              return true;
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context)!.translationsForLocale().profile.setting),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) => SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: SizedBox(
                  width: 36,
                  child: Image.asset('assets/images/public/${store.endpoint.info}.png'),
                ),
                title: Text(dic.profile.settingNode),
                subtitle: Text(store.endpoint.text ?? ''),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.of(context).pushNamed(RemoteNodeListPage.route),
              ),
              ListTile(
                leading: SizedBox(
                  width: 36,
                  child: Image.asset('assets/images/public/${store.customSS58Format['info']}.png'),
                ),
                title: Text(dic.profile.settingPrefix),
                subtitle: Text(store.customSS58Format['text'] ?? ''),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Navigator.of(context).pushNamed(SS58PrefixListPage.route),
              ),
              ListTile(
                title: Text(dic.profile.settingLang),
                subtitle: Text(getLang(store.localeCode)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => _onLanguageTap(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
