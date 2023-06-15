import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/account/logic/new_account_store.dart';
import 'package:encointer_wallet/presentation/secure_account/views/secure_your_account_view.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCreatedView extends StatelessWidget {
  const AccountCreatedView({super.key});

  static const route = 'account-created';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account created'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 68, bottom: 51),
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    size: 87,
                    color: Colors.green,
                  ),
                ),
                const SecureAccountTitle(
                  title: 'Your account has been successfully created!',
                ),
                const SizedBox(height: 20),
                Text(
                  'Secure your account now with a secret recovery phrase to ensure you don\'t lose access to your account.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 60,
            ),
            child: PrimaryButton(
              onPressed: () => _onButtonClicked(context),
              child: Text(
                'Secure your account',
                style: context.textTheme.displaySmall!.copyWith(
                  color: context.colorScheme.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onButtonClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext _) => Provider.value(
          value: context.read<NewAccountStore>(),
          child: SecureYourAccountView(),
        ),
      ),
    );
  }
}
