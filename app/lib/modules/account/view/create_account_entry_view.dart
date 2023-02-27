import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/button/custom_button.dart';
import 'package:encointer_wallet/common/components/logo/encointer_logo.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page/account/import/import_account_page.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CreateAccountEntryView extends StatelessWidget {
  const CreateAccountEntryView({super.key});

  static const String route = '/account/entry';
  static const _mosaicBackground = 'assets/images/assets/kacheln.png';

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(_mosaicBackground), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            const Spacer(),
            const EncointerLogo(),
            const Spacer(),
            CustomButton(
              key: const Key('create-account'),
              backgroundColor: Colors.white,
              onPressed: () => Navigator.pushNamed(context, CreateAccountView.route, arguments: false),
              foregroundColor: colorScheme.primary,
              textStyle: textTheme.displaySmall,
              child: Text(dic.home.create),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${dic.profile.doYouAlreadyHaveAnAccount} ',
                  style: TextStyle(color: zurichLion.shade50),
                ),
                InkWell(
                  key: const Key('import-account'),
                  onTap: () => Navigator.pushNamed(context, ImportAccountPage.route),
                  child: Text(
                    dic.profile.import,
                    style: TextStyle(color: zurichLion.shade50, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
