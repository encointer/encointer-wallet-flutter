import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/import/importAccountPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/inputValidation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddAccountForm extends StatelessWidget {
  AddAccountForm({
    required this.store,
    this.submitting,
    this.onSubmit,
  });
  final Function? onSubmit;
  final bool? submitting;
  final AppStore store;

  static final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 80),
                  Text(
                    I18n.of(context)!.translationsForLocale().profile.accountNameChoose,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    child: Text(
                      I18n.of(context)!.translationsForLocale().profile.accountNameChooseHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 30),
                  EncointerTextFormField(
                    key: Key('create-account-name'),
                    hintText: dic.account.createHint,
                    labelText: I18n.of(context)!.translationsForLocale().profile.accountName,
                    controller: _nameCtrl,
                    validator: (v) => InputValidation.validateAccountName(context, v, store.account.optionalAccounts),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                key: Key('import-account'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.import_2),
                    SizedBox(width: 10),
                    Text(I18n.of(context)!.translationsForLocale().home.accountImport,
                        style: Theme.of(context).textTheme.headline3),
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, ImportAccountPage.route)),
            SizedBox(height: 10),
            PrimaryButton(
              key: Key('create-account-confirm'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.add_square),
                  SizedBox(width: 12),
                  Text(
                    I18n.of(context)!.translationsForLocale().profile.accountCreate,
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: ZurichLion.shade50),
                  ),
                ],
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var name = _nameCtrl.text.trim();

                  store.account.setNewAccountName(name);
                  store.account.setNewAccountPin(store.settings.cachedPin);

                  onSubmit!();
                } else {
                  print("formKey.currentState.validate failed");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
