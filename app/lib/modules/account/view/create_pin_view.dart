import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/button/custom_button.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/form_scrollable.dart';
import 'package:encointer_wallet/common/components/loading/progressing_inducator.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/modules/account/account.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key, this.fromImportPage = false});

  final bool fromImportPage;

  static const String route = '/account/createPin';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.home.create),
        actions: const [CloseButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: CreatePinForm(fromImportPage: fromImportPage),
      ),
    );
  }
}

class CreatePinForm extends StatelessWidget with HandleNewAccountResultMixin {
  CreatePinForm({super.key, required this.fromImportPage});

  final bool fromImportPage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _pass2Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    final newAccountStore = context.watch<NewAccountStore>();

    return FormScrollable(
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
          style: textTheme.displayMedium!.copyWith(color: encointerBlack),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-pin'),
          keyboardType: TextInputType.number,
          filled: true,
          obscureText: true,
          fillColor: zurichLion.shade50,
          hintText: dic.account.createPassword,
          labelText: dic.account.createPassword,
          controller: _passCtrl,
          borderRadius: 15,
          validator: (v) => Fmt.checkPassword(v!.trim()) ? null : dic.account.createPasswordError,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        const PinInfo(),
      ],
      columnChildren: [
        const SizedBox(height: 10),
        Observer(builder: (_) {
          return CustomButton(
            key: const Key('create-account-confirm'),
            textStyle: textTheme.displaySmall!.copyWith(color: zurichLion.shade50),
            onPressed: newAccountStore.loading
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      final store = context.read<NewAccountStore>();
                      final appStore = context.read<AppStore>();
                      store.setPassword(_passCtrl.text.trim());
                      final res = fromImportPage
                          ? await store.importAccount(appStore, webApi)
                          : await store.generateAccount(appStore, webApi);
                      await navigate(
                        context: context,
                        type: res,
                        success: () => _success(context),
                      );
                    }
                  },
            child: newAccountStore.loading ? const ProgressingIndicator() : Text(dic.account.create),
          );
        }),
      ],
    );
  }

  Future<void> _success(BuildContext context) async {
    final appStore = context.read<AppStore>();
    if (appStore.encointer.communityIdentifiers.length == 1) {
      await appStore.encointer.setChosenCid(appStore.encointer.communityIdentifiers[0]);
    } else {
      await Navigator.pushNamed(context, CommunityChooserOnMap.route);
    }
    await Navigator.pushNamedAndRemoveUntil<void>(context, EncointerHomePage.route, (route) => false);
  }
}
