import 'package:encointer_wallet/extras/utils/translations/translations_services.dart';
import 'package:flutter/material.dart';

extension ContextAppLocale on BuildContext {
  I18n get localization => I18n.of(this)!;
}
