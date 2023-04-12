import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';
import 'package:encointer_wallet/store/app.dart';
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
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async => context.read<LoginStore>().useBiometricAuth(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final loginStore = context.watch<LoginStore>();
    final appStore = context.watch<AppStore>();
    final cachedPin = appStore.settings.cachedPin;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encointer'),
      ),
      body: SingleChildScrollView(
        child: ReactionBuilder(
          builder: (BuildContext context) {
            return reaction<bool>((r) => loginStore.pincode.length == cachedPin.length, (v) {
              if (v) context.read<LoginStore>().useBiometricAuth(context);
            });
          },
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
                  return PinDots(loginStore.pincode.length, maxLength: appStore.settings.cachedPin.length);
                }),
                const SizedBox(height: 5),
                PinKeyboard(
                  onTapDigit: (value) => context.read<LoginStore>().addPinCode(value, cachedPin.length),
                  removeLastDigit: context.read<LoginStore>().removeLastDigit,
                ),
                LoginButton(onPressed: () => context.read<LoginStore>().usePincodeAuth(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PrimaryButton(
        onPressed: onPressed,
        child: Text(dic.account.signIn),
      ),
    );
  }
}
