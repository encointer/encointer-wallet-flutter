import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/modules/account/logic/new_account_store.dart';
import 'package:encointer_wallet/presentation/secure_account/views/keep_your_phrase_safe_view.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/bullet_points_list_with_title.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecureInstructionsView extends StatelessWidget {
  SecureInstructionsView({super.key});

  static const route = 'secure-instructions';

  final List<String> _risks = [
    'Loss of recovery phrase',
    'Forgetting the storage location',
    'Forgetting the storage location',
  ];

  final List<String> _tips = [
    'Choose a safe and reliable storage method',
    'Write down the storage locations in a safe place in case you forget them',
    'Never share the recovery phrase with other people',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructions'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const SecureAccountTitle(title: 'Instructions'),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. ',
                      style: context.textTheme.labelLarge!.copyWith(
                        color: context.colorScheme.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Write your secret recovery phrase on a piece of paper or choose another safe storage option.',
                        style: context.textTheme.labelLarge!.copyWith(
                          color: context.colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '2. ',
                      style: context.textTheme.labelLarge!.copyWith(
                        color: context.colorScheme.onBackground,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Keep the recording in a safe place.',
                        style: context.textTheme.labelLarge!.copyWith(
                          color: context.colorScheme.onBackground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BulletPointsListWithTitle(
                  texts: _risks,
                  title: 'Risks',
                ),
                BulletPointsListWithTitle(
                  texts: _tips,
                  title: 'Tips',
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
                'Show recovery phrase',
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
          child: const KeepYourPhraseSafeView(),
        ),
      ),
    );
  }
}
