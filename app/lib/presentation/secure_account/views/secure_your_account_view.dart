import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/modules/account/logic/new_account_store.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/presentation/secure_account/views/secure_instructions_view.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/bullet_points_list_with_title.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecureYourAccountView extends StatelessWidget {
  const SecureYourAccountView({super.key});

  static const route = 'secure-your-account';
  List<String> _getTexts(BuildContext context) {
    return [
      context.l10n.whenYouChangeYourPhone,
      context.l10n.whenYourPhoneIsLost,
      context.l10n.ifYouForgetYourPin,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.secureYourAccount),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                const SizedBox(height: 40),
                SecureAccountTitle(
                  title: context.l10n.secureYourAccountWithSecretRecoveryPhrase,
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.toAvoidRiskingYourCreditBeSureToProtectBySecretPhrase,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.recoveryPhraseIsTheOnlyWayToRecoverYourWallet,
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                BulletPointsListWithTitle(
                  title: context.l10n.examplesOfWhenYouNeedYourRecoveryPhrase,
                  texts: _getTexts(context),
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
                child: Text(context.l10n.proceedWithoutsavingNotRecommended),
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
                    context.l10n.start,
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
