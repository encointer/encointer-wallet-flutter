import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/account/logic/new_account_store.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/presentation/secure_account/views/secure_instructions_view.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/bullet_points_list_with_title.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecureYourAccountView extends StatelessWidget {
  SecureYourAccountView({super.key});

  static const route = 'secure-your-account';

  final List<String> _texts = [
    'When you change your smartphone.',
    'When your smartphone is lost.',
    'If you forget your pin.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure your account'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const SecureAccountTitle(
                  title: 'Secure your account with a secret recovery phrase',
                ),
                const SizedBox(height: 20),
                Text(
                  'To avoid risking your credit, be sure to protect your account by keeping your secret recovery phrase in a safe place.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'The recovery phrase is the only way to recover your wallet.',
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                BulletPointsListWithTitle(
                  title: 'Examples of when you need your recovery phrase',
                  texts: _texts,
                  textStyle: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                onPressed: () => _proceedWithoutSaving(context),
                child: const Text('Proceed without saving. (Not recommended)'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 60,
                  top: 10,
                ),
                child: PrimaryButton(
                  onPressed: () => _onButtonClicked(context),
                  child: Text(
                    'Start',
                    style: context.textTheme.displaySmall!.copyWith(
                      color: context.colorScheme.background,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _proceedWithoutSaving(BuildContext context) {
    Navigator.pushNamed(
      context,
      CommunityChooserOnMap.route,
      arguments: const CommunityChooserOnMapArgs(isFirstTime: true),
    );
  }

  void _onButtonClicked(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext _) => Provider.value(
          value: context.read<NewAccountStore>(),
          child: SecureInstructionsView(),
        ),
      ),
    );
  }
}
