import 'package:encointer_wallet/presentation/account/ui/widgets/create_pin_form.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key, this.fromImportPage = false});

  final bool fromImportPage;

  static const String route = '/account/createPin';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.create),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: CreatePinForm(fromImportPage: fromImportPage),
      ),
    );
  }
}
