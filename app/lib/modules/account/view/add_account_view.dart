import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/loading/progressing_inducator.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/components/form/form_scrollable.dart';
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
    final textTheme = Theme.of(context).textTheme;
    final newAccountStoreWatch = context.watch<NewAccountStore>();
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
      SecondaryButtonWide(
        key: const Key('import-account'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.import_2),
            const SizedBox(width: 10),
            Text(dic.home.accountImport, style: textTheme.displaySmall),
          ],
        ),
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
      ),
      const SizedBox(height: 10),
      PrimaryButton(
        key: const Key('create-account-confirm'),
        onPressed: () async {
          final newAccountStore = context.read<NewAccountStore>();
          final appStore = context.read<AppStore>();
          if (_formKey.currentState!.validate() && !newAccountStore.loading) {
            newAccountStore.setName(_nameCtrl.text.trim());
            final res = await newAccountStore.generateAccount(appStore, webApi);
            await navigate(
              context: context,
              type: res.operationResult,
              onOk: () => Navigator.of(context).popUntil((route) => route.isFirst),
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.add_square),
            const SizedBox(width: 12),
            Observer(builder: (_) {
              if (newAccountStoreWatch.loading) {
                return const ProgressingIndicator();
              } else {
                return Text(dic.home.next);
              }
            }),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ]);
  }
}
