import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/design_kit/buttons/primary_button.dart';
import 'package:encointer_wallet/design_kit/colors/app_colors_config.dart';
import 'package:encointer_wallet/extras/utils/format.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/presentation/account/stores/new_account_store.dart';
import 'package:encointer_wallet/presentation/account/ui/widgets/pin_info.dart';
import 'package:encointer_wallet/presentation/home/ui/views/home_view.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:encointer_wallet/presentation/account/ui/mixins/handle_new_account_result_mixin.dart';

class CreatePinForm extends StatelessWidget with HandleNewAccountResultMixin {
  CreatePinForm({super.key, required this.fromImportPage});

  final bool fromImportPage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _pass2Ctrl = TextEditingController();

  final newAccountStore = sl<NewAccountStore>();

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
            dic.profile.pinSecure,
            style: textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          dic.profile.pinHint,
          textAlign: TextAlign.center,
          style: textTheme.displayMedium!.copyWith(color: appColors.encointerBlack),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-pin'),
          keyboardType: TextInputType.number,
          filled: true,
          obscureText: true,
          fillColor: appColors.zurichLion.shade50,
          hintText: dic.account.createPassword,
          labelText: dic.account.createPassword,
          controller: _passCtrl,
          borderRadius: 15,
          validator: (v) => Fmt.checkPassword(v!.trim()) ? null : dic.account.createPasswordError,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 20),
        EncointerTextFormField(
          key: const Key('create-account-pin2'),
          keyboardType: TextInputType.number,
          filled: true,
          fillColor: const Color(0xffF4F8F9),
          hintText: dic.account.createPassword2,
          labelText: dic.account.createPassword2,
          controller: _pass2Ctrl,
          borderRadius: 15,
          obscureText: true,
          validator: (v) => _passCtrl.text != v ? dic.account.createPassword2Error : null,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        const PinInfo(),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        PrimaryButton(
          key: const Key('create-account-confirm'),
          onPressed: () async {
            final appStore = sl<AppStore>();
            if (_formKey.currentState!.validate() && !newAccountStore.loading) {
              newAccountStore.setPassword(_passCtrl.text.trim());
              final res = fromImportPage
                  ? await newAccountStore.importAccount(appStore, webApi)
                  : await newAccountStore.generateAccount(appStore, webApi);
              await navigate(
                context: context,
                type: res.operationResult,
                onOk: () => _onOk(context),
              );
            }
          },
          child: Observer(builder: (_) {
            if (newAccountStore.loading) {
              return const CenteredActivityIndicator();
            } else {
              return Text(dic.home.next);
            }
          }),
        ),
      ],
    );
  }

  Future<void> _onOk(BuildContext context) async {
    final appStore = sl<AppStore>();
    if (appStore.encointer.communityIdentifiers.length == 1) {
      await appStore.encointer.setChosenCid(appStore.encointer.communityIdentifiers[0]);
    } else {
      await Navigator.pushNamed(context, CommunityChooserOnMap.route);
    }
    await Navigator.pushNamedAndRemoveUntil<void>(context, HomeView.route, (route) => false);
  }
}
