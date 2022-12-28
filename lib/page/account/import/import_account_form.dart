import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/account_advance_option_params.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/validate_keys.dart';

class ImportAccountForm extends StatefulWidget {
  const ImportAccountForm(this.store, this.onSubmit, {super.key});

  final AppStore store;
  final Function onSubmit;

  @override
  State<ImportAccountForm> createState() => _ImportAccountFormState();
}

class _ImportAccountFormState extends State<ImportAccountForm> {
  // Todo: introduce enum/class for that
  String? _keyType;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keyCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  final AccountAdvanceOptionParams _advanceOptions = AccountAdvanceOptionParams();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _keyCtrl.dispose();
    super.dispose();
  }

  String? _validateAccountSource(BuildContext context, String v) {
    final dic = I18n.of(context)!.translationsForLocale().account;

    final input = v.trim();

    if (input.isEmpty) {
      return dic.importMustNotBeEmpty;
    }

    if (ValidateKeys.isRawSeed(input)) {
      setState(() {
        _keyType = AccountStore.seedTypeRawSeed;
      });
      return ValidateKeys.validateRawSeed(input) ? null : dic.importInvalidRawSeed;
    } else if (ValidateKeys.isPrivateKey(input)) {
      // Todo: #426
      return dic.importPrivateKeyUnsupported;
      // return ValidateKeys.validatePrivateKey(input);
    } else {
      setState(() {
        _keyType = AccountStore.seedTypeMnemonic;
      });
      return ValidateKeys.validateMnemonic(input) ? null : dic.importInvalidMnemonic;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 16, 32),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
//            autovalidate: true,
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 80),
                  Text(
                    I18n.of(context)!.translationsForLocale().profile.detailsEnter,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      I18n.of(context)!.translationsForLocale().profile.personalKeyEnter,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 30),
                  EncointerTextFormField(
                    key: const Key('create-account-name'),
                    hintText: dic.account.createHint,
                    labelText: I18n.of(context)!.translationsForLocale().profile.accountName,
                    controller: _nameCtrl,
                    validator: (v) =>
                        InputValidation.validateAccountName(context, v, widget.store.account.optionalAccounts),
                  ),
                  TextFormField(
                    key: const Key('account-source'),
                    decoration: InputDecoration(
                      hintText: dic.account.mnemonic,
                      labelText: dic.profile.personalKey,
                    ),
                    controller: _keyCtrl,
                    maxLines: 2,
                    validator: (String? value) => _validateAccountSource(context, value!),
                  ),
                ],
              ),
            ),
          ),
          PrimaryButton(
            key: const Key('account-import-next'),
            child: Text(I18n.of(context)!.translationsForLocale().home.next),
            onPressed: () async {
              if (_formKey.currentState!.validate() && !(_advanceOptions.error ?? false)) {
                widget.store.account.setNewAccountName(_nameCtrl.text.trim());
                widget.store.account.setNewAccountKey(_keyCtrl.text.trim());

                widget.onSubmit({
                  'keyType': _keyType,
                  'cryptoType': _advanceOptions.type ?? AccountAdvanceOptionParams.encryptTypeSR,
                  'derivePath': _advanceOptions.path ?? '',
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
