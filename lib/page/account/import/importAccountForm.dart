import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/translations/translationsAccount.dart';
import 'package:encointer_wallet/utils/validateKeys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImportAccountForm extends StatefulWidget {
  const ImportAccountForm(this.store, this.onSubmit);

  final AppStore store;
  final Function onSubmit;

  @override
  _ImportAccountFormState createState() => _ImportAccountFormState();
}

// TODO: add mnemonic word check & selection
class _ImportAccountFormState extends State<ImportAccountForm> {
  final List<String> _keyOptions = [
    AccountStore.seedTypeMnemonic,
    AccountStore.seedTypeRawSeed,
    // 'observe',
  ];

  KeySelection _keySelection = KeySelection.MNEMONIC;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keyCtrl = new TextEditingController();
  final TextEditingController _nameCtrl = new TextEditingController();

  AccountAdvanceOptionParams _advanceOptions = AccountAdvanceOptionParams();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _keyCtrl.dispose();
    super.dispose();
  }

  String _validateAccountSource(BuildContext context, String v) {
    final TranslationsAccount dic = I18n.of(context).translationsForLocale().account;

    String input = v.trim();

    if (input.isEmpty) {
      return null;
    }

    if (ValidateKeys.isRawSeed(input)) {
      setState(() {
        _keySelection = KeySelection.RAW_SEED;
      });
      return ValidateKeys.validateRawSeed(input) ? null : dic.importInvalidRawSeed;
    } else if (ValidateKeys.isPrivateKey(input)) {
      // Todo: #426
      return dic.importPrivateKeyUnsupported;
      // return ValidateKeys.validatePrivateKey(input);
    } else {
      setState(() {
        _keySelection = KeySelection.MNEMONIC;
      });
      return ValidateKeys.validateMnemonic(input) ? null : dic.importInvalidMnemonic;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();

    return Column(
      children: <Widget>[
        Expanded(
          child: Form(
            key: _formKey,
//            autovalidate: true,
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: <Widget>[
                SizedBox(height: 80),
                Text(
                  I18n.of(context).translationsForLocale().profile.detailsEnter,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 300,
                    child: Text(
                      I18n.of(context).translationsForLocale().profile.personalKeyEnter,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  key: Key('create-account-name'),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                    ),
                    filled: true,
                    fillColor: ZurichLion.shade50,
                    hintText: dic.account.createHint,
                    labelText: I18n.of(context).translationsForLocale().profile.accountName,
                  ),
                  controller: _nameCtrl,
                ),
                Padding(
                  key: Key('account-source'),
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: dic.account.mnemonic,
                      labelText: dic.profile.personalKey,
                    ),
                    controller: _keyCtrl,
                    maxLines: 2,
                    validator: (String value) => _validateAccountSource(context, value),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          key: Key('account-import-next'),
          padding: EdgeInsets.all(16),
          child: PrimaryButton(
            child: Text(I18n.of(context).translationsForLocale().home.next),
            onPressed: () async {
              if (_formKey.currentState.validate() && !(_advanceOptions.error ?? false)) {
                widget.store.account.setNewAccountKey(
                    _keySelection == KeySelection.MNEMONIC ? _keyCtrl.text.trim() : _nameCtrl.text.trim());

                widget.onSubmit({
                  'keyType': _keyOptions[_keySelection.index],
                  'cryptoType': _advanceOptions.type ?? AccountAdvanceOptionParams.encryptTypeSR,
                  'derivePath': _advanceOptions.path ?? '',
                  'finish': null, // TODO chrigi check obsolete code KeyStoreJson
                });
              }
            },
          ),
        ),
      ],
    );
  }
}

enum KeySelection {
  MNEMONIC,
  RAW_SEED,
}
