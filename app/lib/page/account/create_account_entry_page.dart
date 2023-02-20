import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:encointer_wallet/common/components/logo/encointer_logo.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/create_account_page.dart';
import 'package:encointer_wallet/page/account/import/import_account_page.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CreateAccountEntryPage extends StatelessWidget {
  const CreateAccountEntryPage({super.key});

  static const String route = '/account/entry';

  @override
  Widget build(BuildContext context) {
    const mosaicBackground = 'assets/nctr_mosaic_background.svg';
    final dic = I18n.of(context)!.translationsForLocale();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              mosaicBackground,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
            const EncointerLogo(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                      key: const Key('create-account'),
                      child: Text(I18n.of(context)!.translationsForLocale().home.create,
                          style: Theme.of(context).textTheme.displaySmall),
                      onPressed: () {
                        Navigator.pushNamed(context, CreateAccountPage.route);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${dic.profile.doYouAlreadyHaveAnAccount} ',
                        style: TextStyle(
                          color: zurichLion.shade50,
                        ),
                      ),
                      GestureDetector(
                        key: const Key('import-account'),
                        child: Text(
                          I18n.of(context)!.translationsForLocale().profile.import,
                          style: TextStyle(
                            color: zurichLion.shade50,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () => Navigator.pushNamed(context, ImportAccountPage.route),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
