import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/design_kit/buttons/primary_button.dart';
import 'package:encointer_wallet/extras/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/extras/utils/format.dart';
import 'package:encointer_wallet/extras/utils/input_validation.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/presentation/account/stores/new_account_store.dart';
import 'package:encointer_wallet/presentation/account/ui/views/create_pin_view.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/presentation/account/ui/mixins/handle_new_account_result_mixin.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ImportAccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  ImportAccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _keyCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  final newAccountStore = sl<NewAccountStore>();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;

    final appStore = sl<AppStore>();
    return ScrollableForm(
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
          validator: (v) {
            return InputValidation.validateAccountName(context, v, sl<AppStore>().account.accountList);
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
          validator: (String? value) => newAccountStore.validateAccount(dic, value?.trim() ?? ''),
        ),
        const SizedBox(height: 20),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        PrimaryButton(
          key: const Key('account-import-next'),
          onPressed: () async {
            final appStore = sl<AppStore>();
            if (_formKey.currentState!.validate() && !newAccountStore.loading) {
              newAccountStore
                ..setName(_nameCtrl.text.trim())
                ..setKey(_keyCtrl.text.trim());
              if (appStore.account.isFirstAccount) {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext _) => const CreatePinView(fromImportPage: true),
                  ),
                );
              } else {
                final res = await newAccountStore.importAccount(appStore, webApi);
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
            final appStore = sl<AppStore>();
            await newAccountStore.saveAccount(webApi, appStore, acc, appStore.settings.cachedPin);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );
  }
}
