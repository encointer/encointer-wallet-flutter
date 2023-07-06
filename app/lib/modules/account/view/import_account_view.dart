import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/validate_keys.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ImportAccountView extends StatelessWidget {
  const ImportAccountView({super.key});

  static const String route = '/account/import';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.accountImport),
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

class ImportAccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  ImportAccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keyCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final newAccountStore = context.watch<NewAccountStore>();
    final appStore = context.watch<AppStore>();
    return ScrollableForm(
      formKey: _formKey,
      listViewChildren: [
        const SizedBox(height: 50),
        Text(
          l10n.detailsEnter,
          textAlign: TextAlign.center,
          style: context.headlineSmall,
        ),
        const SizedBox(height: 10),
        Text(
          l10n.personalKeyEnter,
          textAlign: TextAlign.center,
          style: context.headlineSmall.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-name'),
          hintText: l10n.createHint,
          labelText: context.l10n.accountName,
          controller: _nameCtrl,
          validator: (v) {
            return InputValidation.validateAccountName(context, v, context.read<AppStore>().account.accountList);
          },
        ),
        TextFormField(
          key: const Key('account-source'),
          decoration: InputDecoration(
            hintText: l10n.mnemonic,
            labelText: l10n.personalKey,
          ),
          controller: _keyCtrl,
          maxLines: 2,
          validator: (String? value) {
            if (value == null || value.isEmpty) return l10n.importMustNotBeEmpty;
            if (ValidateKeys.isRawSeed(value)) {
              context.read<NewAccountStore>().setKeyType(KeyType.rawSeed);
              return ValidateKeys.validateRawSeed(value) ? null : l10n.importInvalidRawSeed;
            } else if (ValidateKeys.isPrivateKey(value)) {
              return l10n.importPrivateKeyUnsupported;
            } else {
              context.read<NewAccountStore>().setKeyType(KeyType.mnemonic);
              return ValidateKeys.validateMnemonic(value) ? null : l10n.importInvalidMnemonic;
            }
          },
        ),
        const SizedBox(height: 20),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        PrimaryButton(
          key: const Key('account-import-next'),
          onPressed: () async {
            final newAccount = context.read<NewAccountStore>();
            if (_formKey.currentState!.validate() && !newAccount.loading) {
              newAccount
                ..setName(_nameCtrl.text.trim())
                ..setKey(_keyCtrl.text.trim());
              if (context.read<AppStore>().account.isFirstAccount) {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext _) => Provider.value(
                      value: newAccount,
                      child: const CreatePinView(fromImportPage: true),
                    ),
                  ),
                );
              } else {
                final res = await newAccount.importAccount(context, webApi);
                await navigate(
                  context: context,
                  type: res.operationResult,
                  onOk: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  onDuplicateAccount: () => _onDuplicateAccount(context, res.duplicateAccountData),
                );
              }
            }
          },
          child: Observer(builder: (_) {
            if (newAccountStore.loading) {
              return const CenteredActivityIndicator();
            } else {
              return Text(appStore.account.accountList.isEmpty ? l10n.next : l10n.accountImport);
            }
          }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _onDuplicateAccount(BuildContext context, Map<String, dynamic> acc) async {
    final l10n = context.l10n;
    await AppAlert.showDialog<void>(
      context,
      title: Text(Fmt.address(acc['address'] as String)!),
      content: Text(l10n.importDuplicate),
      actions: [
        CupertinoButton(
          child: Text(l10n.cancel),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        CupertinoButton(
          child: Text(l10n.ok),
          onPressed: () async {
            final appStore = context.read<AppStore>();
            await context.read<NewAccountStore>().saveAccount(webApi, appStore, acc, appStore.settings.cachedPin);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
