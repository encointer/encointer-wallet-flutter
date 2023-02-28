import 'package:encointer_wallet/common/components/button/custom_button.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/form_scrollable.dart';
import 'package:encointer_wallet/common/components/loading/progressing_inducator.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key, required this.addAccount});
  final bool addAccount;

  static const String route = '/account/createAccount';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(addAccount ? dic.profile.addAccount : dic.home.create),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Provider(
          create: (context) => AccountCreate(),
          child: CreateAcccountForm(addAccount: addAccount),
        ),
      ),
    );
  }
}

class CreateAcccountForm extends StatelessWidget {
  CreateAcccountForm({super.key, required this.addAccount});
  final bool addAccount;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final store = context.watch<AccountCreate>();
    return FormScrollable(
      formKey: _formKey,
      listViewChildren: [
        const SizedBox(height: 80),
        Center(
          child: Text(
            dic.profile.accountNameChoose,
            style: textTheme.displayMedium,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            dic.profile.accountNameChooseHint,
            textAlign: TextAlign.center,
            style: textTheme.displayMedium!.copyWith(color: encointerBlack),
          ),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-name'),
          hintText: dic.account.createHint,
          labelText: dic.profile.accountName,
          controller: _nameCtrl,
          validator: (v) {
            return InputValidation.validateAccountName(context, v, context.read<AppStore>().account.optionalAccounts);
          },
        ),
        const SizedBox(height: 20),
      ],
      columnChildren: addAccount
          ? [
              const SizedBox(height: 10),
              CustomButtonWithIcon(
                key: const Key('import-account'),
                icon: const Icon(Iconsax.import_2),
                textStyle: textTheme.displaySmall,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext _) => Provider.value(
                        value: context.read<AccountCreate>(),
                        child: const ImportAccountView(),
                      ),
                    ),
                  );
                },
                backgroundColor: colorScheme.background,
                foregroundColor: colorScheme.primary,
                child: Text(dic.home.accountImport),
              ),
              const SizedBox(height: 10),
              Observer(builder: (_) {
                return CustomButtonWithIcon(
                  key: const Key('create-account-confirm'),
                  icon: const Icon(Iconsax.add_square),
                  textStyle: textTheme.displaySmall,
                  onPressed: !store.loading
                      ? () async {
                          final store = context.read<AccountCreate>();
                          final appStore = context.read<AppStore>();
                          store.setName(_nameCtrl.text.trim());
                          final res = await store.generateAccount(appStore, webApi);
                          await _navigate(context, res);
                        }
                      : null,
                  child: !store.loading ? Text(dic.profile.accountCreate) : const ProgressingIndicator(),
                );
              }),
              const SizedBox(height: 20),
            ]
          : [
              const SizedBox(height: 10),
              CustomButtonWithIcon(
                key: const Key('create-account-next'),
                icon: const Icon(Iconsax.login_1),
                textStyle: textTheme.displaySmall,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final store = context.read<AccountCreate>()..setName(_nameCtrl.text.trim());
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext _) => Provider.value(
                          value: store,
                          child: const CreatePinView(),
                        ),
                      ),
                    );
                  }
                },
                child: Text(dic.account.next),
              ),
              const SizedBox(height: 20),
            ],
    );
  }

  Future<void> _navigate(BuildContext context, AddAccountResponse type) async {
    switch (type) {
      case AddAccountResponse.success:
        Navigator.of(context).pop();
        break;
      case AddAccountResponse.fail:
        final dic = I18n.of(context)!.translationsForLocale();
        AppAlert.showErrorDailog(context, errorText: dic.account.createError, buttontext: dic.home.ok);
        break;
      case AddAccountResponse.passwordEmpty:
        final appStore = context.read<AppStore>();
        await AppAlert.showInputPasswordDailog(context: context, account: appStore.account.currentAccount);
        break;
      case AddAccountResponse.duplicate:
        break;
    }
  }
}
