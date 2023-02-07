import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/login/logic/login_store.dart';
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

class PinKeyboard extends StatelessWidget {
  const PinKeyboard({super.key, required this.useLocalAuth});
  final VoidCallback useLocalAuth;

  @override
  Widget build(BuildContext context) {
    return CustomGridViewCount(
      children: List.generate(9, (i) {
        return CircleButton(
          child: Text('${i + 1}'),
          onPressed: () => context.read<LoginStore>().addPin(i + 1),
        );
      })
        ..addAll(
          [
            CircleButton(
              onPressed: useLocalAuth,
              child: const Icon(Icons.fingerprint),
            ),
            CircleButton(
              child: const Text('0'),
              onPressed: () => context.read<LoginStore>().addPin(0),
            ),
            CircleButton(
              onPressed: context.read<LoginStore>().removeLast,
              child: const Icon(Icons.backspace),
            ),
          ],
        ),
    );
  }
}

class CustomGridViewCount extends StatelessWidget {
  const CustomGridViewCount({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      children: children,
    );
  }
}

class PinDots extends StatelessWidget {
  const PinDots(
    this.itemLength, {
    super.key,
    this.maxLengt = 4,
  });

  final int itemLength;
  final int maxLengt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 30,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(maxLengt, (i) {
          final active = itemLength > i;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: CircleAvatar(
                radius: active ? 8 : 5,
                backgroundColor: active ? colorScheme.secondaryContainer : colorScheme.background,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.onPressed,
    this.child,
  });

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
          backgroundColor: colorScheme.background,
          shadowColor: Colors.black,
          elevation: 3,
          textStyle: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 34),
        ),
        child: child,
      ),
    );
  }
}
