import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/account_advance_option_params.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/create_pin_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class CreateAccountForm extends StatelessWidget {
  CreateAccountForm({
    Key? key,
    required this.store,
  }) : super(key: key);

  final AppStore store;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();

    Future<void> _createAndImportAccount() async {
      await webApi.account.generateAccount();

      var acc = await webApi.account.importAccount(
        cryptoType: AccountAdvanceOptionParams.encryptTypeSR,
        derivePath: '',
      );

      if (acc['error'] != null) {
        _showErrorCreatingAccountDialog(context);
        return;
      }

      var addresses = await webApi.account.encodeAddress([acc['pubKey']]);
      await store.addAccount(acc, store.account.newAccount.password, addresses[0]);

      String? pubKey = acc['pubKey'];
      store.setCurrentAccount(pubKey);

      await store.loadAccountCache();

      // fetch info for the imported account
      webApi.fetchAccountData();
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 80),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                Center(
                  child: Text(I18n.of(context)!.translationsForLocale().profile.accountNameChoose,
                      style: Theme.of(context).textTheme.headline2),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      I18n.of(context)!.translationsForLocale().profile.accountNameChooseHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: encointerBlack,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
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
          Container(
            key: const Key('create-account-next'),
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.login_1),
                  const SizedBox(width: 12),
                  Text(
                    dic.account.next,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: ZurichLion.shade50,
                        ),
                  ),
                ],
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  store.account.setNewAccountName(_nameCtrl.text.trim());
                  Navigator.pushNamed(
                    context,
                    CreatePinPage.route,
                    arguments: CreatePinPageParams(_createAndImportAccount),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showErrorCreatingAccountDialog(BuildContext context) async {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Container(),
        content: Text(I18n.of(context)!.translationsForLocale().account.createError),
        actions: <Widget>[
          CupertinoButton(
            child: Text(I18n.of(context)!.translationsForLocale().home.ok),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
