import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class AddAccountView extends StatelessWidget {
  const AddAccountView({super.key});

  static const String route = '/account/addAccount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.addAccount),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Provider(
          create: (context) => NewAccountStore(),
          child: AddAcccountForm(),
        ),
      ),
    );
  }
}

class AddAcccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  AddAcccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final newAccountStore = context.watch<NewAccountStore>();
    return ScrollableForm(formKey: _formKey, listViewChildren: [
      const SizedBox(height: 80),
      Center(
        child: Text(
          l10n.accountNameChoose,
          style: context.textTheme.displayMedium,
        ),
      ),
      const SizedBox(height: 10),
      Center(
        child: Text(
          l10n.accountNameChooseHint,
          textAlign: TextAlign.center,
          style: context.textTheme.displayMedium!.copyWith(color: AppColors.encointerBlack),
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
    ], columnChildren: [
      const SizedBox(height: 10),
      SecondaryButtonWide(
        key: const Key('import-account'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.import_2),
            const SizedBox(width: 10),
            Text(l10n.accountImport, style: context.textTheme.displaySmall),
          ],
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext _) => Provider.value(
                value: context.read<NewAccountStore>(),
                child: const ImportAccountView(),
              ),
            ),
          );
        },
      ),
      const SizedBox(height: 10),
      PrimaryButton(
        key: const Key('create-account-confirm'),
        onPressed: () async {
          final newAccount = context.read<NewAccountStore>();
          if (_formKey.currentState!.validate() && !newAccount.loading) {
            newAccount.setName(_nameCtrl.text.trim());
            final res = await newAccount.generateAccount(context, webApi);
            await navigate(
              context: context,
              type: res.operationResult,
              onOk: () => Navigator.of(context).popUntil((route) => route.isFirst),
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.add_square),
            const SizedBox(width: 12),
            Observer(builder: (_) {
              if (newAccountStore.loading) {
                return const CenteredActivityIndicator();
              } else {
                return Text(l10n.create);
              }
            }),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ]);
  }
}
