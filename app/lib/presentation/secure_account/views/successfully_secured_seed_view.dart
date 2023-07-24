import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SuccesfullySecuredSeedView extends StatelessWidget {
  const SuccesfullySecuredSeedView({super.key});

  static const route = 'succesfully-secured-seed';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                SecureAccountTitle(
                  title: context.l10n.congratulations,
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.youHaveSecuredYourAccountKeepYourSecretPhrase,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.youAreResponsibleForThis,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.pleaseNoteEncointerCannotRecoverYourAccount,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  context.l10n.youCanFindYourSecretPhraseInYourProfile,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                _exportTutorial(context),
              ],
            ),
          ),
          _button(context),
        ],
      ),
    );
  }

  Widget _exportTutorial(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            color: context.colorScheme.background,
            margin: const EdgeInsets.only(
              left: 100,
              top: 20,
              right: 15,
              bottom: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Iconsax.trash),
                  title: Text(context.l10n.delete.toUpperCase()),
                ),
                ListTile(
                  leading: const Icon(Iconsax.export),
                  title: Text(context.l10n.export.toUpperCase()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryButton(
              backgroundGradient: AppColors.blackishGradient(),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  const Icon(
                    Iconsax.share,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.l10n.accountShare,
                    style: context.textTheme.displaySmall?.copyWith(color: Colors.white),
                  ),
                  const Spacer(),
                  const Icon(
                    Iconsax.more,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28,
        right: 28,
        bottom: 60,
        top: 10,
      ),
      child: PrimaryButton(
        onPressed: () => _onButtonClicked(context),
        child: Text(
          context.l10n.choosYourCommunity,
          style: context.textTheme.displaySmall!.copyWith(
            color: context.colorScheme.background,
          ),
        ),
      ),
    );
  }

  void _onButtonClicked(BuildContext context) {
    Navigator.pushNamed(
      context,
      CommunityChooserOnMap.route,
      arguments: const CommunityChooserOnMapArgs(isFirstTime: true),
    );
  }
}
