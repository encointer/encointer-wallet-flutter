import 'package:encointer_wallet/page/account/create/createAccountPage.dart';
import 'package:encointer_wallet/page/account/import/importAccountPage.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccountEntryPage extends StatelessWidget {
  static final String route = '/account/entry';

  @override
  Widget build(BuildContext context) {
    final String nctrLogo = 'assets/nctr_logo.svg';
    final String mosaicBackground = 'assets/nctr_mosaic_background.svg';

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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                          key: Key('create-account'),
                          child: Text(I18n.of(context).home['create'], style: Theme.of(context).textTheme.headline3),
                          onPressed: () {
                            Navigator.pushNamed(context, CreateAccountPage.route);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${I18n.of(context).profile['account.have']} ',
                              style: TextStyle(
                                //todo define color
                                color: Color(0xffF4F8F9),
                              ),
                            ),
                            TextSpan(
                              text: I18n.of(context).profile['import'],
                              style: TextStyle(
                                //todo define color
                                color: Color(0xffF4F8F9),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, ImportAccountPage.route);
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
