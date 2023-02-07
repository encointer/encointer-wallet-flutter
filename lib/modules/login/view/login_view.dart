import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/login/logic/login_store.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const route = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    useLocalAuth();
  }

  Future<void> useLocalAuth() async {
    if (await context.read<LoginStore>().isDeviceSupported()) {
      final value = await context.read<LoginStore>().authinticate();
      if (value) Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
    } else {
      RootSnackBar.showMsg('It is device s not support local auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LoginStore>();
    final appStore = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encointer Wallet'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Wellcome ${appStore.account.currentAccount.name}'),
          Observer(builder: (_) {
            return PinDots(store.pincode.length, maxLengt: store.pincode.length < 4 ? 4 : store.pincode.length);
          }),
          const SizedBox(height: 10),
          PinKeyboard(useLocalAuth: useLocalAuth),
          const LoginButton(),
        ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Observer(builder: (_) {
        return PrimaryButton(
          onPressed: store.pincode.length >= 4 && !store.isLoading
              ? () async {
                  final value = await context.read<LoginStore>().checkAccountPassword(appStore.account.currentAccount);
                  if (value) {
                    Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
                  } else {
                    RootSnackBar.showMsg('It is device s not support local auth');
                  }
                }
              : null,
          child: !store.isLoading ? const Text('Login') : const CupertinoActivityIndicator(),
        );
      }),
    );
  }
}
