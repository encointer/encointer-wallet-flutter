import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/router/app_router.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class WalletApp extends StatelessWidget {
  const WalletApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Observer(builder: (_) {
        return MaterialApp(
          title: 'EncointerWallet',
          locale: context.watch<AppSettings>().locale,
          localizationsDelegates: [
            AppLocalizationsDelegate(context.watch<AppSettings>().locale),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: context.watch<AppSettings>().locales,
          initialRoute: context.watch<AppStore>().config.initialRoute,
          theme: appThemeEncointer,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          onGenerateRoute: AppRoute.onGenerateRoute,
        );
      }),
    );
  }
}
