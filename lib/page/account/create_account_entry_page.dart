import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/create_account_page.dart';
import 'package:encointer_wallet/page/account/import/import_account_page.dart';
import 'package:encointer_wallet/utils/encointer_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccountEntryPage extends StatefulWidget {
  const CreateAccountEntryPage({super.key});

  static const String route = '/account/entry';

  @override
  State<CreateAccountEntryPage> createState() => _CreateAccountEntryPageState();
}

class _CreateAccountEntryPageState extends State<CreateAccountEntryPage> with EncointerStateMixin {
  @override
  Widget build(BuildContext context) {
    const nctrLogo = 'assets/nctr_logo.svg';
    const mosaicBackground = 'assets/nctr_mosaic_background.svg';

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              mosaicBackground,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: SvgPicture.asset(
                nctrLogo,
                color: Colors.white,
                width: 210,
                height: 210,
              ),
            ),
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
                      child: Text(localization.home.create, style: Theme.of(context).textTheme.displaySmall),
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
                        '${localization.profile.doYouAlreadyHaveAnAccount} ',
                        style: TextStyle(
                          color: zurichLion.shade50,
                        ),
                      ),
                      GestureDetector(
                        key: const Key('import-account'),
                        child: Text(
                          localization.profile.import,
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
