import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class LangPage extends StatefulWidget {
  const LangPage({super.key});

  static const route = '/lang-page';

  @override
  State<LangPage> createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().profile;
    final settings = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(title: Text(dic.settingLang)),
      body: ListView.builder(
        itemCount: settings.locales.length,
        itemBuilder: (BuildContext context, int index) {
          final locale = settings.locales[index];
          final lang = settings.getLocaleName(locale.languageCode);
          return RadioListTile(
            key: Key('locale-${locale.languageCode}'),
            title: Text(lang),
            value: locale,
            groupValue: settings.locale,
            onChanged: (v) async {
              await context.read<AppSettings>().setLocale(locale.languageCode);
            },
          );
        },
      ),
    );
  }
}
