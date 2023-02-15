import 'package:encointer_wallet/extras/utils/extensions/context_extensions.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  static const route = '/lang-view';

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    final dic = context.localization.translationsForLocale().profile;
    final settings = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(title: Text(dic.settingLang)),
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
