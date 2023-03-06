import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/button/custom_button.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/form_scrollable.dart';
import 'package:encointer_wallet/common/components/loading/progressing_inducator.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/input_validation.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AddAccountView extends StatelessWidget {
  const AddAccountView({super.key});

  static const String route = '/account/addAccount';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.addAccount),
        leading: const SizedBox.shrink(),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Provider(
          create: (context) => NewAccountStore(),
          child: AddAcccountForm(),
        ),
      ),
    );
  }
}

class AddAcccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  AddAcccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final newAccountStore = context.watch<NewAccountStore>();
    return FormScrollable(formKey: _formKey, listViewChildren: [
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
    ], columnChildren: [
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
                value: context.read<NewAccountStore>(),
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
          onPressed: !newAccountStore.loading
              ? () async {
                  final store = context.read<NewAccountStore>();
                  final appStore = context.read<AppStore>();
                  store.setName(_nameCtrl.text.trim());
                  final res = await store.generateAccount(appStore, webApi);
                  await navigate(
                    context: context,
                    type: res.operationResult,
                    onOk: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  );
                }
              : null,
          child: !newAccountStore.loading ? Text(dic.profile.accountCreate) : const ProgressingIndicator(),
        );
      }),
      const SizedBox(height: 20),
    ]);
  }
}
