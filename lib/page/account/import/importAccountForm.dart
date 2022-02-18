import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
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

  String _validateInput(String v, Map<KeySelection, String> translationsByKeySelection) {
    bool passed = false;
    final Translations dic = I18n.of(context).translationsForLocale();
    String input = v.trim();
    switch (_keySelection) {
      case KeySelection.MNEMONIC:
        int len = input.split(' ').length;
        if (len == 12 || len == 24) {
          passed = true;
        }
        break;
      case KeySelection.RAW_SEED:
        if (input[0] == '/' && (input.length <= 32 || input.length == 66)) {
          passed = true;
        }
        print("we are here and input is: $input");
        break;
    }
    return passed ? null : '${dic.account.importInvalid} ${translationsByKeySelection[_keySelection]}'; // TODO armin
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _keyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    final Map<KeySelection, String> translationsByKeySelection = {
      KeySelection.MNEMONIC: dic.account.mnemonic,
      KeySelection.RAW_SEED: dic.account.rawSeed,
    };
    final Map<String, String> translationsByKeyOption = {
      _keyOptions[0]: dic.account.mnemonic,
      _keyOptions[1]: dic.account.rawSeed,
    };
    String selected = translationsByKeySelection[_keySelection];
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
                Center(
                  child: Text(I18n.of(context).translationsForLocale().profile.detailsEnter,
                      style: Theme.of(context).textTheme.headline2),
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
                  validator: (String value) => _validateInput(value, translationsByKeySelection),
                ),
                ListTile(
                  title: Text(I18n.of(context).translationsForLocale().home.accountImport),
                  subtitle: Text(selected),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (_) => Container(
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 56,
                          scrollController: FixedExtentScrollController(initialItem: _keySelection.index),
                          children: _keyOptions
                              .map((i) => Padding(
                                  padding: EdgeInsets.all(12), child: Text(translationsByKeyOption[i]))) // TODO armin
                              .toList(),
                          onSelectedItemChanged: (v) {
                            setState(() {
                              _keyCtrl.value = TextEditingValue(text: '');
                              _keySelection = KeySelection.values[v];
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                _keySelection != KeySelection.RAW_SEED
                    ? Padding(
                        key: Key('account-source'),
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: selected,
                            labelText: dic.profile.personalKey,
                          ),
                          controller: _keyCtrl,
                          maxLines: 2,
                          validator: (String value) => _validateInput(value, translationsByKeySelection),
                        ),
                      )
                    : Container(),
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
