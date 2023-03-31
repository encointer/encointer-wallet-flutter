import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/common/components/secondary_button_wide.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/design_kit/buttons/primary_button.dart';
import 'package:encointer_wallet/extras/utils/input_validation.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/presentation/account/stores/new_account_store.dart';
import 'package:encointer_wallet/presentation/account/ui/mixins/handle_new_account_result_mixin.dart';
import 'package:encointer_wallet/presentation/account/ui/views/import_account_view.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

class AddAcccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  AddAcccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final newAccountStore = sl<NewAccountStore>();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;

    return ScrollableForm(formKey: _formKey, listViewChildren: [
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
          return InputValidation.validateAccountName(context, v, sl<AppStore>().account.accountList);
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
              builder: (BuildContext _) => const ImportAccountView(),
            ),
          );
        },
      ),
      const SizedBox(height: 10),
      PrimaryButton(
        key: const Key('create-account-confirm'),
        onPressed: () async {
          final appStore = sl<AppStore>();
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
              if (newAccountStore.loading) {
                return const CenteredActivityIndicator();
              } else {
                return Text(dic.home.create);
              }
            }),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ]);
  }
}
