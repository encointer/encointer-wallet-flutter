import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class LangPage extends StatefulWidget {
  const LangPage({super.key});

  static const route = '/lang-page';

  @override
  State<LangPage> createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.lang)),
      body: RadioGroup<Locale>(
        groupValue: settings.locale,
        onChanged: (locale) async {
          await context.read<AppSettings>().setLocale(locale!.languageCode);
        },
        child: ListView.builder(
          itemCount: AppLocalizations.supportedLocales.length,
          itemBuilder: (BuildContext context, int index) {
            final locale = AppLocalizations.supportedLocales[index];
            final lang = context.localeName(locale.languageCode);
            return RadioListTile<Locale>(
              key: Key('locale-${locale.languageCode}'),
              title: Text(lang),
              value: locale,
            );
          },
        ),
      ),
    );
  }
}
