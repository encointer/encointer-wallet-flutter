import 'package:flutter/material.dart';

import 'package:encointer_wallet/presentation/account/ui/widgets/create_account_form.dart';

import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  static const String route = '/account/createAccount';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.create),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: CreateAcccountForm(),
      ),
    );
  }
}
