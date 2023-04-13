import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/common/components/buttons/circle_button.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final loginStore = context.read<LoginStore>();
      await loginStore.isDeviceSupported();
      await loginStore.useBiometricAuth(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final loginStore = context.watch<LoginStore>();
    final appStore = context.watch<AppStore>();
    final cachedPin = appStore.settings.cachedPin;
    return Scaffold(
      appBar: AppBar(
        title: Text('${dic.account.welcome} ${appStore.account.currentAccount.name}'),
      ),
      body: SingleChildScrollView(
        child: ReactionBuilder(
          builder: (BuildContext context) {
            return reaction<bool>((r) => loginStore.pincode.length == cachedPin.length, (v) {
              if (v) context.read<LoginStore>().usePincodeAuth(context);
            });
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Observer(builder: (_) {
                  return PinDots(loginStore.pincode.length, maxLength: cachedPin.length);
                }),
                PinKeyboard(
                  onTapDigit: (value) => context.read<LoginStore>().addDigit(value, cachedPin.length),
                  removeLastDigit: context.read<LoginStore>().removeLastDigit,
                  biometricWidget: Observer(builder: (_) {
                    if (loginStore.deviceSupportedBiometricAuth) {
                      return CircleButton(
                        child: const Icon(Icons.fingerprint),
                        onPressed: () => context.read<LoginStore>().useBiometricAuth(context),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
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
