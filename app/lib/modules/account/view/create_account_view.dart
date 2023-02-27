import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/common/components/button/custom_button.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

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
        child: Provider(
          create: (context) => AccountCreate(),
          child: CreateAcccountForm(),
        ),
      ),
    );
  }
}

class CreateAcccountForm extends StatelessWidget {
  CreateAcccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Spacer(),
          Text(dic.profile.accountNameChoose, style: textTheme.displayMedium),
          const SizedBox(height: 10),
          Text(
            dic.profile.accountNameChooseHint,
            textAlign: TextAlign.center,
            style: textTheme.displayMedium!.copyWith(color: encointerBlack),
          ),
          const SizedBox(height: 10),
          EncointerTextFormField(
            key: const Key('create-account-name'),
            hintText: dic.account.createHint,
            labelText: dic.profile.accountName,
            controller: _nameCtrl,
            validator: (v) {
              return InputValidation.validateAccountName(context, v, context.read<AppStore>().account.optionalAccounts);
            },
          ),
          const Spacer(flex: 7),
          CustomButtonWithIcon(
            key: const Key('create-account-next'),
            label: dic.account.next,
            icon: const Icon(Iconsax.login_1),
            textStyle: textTheme.displaySmall,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AccountCreate>().setName(_nameCtrl.text.trim());
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext _) => Provider.value(
                      value: context.read<AccountCreate>(),
                      child: const CreatePinView(),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
