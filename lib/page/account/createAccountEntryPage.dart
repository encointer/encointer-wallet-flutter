import 'package:encointer_wallet/page/account/create/createAccountPage.dart';
import 'package:encointer_wallet/page/account/import/importAccountPage.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateAccountEntryPage extends StatelessWidget {
  static final String route = '/account/entry';

  @override
  Widget build(BuildContext context) {
    final String encointerLogo = 'assets/encointer_logo_orig.svg';
    final String kacheln = 'assets/Kacheln.svg';

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SvgPicture.asset(
              kacheln,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: SvgPicture.asset(
                encointerLogo,
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
                  key: Key('import-account'),
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: TextButton(
                    child: Text(
                      I18n.of(context).home['import'],
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Color(0xffF4F8F9),
                          ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ImportAccountPage.route);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
