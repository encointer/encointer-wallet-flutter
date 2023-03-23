import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/extras/utils/translations/translations.dart';
import 'package:flutter/material.dart';

mixin EncointerStateMixin<T extends StatefulWidget> on State<T> {
  late Translations _localization;

  @protected
  Translations get localization => _localization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localization = I18n.of(context)!.translationsForLocale();
  }
}
