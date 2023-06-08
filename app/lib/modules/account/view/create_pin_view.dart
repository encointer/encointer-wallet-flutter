import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/form/scrollable_form.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class CreatePinView extends StatelessWidget {
  const CreatePinView({super.key, this.fromImportPage = false});

  final bool fromImportPage;

  static const String route = '/account/createPin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.create),
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
    final dic = context.l10n;
    final newAccountStore = context.watch<NewAccountStore>();
    return ScrollableForm(
      formKey: _formKey,
      listViewChildren: [
        const SizedBox(height: 80),
        Center(
          child: Text(
            dic.pinSecure,
            style: context.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          dic.pinHint,
          textAlign: TextAlign.center,
          style: context.textTheme.displayMedium!.copyWith(color: AppColors.encointerBlack),
        ),
        const SizedBox(height: 30),
        EncointerTextFormField(
          key: const Key('create-account-pin'),
          keyboardType: TextInputType.number,
          filled: true,
          obscureText: true,
          fillColor: context.colorScheme.background,
          hintText: dic.createPassword,
          labelText: dic.createPassword,
          controller: _passCtrl,
          borderRadius: 15,
          validator: (v) => Fmt.checkPassword(v!.trim()) ? null : dic.createPasswordError,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 20),
        EncointerTextFormField(
          key: const Key('create-account-pin2'),
          keyboardType: TextInputType.number,
          filled: true,
          fillColor: context.colorScheme.background,
          hintText: dic.createPassword2,
          labelText: dic.createPassword2,
          controller: _pass2Ctrl,
          borderRadius: 15,
          obscureText: true,
          validator: (v) => _passCtrl.text != v ? dic.createPassword2Error : null,
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
            final newAccount = context.read<NewAccountStore>();
            final appStore = context.read<AppStore>();
            if (_formKey.currentState!.validate() && !newAccount.loading) {
              newAccount.setPassword(_passCtrl.text.trim());
              final res = fromImportPage
                  ? await newAccount.importAccount(appStore, webApi)
                  : await newAccount.generateAccount(appStore, webApi);
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
              return Text(dic.next);
            }
          }),
        ),
      ],
    );
  }

  Future<void> _onOk(BuildContext context) async {
    final appStore = context.read<AppStore>();
    if (appStore.encointer.communityIdentifiers.length == 1) {
      await appStore.encointer.setChosenCid(appStore.encointer.communityIdentifiers[0]);
      if (RepositoryProvider.of<AppSettings>(context).developerMode) {
        context.read<AppSettings>().changeTheme(appStore.encointer.community?.cid.toFmtString());
      }
    } else {
      await Navigator.pushNamed(context, CommunityChooserOnMap.route);
    }
    await Navigator.pushNamedAndRemoveUntil<void>(context, EncointerHomePage.route, (route) => false);
  }
}
