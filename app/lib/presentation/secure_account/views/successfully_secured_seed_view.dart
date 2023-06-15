import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_on_map.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SuccesfullySecuredSeedView extends StatelessWidget {
  const SuccesfullySecuredSeedView({super.key});

  static const route = 'succesfully-secured-seed';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const SecureAccountTitle(
                  title: 'Congratulations!',
                ),
                const SizedBox(height: 20),
                Text(
                  'You have successfully secured your account. Remember to keep your recovery secret phrase safe.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You are responsible for this!',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Please note that Encointer cannot recover your account if you get locked out.',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You can find your secret recovery phrase in your profile under «export».',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 20),
                _exportTutorial(context, dic)
              ],
            ),
          ),
          _button(context),
        ],
      ),
    );
  }

  Widget _exportTutorial(BuildContext context, Translations dic) {
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
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Iconsax.trash),
                  title: Text('Delete'),
                ),
                ListTile(
                  leading: Icon(Iconsax.export),
                  title: Text('Export'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: PrimaryButton(
              backgroundGradient: AppColors.blackishGradient(),
              onPressed: null,
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  const Icon(
                    Iconsax.share,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    dic.profile.accountShare,
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
          'Choose your community',
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
