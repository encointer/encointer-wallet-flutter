import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  static const String route = '/account/createAccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.create),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Provider(
          create: (context) => NewAccountStore(),
          child: CreateAcccountForm(),
        ),
      ),
    );
  }
}

class CreateAcccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  CreateAcccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ScrollableForm(
      formKey: _formKey,
      listViewChildren: [
        const SizedBox(height: 80),
        Center(
          child: Text(
            l10n.accountNameChoose,
            style: context.headlineMedium,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            l10n.accountNameChooseHint,
            textAlign: TextAlign.center,
            style: context.headlineMedium.copyWith(color: AppColors.encointerBlack),
          ),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-name'),
          hintText: l10n.createHint,
          labelText: l10n.accountName,
          controller: _nameCtrl,
          validator: (v) {
            return InputValidation.validateAccountName(context, v, context.read<AppStore>().account.accountList);
          },
        ),
        const SizedBox(height: 20),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        PrimaryButton(
          key: const Key('create-account-next'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<NewAccountStore>().setName(_nameCtrl.text.trim());
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext _) => Provider.value(
                    value: context.read<NewAccountStore>(),
                    child: const CreatePinView(),
                  ),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.login_1),
              const SizedBox(width: 12),
              Text(
                l10n.next,
                style: context.titleMedium.copyWith(
                  color: context.colorScheme.background,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
