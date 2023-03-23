import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/design_kit/buttons/primary_button.dart';
import 'package:encointer_wallet/design_kit/colors/app_colors_config.dart';
import 'package:encointer_wallet/extras/utils/input_validation.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/presentation/account/stores/new_account_store.dart';
import 'package:encointer_wallet/presentation/account/ui/views/create_pin_view.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/presentation/account/ui/mixins/handle_new_account_result_mixin.dart';
import 'package:iconsax/iconsax.dart';

class CreateAcccountForm extends StatelessWidget with HandleNewAccountResultMixin {
  CreateAcccountForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  final _newAccountStore = sl<NewAccountStore>();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    return ScrollableForm(
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
            style: textTheme.displayMedium!.copyWith(color: appColors.encointerBlack),
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
      ],
      columnChildren: [
        const SizedBox(height: 10),
        PrimaryButton(
          key: const Key('create-account-next'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _newAccountStore.setName(_nameCtrl.text.trim());
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext _) => const CreatePinView(),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.login_1),
              const SizedBox(width: 12),
              Text(
                dic.account.next,
                style: textTheme.displaySmall!.copyWith(color: appColors.zurichLion.shade50),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
