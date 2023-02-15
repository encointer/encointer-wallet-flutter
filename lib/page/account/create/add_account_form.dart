import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/import/import_account_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/extras/utils/translations/translations_services.dart';

class AddAccountForm extends StatelessWidget {
  AddAccountForm({
    super.key,
    required this.store,
    this.submitting,
    required this.onSubmit,
  });

  final VoidCallback onSubmit;
  final bool? submitting;
  final AppStore store;

  static final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 80),
                  Text(
                    I18n.of(context)!.translationsForLocale().profile.accountNameChoose,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Text(
                      I18n.of(context)!.translationsForLocale().profile.accountNameChooseHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  EncointerTextFormField(
                    key: const Key('create-account-name'),
                    hintText: dic.account.createHint,
                    labelText: I18n.of(context)!.translationsForLocale().profile.accountName,
                    controller: _nameCtrl,
                    validator: (v) => InputValidation.validateAccountName(context, v, store.account.optionalAccounts),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                key: const Key('import-account'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.import_2),
                    const SizedBox(width: 10),
                    Text(I18n.of(context)!.translationsForLocale().home.accountImport,
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, ImportAccountPage.route)),
            const SizedBox(height: 10),
            PrimaryButton(
              key: const Key('create-account-confirm'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.add_square),
                  const SizedBox(width: 12),
                  Text(
                    I18n.of(context)!.translationsForLocale().profile.accountCreate,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(color: zurichLion.shade50),
                  ),
                ],
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = _nameCtrl.text.trim();

                  store.account.setNewAccountName(name);
                  store.account.setNewAccountPin(store.settings.cachedPin);

                  onSubmit();
                } else {
                  Log.d('formKey.currentState.validate failed', 'AddAccountForm');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
