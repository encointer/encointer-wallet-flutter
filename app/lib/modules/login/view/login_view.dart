import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/login/logic/login_store.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const route = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final appStore = context.read<AppStore>();
      if (appStore.settings.cachedPin.isEmpty) {
        await AppAlert.showPasswordInputDialog(context: context, account: appStore.account.currentAccount);
      }
      await useLocalAuth();
    });
    super.initState();
  }

  Future<void> useLocalAuth() async {
    final dic = I18n.of(context)!.translationsForLocale();
    final loginStore = context.read<LoginStore>();
    if (await loginStore.isDeviceSupported()) {
      final value = await context.read<LoginStore>().authenticate(dic.account.localizedReason);
      if (value) await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
    } else {
      RootSnackBar.showMsg(dic.account.biometricError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LoginStore>();
    final appStore = context.watch<AppStore>();
    final cachedPin = appStore.settings.cachedPin;
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encointer'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${dic.account.welcome} ${appStore.account.currentAccount.name}',
                style: textTheme.displaySmall,
              ),
              Observer(builder: (_) {
                return PinDots(store.pincode.length, maxLength: appStore.settings.cachedPin.length);
              }),
              const SizedBox(height: 5),
              PinKeyboard(
                useLocalAuth: useLocalAuth,
                onTapDigit: (value) => context.read<LoginStore>().addPinCode(value, cachedPin.length),
                removeLastDigit: context.read<LoginStore>().removeLastDigit,
              ),
              const LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LoginStore>();
    final appStore = context.watch<AppStore>();
    final dic = I18n.of(context)!.translationsForLocale();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PrimaryButton(
        onPressed: () async {
          if (appStore.settings.cachedPin.isEmpty) {
            await AppAlert.showPasswordInputDialog(context: context, account: appStore.account.currentAccount);
          }
          final value = context.read<LoginStore>().checkPinCode(appStore.settings.cachedPin);
          if (value) {
            await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
          } else {
            RootSnackBar.showMsg(dic.account.passwordError);
          }
        },
        child: !store.isLoading ? Text(dic.account.signIn) : const CupertinoActivityIndicator(),
      ),
    );
  }
}
