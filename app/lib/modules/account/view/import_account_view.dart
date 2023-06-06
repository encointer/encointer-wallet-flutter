import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

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

class ImportAccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  ImportAccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keyCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final newAccountStore = context.watch<NewAccountStore>();
    final appStore = context.watch<AppStore>();
    return ScrollableForm(
      formKey: _formKey,
      listViewChildren: [
        const SizedBox(height: 50),
        Text(
          dic.profile.detailsEnter,
          textAlign: TextAlign.center,
          style: context.textTheme.displayMedium,
        ),
        const SizedBox(height: 10),
        Text(
          dic.profile.personalKeyEnter,
          textAlign: TextAlign.center,
          style: context.textTheme.displayMedium!.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-name'),
          hintText: dic.account.createHint,
          labelText: I18n.of(context)!.translationsForLocale().profile.accountName,
          controller: _nameCtrl,
          validator: (v) {
            return InputValidation.validateAccountName(context, v, context.read<AppStore>().account.accountList);
          },
        ),
        TextFormField(
          key: const Key('account-source'),
          decoration: InputDecoration(
            hintText: dic.account.mnemonic,
            labelText: dic.profile.personalKey,
          ),
          controller: _keyCtrl,
          maxLines: 2,
          validator: (String? value) => context.read<NewAccountStore>().validateAccount(dic, value?.trim() ?? ''),
        ),
        const SizedBox(height: 20),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        PrimaryButton(
          key: const Key('account-import-next'),
          onPressed: () async {
            final newAccount = context.read<NewAccountStore>();
            final appStore = context.read<AppStore>();
            if (_formKey.currentState!.validate() && !newAccount.loading) {
              newAccount
                ..setName(_nameCtrl.text.trim())
                ..setKey(_keyCtrl.text.trim());
              if (appStore.account.isFirstAccount) {
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
                final res = await newAccount.importAccount(appStore, webApi);
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
              return Text(appStore.account.accountList.isEmpty ? dic.home.next : dic.home.accountImport);
            }
          }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> _onDuplicateAccount(BuildContext context, Map<String, dynamic> acc) async {
    final dic = I18n.of(context)!.translationsForLocale();
    await AppAlert.showDialog<void>(
      context,
      title: Text(Fmt.address(acc['address'] as String)!),
      content: Text(dic.account.importDuplicate),
      actions: [
        CupertinoButton(
          child: Text(dic.home.cancel),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        CupertinoButton(
          child: Text(dic.home.ok),
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
