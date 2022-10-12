import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/router/app_router.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AppAlert {
  static bool disActive = true;
  static Future<void> restart() async {
    if (AppRoute.navState.currentContext != null && disActive) {
      disActive = false;
      final dic = I18n.of(AppRoute.navState.currentContext!)!.translationsForLocale();
      return showCupertinoDialog(
        barrierDismissible: false,
        context: AppRoute.navState.currentContext!,
        builder: (context) => CupertinoAlertDialog(
          title: Text(dic.home.restart),
          content: Text(dic.home.restartDes),
          actions: <Widget>[
            CupertinoButton(
              onPressed: () async {
                disActive = true;
                await Navigator.pushAndRemoveUntil(
                    context, CupertinoPageRoute(builder: (context) => const SplashView()), (route) => false);
              },
              child: Text(dic.home.ok),
            ),
          ],
        ),
      );
    }
  }
}
