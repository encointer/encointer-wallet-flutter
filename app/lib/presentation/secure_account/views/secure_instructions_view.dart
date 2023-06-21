import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/modules/account/logic/new_account_store.dart';
import 'package:encointer_wallet/presentation/secure_account/views/keep_your_phrase_safe_view.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/bullet_points_list_with_title.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecureInstructionsView extends StatelessWidget {
  const SecureInstructionsView({super.key});

  static const route = 'secure-instructions';

  List<String> _getRisks(BuildContext context) {
    return [
      context.l10n.lossOfRecoveryPhrase,
      context.l10n.forgettingStorageLocation,
      context.l10n.unauthorizedAccessByThirdParties,
    ];
  }

  List<String> _getTips(BuildContext context) {
    return [
      context.l10n.chooseSafeAndReliableStorageMethod,
      context.l10n.writeDownStorageLocationsInSafePlace,
      context.l10n.neverShareRecoveryPhraseWithOthers,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.instructions),
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
                SecureAccountTitle(title: context.l10n.instructions),
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
                        context.l10n.writeYourSecretPhraseOnPaperOrChooseSafeOption,
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
                        context.l10n.keepRecordingInSafePlace,
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
                  texts: _getRisks(context),
                  title: context.l10n.risks,
                ),
                BulletPointsListWithTitle(
                  texts: _getTips(context),
                  title: context.l10n.tips,
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
                context.l10n.showRecoveryphrase,
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
