import 'package:ew_translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';

class LangPage extends StatefulWidget {
  const LangPage({super.key});

  static const route = '/lang-page';

  @override
  State<LangPage> createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    final settings = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(title: Text(dic.profile.settingLang)),
      body: ListView.builder(
        itemCount: settings.locales.length,
        itemBuilder: (BuildContext context, int index) {
          final lang = settings.getName(settings.locales[index].languageCode);
          return RadioListTile(
            title: Text(lang),
            value: settings.locales[index],
            groupValue: settings.locale,
            onChanged: (v) async {
              await context.read<AppSettings>().setLocale(index);
            },
          );
        },
      ),
    );
  }
}
