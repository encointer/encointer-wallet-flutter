import 'package:encointer_wallet/common/stores/language/app_language_store.dart';
import 'package:encointer_wallet/utils/encointer_state_mixin.dart';
import 'package:flutter/material.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  static const route = '/lang-view';

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> with EncointerStateMixin {
  final languageStore = AppLanguageStore();

  @override
  Widget build(BuildContext context) {
    final dic = localization.profile;

    return Scaffold(
      appBar: AppBar(title: Text(dic.settingLang)),
      body: ListView.builder(
        itemCount: languageStore.locales.length,
        itemBuilder: (BuildContext context, int index) {
          final lang = languageStore.getName(languageStore.locales[index].languageCode);
          return RadioListTile(
            title: Text(lang),
            value: languageStore.locales[index],
            groupValue: languageStore.locale,
            onChanged: (v) async {
              await languageStore.setLocale(index);
            },
          );
        },
      ),
    );
  }
}
