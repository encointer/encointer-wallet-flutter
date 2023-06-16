import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/common/components/buttons/circle_button.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';
import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/service/auth/local_auth_service.dart';
import 'package:encointer_wallet/presentation/home/views/home_page.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/utils.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/l10n/l10.dart';

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
      if (context.read<AppSettings>().biometricAuthState == BiometricAuthState.enabled) {
        final localAuthService = RepositoryProvider.of<LocalAuthService>(context);
        final value = await localAuthService.localAuthenticate(context.l10n.localizedReason);
        await navigate(isPinCorrect: value, l10n: context.l10n);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginStore = context.watch<LoginStore>();
    final appStore = context.watch<AppStore>();
    final cachedPin = appStore.settings.cachedPin;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text('${context.l10n.welcome} ${appStore.account.currentAccount.name}'),
      ),
      body: SingleChildScrollView(
        child: ReactionBuilder(
          builder: (BuildContext context) {
            return reaction<bool>((r) => loginStore.pinCode.length == cachedPin.length, (v) async {
              if (v) {
                final value = context.read<LoginStore>().usePincodeAuth(context);
                await navigate(isPinCorrect: value, l10n: l10n);
              }
            });
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Observer(builder: (_) {
                  return PinDots(loginStore.pinCode.length, maxLength: cachedPin.length);
                }),
                PinKeyboard(
                  onTapDigit: (value) => context.read<LoginStore>().addDigit(value, cachedPin.length),
                  removeLastDigit: context.read<LoginStore>().removeLastDigit,
                  biometricWidget: Observer(builder: (_) {
                    return switch (context.read<AppSettings>().biometricAuthState) {
                      BiometricAuthState.enabled => CircleButton(
                          child: const Icon(Icons.fingerprint),
                          onPressed: () async {
                            final value = await RepositoryProvider.of<LocalAuthService>(context)
                                .localAuthenticate(context.l10n.localizedReason);
                            await navigate(isPinCorrect: value, l10n: context.l10n);
                          },
                        ),
                      _ => const SizedBox.shrink(),
                    };
                  }),
                ),
                LoginButton(onPressed: () async {
                  final value = context.read<LoginStore>().usePincodeAuth(context);
                  await navigate(isPinCorrect: value, l10n: l10n);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> navigate({required bool isPinCorrect, required AppLocalizations l10n}) async {
    if (isPinCorrect) {
      await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
    } else {
      RootSnackBar.showMsg(l10n.pinError);
    }
  }
}
