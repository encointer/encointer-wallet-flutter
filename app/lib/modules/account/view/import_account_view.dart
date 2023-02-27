import 'package:encointer_wallet/common/components/button/custom_button.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/form_scrollable.dart';
import 'package:encointer_wallet/common/components/loading/progressing_inducator.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportAccountView extends StatelessWidget {
  const ImportAccountView({super.key});

  static const String route = '/account/import';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.accountImport),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ImportAccountForm(),
      ),
    );
  }
}

class ImportAccountForm extends StatelessWidget {
  ImportAccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keyCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    final store = context.watch<AccountCreate>();
    return FormScrollable(
      formKey: _formKey,
      listViewChildren: [
        const SizedBox(height: 50),
        Text(
          dic.profile.detailsEnter,
          textAlign: TextAlign.center,
          style: textTheme.displayMedium,
        ),
        const SizedBox(height: 10),
        Text(
          dic.profile.personalKeyEnter,
          textAlign: TextAlign.center,
          style: textTheme.displayMedium!.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-name'),
          hintText: dic.account.createHint,
          labelText: I18n.of(context)!.translationsForLocale().profile.accountName,
          controller: _nameCtrl,
          validator: (v) =>
              InputValidation.validateAccountName(context, v, context.read<AppStore>().account.optionalAccounts),
        ),
        TextFormField(
          key: const Key('account-source'),
          decoration: InputDecoration(
            hintText: dic.account.mnemonic,
            labelText: dic.profile.personalKey,
          ),
          controller: _keyCtrl,
          maxLines: 2,
          validator: (String? value) => context.read<AccountCreate>().validateAccount(dic, value?.trim() ?? ''),
        ),
        const SizedBox(height: 20),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        CustomButton(
          key: const Key('account-import-next'),
          onPressed: !store.loading
              ? () async {
                  if (_formKey.currentState!.validate()) {
                    // widget.onSubmit({
                    //   'keyType': _keyType,
                    //   'cryptoType': _advanceOptions.type ?? AccountAdvanceOptionParams.encryptTypeSR,
                    //   'derivePath': _advanceOptions.path ?? '',
                    // });
                  }
                }
              : null,
          child: !store.loading ? Text(dic.home.next) : const ProgressingIndicator(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
