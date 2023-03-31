import 'package:flutter/material.dart';
import 'package:encointer_wallet/presentation/account/ui/widgets/add_account_form.dart';

import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class AddAccountView extends StatelessWidget {
  const AddAccountView({super.key});

  static const String route = '/account/addAccount';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.addAccount),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: AddAcccountForm(),
      ),
    );
  }
}
